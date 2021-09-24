// login screen

// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // scrollDirection: Axis.vertical,
        // child:
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ignore: avoid_unnecessary_containers

            ButtonBar(
              alignment: MainAxisAlignment.center,
              // layoutBehavior: ,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen.shade300),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Signup'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen.shade300),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Guest'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen.shade300),
                ),
              ],
            ),
            // ),
          ],
        ),

        // HomePage banner will be added here now: -
        Text(
          'Home Page Banner Here',
        ),
        Text('The banner photos will be uploaded here by organization'),
        Text('Contact information here in the end menu')
      ],
    );
  }
}
