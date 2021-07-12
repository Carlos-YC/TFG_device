import 'package:firebase_database/firebase_database.dart';

import 'package:device_selection/src/config/config.dart';

class TurnProvider {
  final String marketId = SupermarketApp.sharedPreferences.getString(SupermarketApp.marketId);

  Future<void> createTurn(String service) async {
    final _turnRef =
        FirebaseDatabase.instance.reference().child(marketId).child('cola_espera').child(service);
    var _lastKeyRef = _turnRef.orderByChild('num').limitToLast(1);
    DateTime _timeNow = new DateTime.now();
    int _lastNumber;
    int _setNumber;

    await _lastKeyRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Map<dynamic, dynamic> _values = snapshot.value;
        _values.forEach((key, value) {
          _lastNumber = value['num'] + 1;
          _setNumber = value['tu_num'] + 1;
        });

        if (_setNumber > 99) _setNumber = 1;

        if (_lastNumber < 10) {
          _turnRef.child('${service}_00$_lastNumber').set({
            'app': false,
            'fecha': _timeNow.toString(),
            'num': _lastNumber,
            'tu_num': _setNumber,
          });
        } else if (_lastNumber > 9 && _lastNumber < 100) {
          _turnRef.child('${service}_0$_lastNumber').set({
            'app': false,
            'fecha': _timeNow.toString(),
            'num': _lastNumber,
            'tu_num': _setNumber,
          });
        } else if (_lastNumber > 99) {
          _turnRef.child('${service}_$_lastNumber').set({
            'app': false,
            'fecha': _timeNow.toString(),
            'num': _lastNumber,
            'tu_num': _setNumber,
          });
        }
      } else {
        _turnRef.child('${service}_001').set({
          'app': false,
          'fecha': _timeNow.toString(),
          'num': 1,
          'tu_num': 1,
        });
      }
    });
  }
}
