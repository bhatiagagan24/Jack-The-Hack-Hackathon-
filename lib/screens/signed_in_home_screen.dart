import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './app_airport_select.dart';
import 'package:http/http.dart';
import 'package:smart_journey_experience/screens/appLandingPage.dart';

class SignedInHome extends StatefulWidget {
  List AirportList;
  var username;
  var email;
  SignedInHome(
      {Key? key,
      required this.AirportList,
      required this.username,
      required this.email})
      : super(key: key);

  @override
  _SignedInHomeState createState() => _SignedInHomeState();
}

class _SignedInHomeState extends State<SignedInHome> {
  get AirportList => null;
  Future<void> send_signedIn_user_data(var user_name, var user_email) async {
    Map<String, String> queryParams = {
      "user_name": "$user_name",
      "user_email": "$user_email"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/user/add/info?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    List AirportList = widget.AirportList;
    send_signedIn_user_data(widget.username, widget.email);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.username}'s DashBoard",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AirportSelect(
                                AirportList: widget.AirportList,
                                user_name: widget.username,
                                user_email: widget.email,
                                route: "Accessibility",
                              )),
                    );
                  },
                  child: Container(
                    //Container to resize the
                    padding: EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          FaIcon(
                            FontAwesomeIcons.wheelchair,
                            color: Colors.purple[200],
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                          Text(
                            "Accessibility",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 600,
                    //Container to resize the
                    padding: EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          FaIcon(
                            FontAwesomeIcons.couch,
                            color: Colors.purple[200],
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                          Text(
                            "Lounges",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 600,
                    //Container to resize the
                    padding: EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          FaIcon(
                            FontAwesomeIcons.plane,
                            color: Colors.purple[200],
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                          Text(
                            "Past Trips",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 600,
                    //Container to resize the
                    padding: EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.purple[200],
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                          Text(
                            "Add a Trip",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 400,
                    //Container to resize the
                    padding: EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          FaIcon(
                            FontAwesomeIcons.infoCircle,
                            color: Colors.purple[200],
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                          Text(
                            "Help",
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
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(100, 0, 100, 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.qrcode,
                color: Colors.white,
              ),
              Text("Scan QR Code"),
            ],
          ),
        ),
      ),
    );
  }
}
