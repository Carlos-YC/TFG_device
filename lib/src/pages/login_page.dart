import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:device_selection/src/dialog/display_dialog.dart';
import 'package:device_selection/src/providers/user_provider.dart';
import 'package:device_selection/src/widget/custom_text_field_widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(75.0),
          child: _loginForm(context),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: SingleChildScrollView(
        child: Container(
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
            color: Color(0xFF97f48a),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.5, 1.5),
                spreadRadius: 3.0,
              )
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              _customForm(),
              SizedBox(height: 60.0),
              _createButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: _emailTextEditingController,
              data: Icons.email_outlined,
              hintText: 'Correo electrónico',
              isObscure: false,
            ),
            SizedBox(height: 30.0),
            CustomTextField(
              controller: _passwordTextEditingController,
              data: Icons.lock_outline,
              hintText: 'Contraseña',
              isObscure: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0.0,
        primary: Colors.green,
        textStyle: TextStyle(color: Color(0xFF3f4756)),
      ),
      onPressed: () {
        _emailTextEditingController.text.isNotEmpty &&
                _passwordTextEditingController.text.isNotEmpty
            ? _login(context)
            : DisplayDialog.displayErrorDialog(context, 'Rellene todos los campos');
      },
    );
  }

  void _login(BuildContext context) async {
    User user;

    String _email = _emailTextEditingController.text.trim();
    String _password = _passwordTextEditingController.text.trim();
    await UserProvider().login(context, user, _email, _password);
  }
}
