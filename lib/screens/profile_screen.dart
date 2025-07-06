import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../models/user.dart';

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
    final User? user = widget.authService.currentUser;
    final String displayName = user?.username ?? 'Tamu';
    final int highScore = user?.highScore ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan Profil',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
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
                      child: Icon(Icons.person, size: 40, color: kPrimaryColor),
                    ),
                    const SizedBox(height: kSpacingM),
                    Text(
                      displayName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: kSpacingS),
                    Text(
                      'Skor Tertinggi: $highScore',
                      style: GoogleFonts.poppins(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: kSpacingM),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.info, color: kPrimaryColor),
                      title: Text(
                        'Nama Pengguna',
                        style: GoogleFonts.poppins(),
                      ),
                      subtitle: Text(displayName, style: GoogleFonts.poppins()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.star, color: kPrimaryColor),
                      title: Text('Skor Terbaik', style: GoogleFonts.poppins()),
                      subtitle: Text(
                        highScore.toString(),
                        style: GoogleFonts.poppins(),
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
                label: Text(
                  'Ubah Kata Sandi',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                onPressed: _isLoading
                    ? null
                    : () => _showChangePasswordDialog(context),
                style: ElevatedButton.styleFrom(
                  padding: kPaddingM,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusM),
                  ),
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  elevation: kElevationM,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Ubah Kata Sandi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller:
                      currentPasswordController, // Use specific controller
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi Saat Ini',
                    labelStyle: GoogleFonts.poppins(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: kSpacingM),
                TextFormField(
                  controller: newPasswordController, // Use specific controller
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi Baru',
                    labelStyle: GoogleFonts.poppins(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Wajib diisi';
                    if (value!.length < 6) return 'Minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: kSpacingM),
                TextFormField(
                  controller:
                      confirmNewPasswordController, // Use specific controller
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Kata Sandi Baru',
                    labelStyle: GoogleFonts.poppins(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != newPasswordController.text) {
                      // Compare with newPasswordController
                      return 'Kata sandi tidak cocok';
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
            child: Text('Batal', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await _changePassword(
                        context,
                        currentPasswordController.text, // Use controller text
                        newPasswordController.text, // Use controller text
                      );
                    }
                  },
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Perbarui',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
          ),
        ],
      ),
    ).whenComplete(() {
      // Changed .then to .whenComplete for more reliable disposal
      // Dispose controllers when dialog closes, regardless of how it closes
      currentPasswordController.dispose();
      newPasswordController.dispose();
      confirmNewPasswordController.dispose();
    });
  }

  Future<void> _changePassword(
    BuildContext context,
    String currentPassword,
    String newPassword,
  ) async {
    setState(() => _isLoading = true);

    try {
      final String? username = widget.authService.currentUser?.username;
      if (username == null) {
        throw Exception(
          'Tidak ada pengguna yang masuk untuk mengubah kata sandi.',
        );
      }

      final bool success = await widget.authService.changePassword(
        username: username,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (context.mounted) {
        if (success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kata sandi berhasil diperbarui')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Gagal memperbarui kata sandi. Kata sandi saat ini mungkin salah.',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
