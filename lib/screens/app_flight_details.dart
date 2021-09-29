import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart';

class FlightDetails extends StatefulWidget {
  String? flight_src;
  var user_name, user_email;
  FlightDetails(
      {Key? key,
      this.flight_src,
      @required this.user_name,
      @required this.user_email})
      : super(key: key);

  @override
  _FlightDetailsState createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  String? _setTime, _setDate;
  TextEditingController _timeController = TextEditingController();
  String? _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _flightno = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = "$_hour" + ' : ' + "$_minute";
        _timeController.text = "$_time";
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    String flight_src = "${widget.flight_src}";
    String user_name = widget.user_name;
    String user_email = widget.user_email;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flight Details",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20)),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Quick Flight Details"),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Flight Number"),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: _flightno,
              decoration: InputDecoration(
                  hintText: "Enter Flight Number",
                  border: OutlineInputBorder()),
            ),
          ),
          // Column(
          //   children: <Widget>[
          //     Text(
          //       'Choose Departure Time',
          //       style: TextStyle(
          //           fontStyle: FontStyle.italic,
          //           fontWeight: FontWeight.w600,
          //           letterSpacing: 0.5),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         _selectTime(context);
          //       },
          //       child: Container(
          //         margin: EdgeInsets.all(10),
          //         // width: _width / 1.7,
          //         // height: _height / 9,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(color: Colors.grey[200]),
          //         child: TextFormField(
          //           style: TextStyle(fontSize: 40),
          //           textAlign: TextAlign.center,
          //           onSaved: (String? val) {
          //             _setTime = "$val";
          //           },
          //           enabled: false,
          //           keyboardType: TextInputType.text,
          //           controller: _timeController,
          //           decoration: InputDecoration(
          //               disabledBorder:
          //                   UnderlineInputBorder(borderSide: BorderSide.none),
          //               // labelText: 'Time',
          //               contentPadding: EdgeInsets.all(5)),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            sendData(_flightno.text, user_name, user_email);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => FlightDetails()),
            // );
          },
          child: Text('Next'),
        ),
      ),
    );
  }

  Future<void> sendData(
      String? flight_number, String? user_name, String? user_email) async {
    Map<String, String> queryParams = {
      "flight_code": "$flight_number",
      "username": widget.user_name,
      "email": widget.user_email
    };
    // var uri = Uri.parse('http://192.168.1.22:5000/');
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/user/add/trip?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    print(response.body);
  }
}
