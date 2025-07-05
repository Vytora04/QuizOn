import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  final AuthService authService;
  const ProfileScreen({super.key, required this.authService});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.authService.currentUser;
    final displayName = user?.displayName ?? 
                       user?.email?.split('@').first ?? 
                       'Guest';

    return Padding(
      padding: kPaddingL,
      child: Column(
        children: [
          Card(
            elevation: kElevationM,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadiusM),
            ),
            child: Padding(
              padding: kPaddingL,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: kSpacingM),
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: kSpacingS),
                  if (user?.email != null)
                    Text(
                      user!.email!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  const SizedBox(height: kSpacingM),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.vpn_key, color: kPrimaryColor),
                    title: const Text('User ID'),
                    subtitle: Text(
                      user?.uid ?? 'Not available',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpacingL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.lock),
              label: const Text('Change Password'),
              onPressed: _isLoading ? null : () => _showChangePasswordDialog(context),
              style: ElevatedButton.styleFrom(
                padding: kPaddingM,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusM),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controllers = {
      'current': TextEditingController(),
      'new': TextEditingController(),
      'confirm': TextEditingController(),
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controllers['current'],
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => 
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: kSpacingM),
                TextFormField(
                  controller: controllers['new'],
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Required';
                    if (value!.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: kSpacingM),
                TextFormField(
                  controller: controllers['confirm'],
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != controllers['new']?.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : () async {
              if (formKey.currentState?.validate() ?? false) {
                await _changePassword(
                  context,
                  controllers['current']!.text,
                  controllers['new']!.text,
                );
              }
            },
            child: _isLoading 
                ? const CircularProgressIndicator()
                : const Text('Update'),
          ),
        ],
      ),
    ).then((_) {
      // Clean up controllers when dialog closes
      for (var controller in controllers.values) {
        controller.dispose();
      }
    });
  }

  Future<void> _changePassword(
    BuildContext context,
    String currentPassword,
    String newPassword,
  ) async {
    setState(() => _isLoading = true);

    try {
      await widget.authService.changePassword( 
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (context.mounted) {
        Navigator.pop(context); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Password change failed';
      if (e.code == 'wrong-password') {
        message = 'Current password is incorrect';
      } else if (e.code == 'requires-recent-login') {
        message = 'Please re-authenticate to change password';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}