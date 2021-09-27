// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_journey_experience/API/google_signin_api.dart';
import 'package:http/http.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.black),
                onPressed: () => signIn(context),
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: Text("Sign In"))
          ]),
    );
  }

  Future<void> send_signedIn_user_data(var user_name, var user_email) async {
    Map<String, String> queryParams = {
      "user_name": "$user_name",
      "user_email": "$user_email"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.22:5000/userdatabase?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
  }

  Future signIn(BuildContext context) async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign In Failed')));
    } else {
      //user.displayName
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Welcome' + user.displayName!)));
      send_signedIn_user_data(user.displayName, user.email);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoggedInPage(user:User)));
    }
  }
}
