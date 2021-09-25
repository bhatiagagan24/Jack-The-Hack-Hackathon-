import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Assistance extends StatelessWidget {
  const Assistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Assistance"),
        centerTitle: true,
      ),
      body: GridView.count(crossAxisCount: 2, children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(30)),
                    FaIcon(
                      FontAwesomeIcons.wheelchair,
                      color: Colors.purple[200],
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text("WheelChair")
                  ],
                ),
              )),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(30)),
                    FaIcon(
                      FontAwesomeIcons.medkit,
                      color: Colors.purple[200],
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text("First Aid")
                  ],
                ),
              )),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(30)),
                    FaIcon(
                      FontAwesomeIcons.wheelchair,
                      color: Colors.purple[200],
                    ),
                    // ignore: prefer_const_constructors
                    Padding(padding: EdgeInsets.all(20)),
                    Text("WheelChair")
                  ],
                ),
              )),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(30)),
                    FaIcon(
                      FontAwesomeIcons.wheelchair,
                      color: Colors.purple[200],
                    ),
                    // ignore: prefer_const_constructors
                    Padding(padding: EdgeInsets.all(20)),
                    Text("WheelChair")
                  ],
                ),
              )),
        )
      ]),
    );
  }
}
