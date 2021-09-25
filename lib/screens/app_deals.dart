import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deals extends StatefulWidget {
  const Deals({Key? key}) : super(key: key);

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[200],
          title: Text("Deals"),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          DropdownButton<String>(
            alignment: Alignment.topCenter,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                onTap: () {
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
                child: Container(
                  //Container to resize the
                  padding: EdgeInsets.all(10),
                  height: 300,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                            //Container for Circular Image
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        "https://assets.turbologo.com/blog/en/2020/01/19084716/armani-logo-cover-958x575.png")))),
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                        Text(
                          "Emporio Armani",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ]));
  }
}
