// login screen

// ignore_for_file: file_names

// import 'dart:ffi';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HomeScreenPhotos {
  var photo_name;
  var id;
  HomeScreenPhotos({this.photo_name, this.id});
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var no_of_images = 0;
  var image_list = [];

  Future<List<HomeScreenPhotos>> getImageUri() async {
    List<HomeScreenPhotos> name_list = [];
    var new_name_list = [];
    print('inside future function');
    final url = Uri.parse('http://192.168.1.10:5000/urlfetch/getlinks');
    http.Response response = await http.get(url);
    print(response.body);
    var respdata = json.decode(response.body);
    print(respdata);

    for (var i = 0; i < respdata.length; i++) {
      print("inside for loop");
      print(respdata[i]['imageName']);
      print(respdata[i]);
      HomeScreenPhotos temp1 =
          new HomeScreenPhotos(photo_name: respdata[i]['imageName'], id: i);
      name_list.add(temp1);
      new_name_list.add(respdata[i]['imageName']);
    }
    setState() {
      no_of_images = respdata.length;
      image_list = new_name_list;
    }

    print("named list -> ");
    print(name_list[0]);
    return name_list;
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

        // ignore: avoid_unnecessary_containers
        // SizedBox(
        //   child: FutureBuilder(
        //     builder:(BuildContext ctx, AsyncSnapshot snapshot) {
        //       if
        //     }),
        // ),

        // CarouselSlider(
        //   items: [
        //     // for(var i=0; i<)
        //     Card(
        //       child: Image.network(
        //           'https://4.imimg.com/data4/WA/YP/GLADMIN-14324829/touch-screen-500x500.png'),
        //     ),
        //   ],
        //   options: CarouselOptions(
        //     height: 200,
        //     autoPlay: true,
        //     enableInfiniteScroll: true,
        //   ),
        // ),
        FutureBuilder(
          future: getImageUri(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData != true) {
              // log(snapshot);
              log("data was not there in the snapshot");
              return Container(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Text(snapshot.data[index].photo_name),
                    Container(
                      height: 200,
                      width: screen_width,
                      child: Card(
                        child: Image.network(
                            "http://192.168.1.10:5000/static/media/" +
                                snapshot.data[index].photo_name),
                      ),
                    )
                  ],
                ),
              );
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
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
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

