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
                  // this is future scope You have to use Localizations given from Flutter. You have to use custom delegate 
                  // and JSON files for your supported languages. Implement it by using bloc Steps to follow,
                  // 1. Create a folder assets/languages/ in the root folder
                  // 2. Create JSON files for your supported languages. Like: en.json, es.json
                // 3. Create a key, value pairs for your strings in each file accordingly with their specific languages strings.
                // 4. In main.dart create default locale, supportedLocales and localizationsDelegates.
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
