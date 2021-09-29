import 'package:flutter/material.dart';
import 'package:smart_journey_experience/SupportClasses/Deal.dart';

class DealCard extends StatelessWidget {
  Deal? deal;
  DealCard({Key? key, @required this.deal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            //Container for Circular Image
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        new NetworkImage("${deal!.photo}")))),
                        Text("${deal!.Shop_name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25))
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('${deal!.heading}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('${deal!.simple_Text}', style: TextStyle(fontSize: 20))
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 600,
        //Container to resize the
        padding: EdgeInsets.all(5),
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
                  width: 70.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage("${deal!.photo}")))),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
              Text(
                "${deal!.Shop_name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
