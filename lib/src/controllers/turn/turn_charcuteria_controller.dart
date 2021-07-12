import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:device_selection/src/config/config.dart';

class TurnCharcuteriaController extends GetxController {
  final _turnService = FirebaseDatabase.instance
      .reference()
      .child(SupermarketApp.sharedPreferences.getString(SupermarketApp.marketId))
      .child('cola_espera')
      .child('charcuteria');

  StreamSubscription<Event> listener;

  @override
  void onReady() {
    this.lastClientTurn();
    super.onReady();
  }

  @override
  void onClose() {
    this.listener.cancel();
    super.onClose();
  }

  void lastClientTurn() {
    var _lastClient = _turnService.limitToLast(1);
    this.listener = _lastClient.onValue.listen((event) {});
  }
}
