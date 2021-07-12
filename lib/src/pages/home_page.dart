import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:device_selection/src/providers/turn_provider.dart';
import 'package:device_selection/src/providers/supermarket_services_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder(
          future: SupermarketServicesProvider().supermarketServices(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<Widget> listServices = [];
              snapshot.data.map((service) {
                if (!service.isBlank) {
                  listServices.add(_boxButton(service));
                }
              }).toString();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _title('Seleccionar turno'),
                  SizedBox(height: 50.0),
                  Expanded(
                    child: ListView(children: listServices),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _boxButton(String service) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 130.0),
        child: InkWell(
          onTap: () => TurnProvider().createTurn(service),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: () {
                if (service == 'carniceria') {
                  return Colors.red[300];
                } else if (service == 'charcuteria') {
                  return Colors.orange[300];
                } else if (service == 'pescaderia') {
                  return Colors.blue[300];
                }
              }(),
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.5, 1.5),
                  spreadRadius: 3.0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  height: 100,
                  image: AssetImage(
                    () {
                      if (service == 'carniceria') {
                        return 'assets/images/meat.png';
                      } else if (service == 'charcuteria') {
                        return 'assets/images/jammed.png';
                      } else if (service == 'pescaderia') {
                        return 'assets/images/fish.png';
                      }
                    }(),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  () {
                    if (service == 'carniceria') {
                      return 'Carnicería';
                    } else if (service == 'charcuteria') {
                      return 'Charcutería';
                    } else if (service == 'pescaderia') {
                      return 'Pescadería';
                    }
                  }(),
                  style: TextStyle(fontSize: 65, color: Color(0xFF3f4756)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
