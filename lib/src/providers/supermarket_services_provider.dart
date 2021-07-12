import 'package:firebase_database/firebase_database.dart';

import 'package:device_selection/src/config/config.dart';

class SupermarketServicesProvider {
  final String marketId = SupermarketApp.sharedPreferences.getString(SupermarketApp.marketId);

  Future<List<String>> supermarketServices() async {
    List<String> servicesList = [];
    await FirebaseDatabase.instance
        .reference()
        .child(marketId)
        .child('informacion')
        .child('servicios')
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        servicesList = snapshot.value.split(',');
      }
    });
    return servicesList;
  }
}
