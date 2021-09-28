import 'package:flutter/material.dart';

import './app_airport_select.dart';

class SignedInHome extends StatefulWidget {
  List AirportList;
  SignedInHome({Key? key, required this.AirportList}) : super(key: key);

  @override
  _SignedInHomeState createState() => _SignedInHomeState();
}

class _SignedInHomeState extends State<SignedInHome> {
  int selectedIndex = -1;
  String? choosen_option;

  get AirportList => null;
  @override
  void initState() {
    // TODO: implement initState
    print(widget.AirportList);
  }

  @override
  Widget build(BuildContext context) {
    List AirportList = widget.AirportList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Airport",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
      ),
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
                  color: Colors.purple),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Where are you flying from?",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.purple[100]),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Expanded(
              child: GridView.builder(
                  itemCount: AirportList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext ct, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          choosen_option = AirportList[index];
                        });
                      },
                      child: Container(
                        //Container to resize the
                        padding: EdgeInsets.all(20),
                        child: Card(
                          shape: (selectedIndex == index)
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.green))
                              : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                          child: Center(child: Text(AirportList[index])),
                        ),
                      ),
                    );
                  })),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AirportSelect(
                          AirportList: this.widget.AirportList,
                          user_email: '',
                          user_name: '',
                        )),
              );
            },
            child: Text('I want to Explor'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (choosen_option!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please choose Airport')));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AirportSelect(
                            AirportList: this.AirportList,
                            user_email: '',
                            user_name: '',
                          )));
            }
          },
          child: Text('Next'),
        ),
      ),
    );
  }
}
