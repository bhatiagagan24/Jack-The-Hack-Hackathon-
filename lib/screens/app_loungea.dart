import 'package:flutter/material.dart';
import './app_assistance.dart';
import './app_lounge_dashboard.dart';
import 'package:smart_journey_experience/screens/app_flight_details.dart';

class Lounge extends StatefulWidget {
  String user_name, user_email;
  Lounge({
    Key? key,
    required this.user_name,
    required this.user_email,
  }) : super(key: key);

  @override
  _LoungeState createState() => _LoungeState();
}

class _LoungeState extends State<Lounge> {
  int selectedIndex = -1;
  String? choosen_option;

  @override
  Widget build(BuildContext context) {
    List lounge_list = [
      "Plaza Premium Lounge",
      "Plaza Premium Lounge",
      "Plaza Premium Lounge"
    ];

    return Stack(
      children: [
        // Image.network(
        //     "https://images.unsplash.com/photo-1504150558240-0b4fd8946624?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=764&q=80"),
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
                  "Welcome",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade400),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                  child: GridView.builder(
                      itemCount: lounge_list.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext ct, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              choosen_option = lounge_list[index];
                            });
                          },
                          child: Container(
                            //Container to resize the
                            padding: EdgeInsets.all(20),
                            child: Card(
                              shape: (selectedIndex == index)
                                  ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: Colors.yellow.shade400))
                                  : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                              child: Center(
                                  child: Text(lounge_list[index],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))),
                            ),
                          ),
                        );
                      })),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (choosen_option!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please choose Lounge')));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoungeDashboard(
                              user_name: widget.user_name,
                              user_email: widget.user_email,
                              name: "$choosen_option",
                            )),
                  );
                }
              },
              child: Text('Next'),
            ),
          ),
        ),
      ],
    );
  }
}
