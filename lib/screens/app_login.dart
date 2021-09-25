// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_journey_experience/API/google_signin_api.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.black),
                onPressed: signIn,
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: Text("Sign In"))
          ]),
    );
  }

  Future signIn() async {
    await GoogleSignInApi.login();
  }
}
