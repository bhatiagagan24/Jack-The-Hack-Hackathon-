import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                "About Us",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Padding(padding: EdgeInsets.all(40)),
            Container(
              height: 450,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    // FaIcon(FontAwesomeIcons.question,
                    // size: 50.0, color: Colors.red),
                    // SizedBox(height: 40),
                    Center(
                        child: Text(
                      "Our app is based to deliver best in class marketplace experience. From contactless payments to endless amount of offers\n",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                    Padding(padding: EdgeInsets.all(45)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                        FaIcon(FontAwesomeIcons.instagram,
                            color: Colors.purple),
                        FaIcon(
                          FontAwesomeIcons.twitter,
                        )
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
              ),
            )
          ],
        ));
  }
}
