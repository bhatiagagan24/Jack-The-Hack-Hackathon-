import 'package:flutter/material.dart';

class Deal {
  String? Shop_name;
  String? location;
  String? heading;
  String? simple_Text;
  String? photo;
  Deal(
      {String? Shop_name,
      String? loc,
      String? heading,
      String? simple_text,
      String? photo}) {
    this.Shop_name = Shop_name;
    this.heading = heading;
    this.location = loc;
    this.simple_Text = simple_text;
    this.photo = photo;
  }
}
