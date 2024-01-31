import 'package:flutter/material.dart';
import 'predModel.dart';
import 'fertilizer.dart';

class Mainscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 249, 195),
      body: Column(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/signup.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                radius: 50,
                backgroundImage: AssetImage('assets/profile1.jpg'),
              ),
            ),
          ),
          SizedBox(height: 60),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Sowhat",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PredModel()),
                    );
                  },
                  child: Text("Go to Crop Prediction"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fertilizer()),
                    );
                  },
                  child: Text("Go to Fertilizer Prediction"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add the logic for changing the language here
                  },
                  child: Text("Change Language"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
