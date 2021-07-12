import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupermarketApp {
  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseDatabase database;

  static final String userUID = 'uid';
  static final String userEmail = 'email';
  static final String marketId = 'marketid';
}
