import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoungeDashboard extends StatelessWidget {
  String user_name, user_email;
  String name;
  LoungeDashboard(
      {Key? key,
      required this.user_name,
      required this.user_email,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: new NetworkImage(
                "https://images.unsplash.com/photo-1504150558240-0b4fd8946624?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=764&q=80",
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                "Lounges",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[400]),
              )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${name}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade400),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Container(
                      //Container to resize the
                      padding: EdgeInsets.all(20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.yellow.shade400)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.checkCircle,
                              size: 40,
                              color: Colors.yellow.shade400,
                            ),
                            Center(
                                child: Text("Eligibility Check",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      //Container to resize the
                      padding: EdgeInsets.all(20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.yellow.shade400)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.utensils,
                              size: 40,
                              color: Colors.yellow.shade400,
                            ),
                            Center(
                                child: Text("Food on Menu",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}
