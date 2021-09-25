// login screen

// ignore_for_file: file_names

// import 'dart:ffi';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:smart_journey_experience/screens/app_deals.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    print('Inside initstate');
    log("inside initstate");
  }

  Future<String> getImageUri() async {
    print('inside future function');
    final url = Uri.parse('http://192.168.1.10:5000/urlfetch/getlinks');
    http.Response response = await http.get(url);
    print(response.body);
    return response.body;
  }

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
                  width: screen_width,
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
                Container(
                  width: screen_width,
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
        CarouselSlider(
          items: [
            Card(
              child: Image.network(
                  'https://4.imimg.com/data4/WA/YP/GLADMIN-14324829/touch-screen-500x500.png'),
            ),
          ],
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enableInfiniteScroll: true,
          ),
        ),
        FutureBuilder(
          future: getImageUri(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              log(snapshot.data);
              return CircularProgressIndicator();
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Deals()),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text(
                          'Shopping Deals',
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    height: 60,
                    minWidth: (screen_width / 2),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),

              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.food_bank_sharp),
                        Text(
                          'Food Deals',
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    height: 60,
                    minWidth: (screen_width / 2),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),

              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.group),
                          label: Text('About Us')),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.help),
                        label: Text('Help'),
                      ),
                    ],
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

