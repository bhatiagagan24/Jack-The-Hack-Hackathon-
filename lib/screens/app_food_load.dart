import 'package:flutter/material.dart';
import 'package:smart_journey_experience/SupportClasses/FoodCard.dart';

class FoodLoad extends StatelessWidget {
  List food_item = [];
  FoodLoad({Key? key, required this.food_item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Lounge Food Menu",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[400]),
          )),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: food_item.length,
                itemBuilder: (BuildContext cx, index) =>
                    FoodCard(food: food_item[index])),
          )
        ],
      ),
    );
  }
}
