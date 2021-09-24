// login screen

// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
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
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          child: Center(
                            child: Text('This is the Modal Sheet'),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Google Sign-in'),
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
        Text('Contact information here in the end menu'),
        SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
              ElevatedButton(onPressed: () {}, child: Text('yo')),
            ],
          ),
        )
      ],
    );
  }
}

// this model sheet pops up when Google sign-in button pressed

