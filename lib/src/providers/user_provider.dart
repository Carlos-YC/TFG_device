import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:device_selection/src/config/config.dart';
import 'package:device_selection/src/dialog/display_dialog.dart';

class UserProvider {
  static final _auth = SupermarketApp.auth;
  final userDatabaseReference =
      FirebaseDatabase.instance.reference().child('usuarios').child('admins');

  Future<void> login(BuildContext context, User user, String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((auth) {
      user = auth.user;
    }).catchError((onError) {
      DisplayDialog.displayErrorDialog(context, onError.message.toString());
    });
    if (user != null) {
      await getUserInfo(context, user);
    }
  }

  Future<void> logOut(BuildContext context) async {
    await SupermarketApp.auth.signOut().then((value) async {
      await _deleteSessionInfo();
      Get.offAllNamed('login');
    });
  }

  Future getUserInfo(BuildContext context, User user) async {
    userDatabaseReference.child(user.uid).once().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        await SupermarketApp.sharedPreferences
            .setString(SupermarketApp.userUID, snapshot.value[SupermarketApp.userUID]);
        await SupermarketApp.sharedPreferences
            .setString(SupermarketApp.userEmail, snapshot.value[SupermarketApp.userEmail]);
        await SupermarketApp.sharedPreferences
            .setString(SupermarketApp.marketId, snapshot.value[SupermarketApp.marketId]);

        Get.offAllNamed('home');
      } else {
        DisplayDialog.displayErrorDialog(context, 'Los datos no son validos');
      }
    });
  }

  Future _deleteSessionInfo() async {
    await SupermarketApp.sharedPreferences.setString(SupermarketApp.userUID, 'uid');
    await SupermarketApp.sharedPreferences.setString(SupermarketApp.userEmail, 'email');
    await SupermarketApp.sharedPreferences.setString(SupermarketApp.marketId, 'marketid');
  }
}
