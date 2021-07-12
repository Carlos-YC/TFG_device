import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:device_selection/src/config/config.dart';

class TurnCarniceriaController extends GetxController {
  final _turnService = FirebaseDatabase.instance
      .reference()
      .child(SupermarketApp.sharedPreferences.getString(SupermarketApp.marketId))
      .child('cola_espera')
      .child('carniceria');

  StreamSubscription<Event> listener;

  RxInt lastNumber = RxInt(0);
  RxBool newTurn = RxBool(false);
  RxBool isApp = RxBool(false);
  RxBool firstClient = RxBool(false);

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
    var _lastClientList = _turnService.limitToLast(1);

    this.listener = _lastClientList.onValue.listen((event) {
      var _lastClientInfo = event.snapshot.value;

      if (_lastClientInfo != null) {
        _lastClientInfo.forEach((key, value) {
          if (value['num'] > this.lastNumber.value) {
            if (value['app']) {
              this.newTurn.value = true;
              this.isApp.value = true;
            } else {
              this.newTurn.value = true;
              this.isApp.value = false;
              (value['num'] == 1) ? this.firstClient.value = true : this.firstClient.value = false;
            }
            this.lastNumber.value = value['num'];
          } else {
            this.newTurn.value = false;
            this.lastNumber.value = value['num'];
          }
        });
      }
    });
  }
}