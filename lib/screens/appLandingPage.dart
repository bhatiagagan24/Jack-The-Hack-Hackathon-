// login screen

// ignore_for_file: file_names

// import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen_width = MediaQuery.of(context).size.width;
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
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
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
                ),
                // Padding(padding: EdgeInsets.all(50)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Guest'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen.shade300),
                  ),
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
              // ElevatedButton(onPressed: () {}, child: Text('yo')),
              // ButtonTheme(
              //   minWidth: 200,
              //   height: 400,
              //   child: ElevatedButton.icon(
              //     onPressed: () {},
              //     icon: Icon(Icons.help),
              //     label: Text('Help'),
              //   ),

              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.help),
                        Text('Help'),
                      ],
                    ),
                    height: 60,
                    minWidth: (screen_width / 2) - 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.group),
                        Text('About Us'),
                      ],
                    ),
                    height: 60,
                    minWidth: (screen_width / 2) - 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

// this model sheet pops up when Google sign-in button pressed

