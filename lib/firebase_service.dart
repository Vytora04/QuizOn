import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  // static DatabaseReference get database => FirebaseDatabase.instance.ref(); // For Realtime DB
}