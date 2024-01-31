import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: Fertilizer(),
  ));
}

class Fertilizer extends StatefulWidget {
  @override
  _PredModelState createState() => _PredModelState();
}

class User {
  //dropdown
  const User(this.name);
  final String name;
}

class _PredModelState extends State<Fertilizer> {
  var predValue = "";

  @override
  void initState() {
    super.initState();
    predValue = "Click Predict Button";
  }

  final N_Controller = TextEditingController();
  final P_Controller = TextEditingController();
  final K_Controller = TextEditingController();
  final Moist_Controller = TextEditingController();
  final Temp_Controller = TextEditingController();
  final Humidity_Controller = TextEditingController();

  Future<void> Fertilizer_function() async {
    final interpreter = await Interpreter.fromAsset('fertilizer_model.tflite');

    var N_ = double.parse(N_Controller.text);
    var P_ = double.parse(P_Controller.text);
    var K_ = double.parse(K_Controller.text);
    var Moist_ = double.parse(Moist_Controller.text);
    var Temp_ = double.parse(Temp_Controller.text);
    var Humidity_ = double.parse(Humidity_Controller.text);

    var input = [
      [
        Temp_,
        Humidity_,
        Moist_,
        N_,
        K_,
        P_,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0
      ]
    ];

    var output = List.filled(7, 0).reshape([1, 7]);
    interpreter.run(input, output);

    var x = 0;
    var maax = output[0][0];
    var index = 0;
    for (x; x < 7; x++) {
      if (output[0][x] > maax) {
        maax = output[0][x];
        index = x;
      }
    }

    this.setState(() {
      if (index == 0) predValue = '10-26-26';
      if (index == 1) predValue = '14-35-14';
      if (index == 2) predValue = '17-17-17';
      if (index == 3) predValue = '20-20';
      if (index == 4) predValue = '28-28';
      if (index == 5) predValue = 'DAP';
      if (index == 6) predValue = 'Urea';
    });
  }

  User? selectedSoil;
  User? selectedCrop;

  List<User> soil = <User>[
    User('Soil Type_Black'),
    User('Soil Type_Clayey'),
    User('Soil Type_Loamy'),
    User('Soil Type_Red')
  ];

  List<User> crop = <User>[
    User('Crop Type_Barley'),
    User('Crop Type_Cotton'),
    User('Crop Type_Ground Nuts'),
    User('Crop Type_Maize'),
    User('Crop Type_Millets'),
    User('Crop Type_Oil seeds'),
    User('Crop Type_Paddy'),
    User('Crop Type_Pulses'),
    User('Crop Type_Sugarcane'),
    User('Crop Type_Tobacco'),
    User('Crop Type_Wheat')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Fertilizer Predictor'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 248, 249, 195),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter the following values",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: N_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nitrogen content',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: P_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phosphorous content',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: K_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Potassium content',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: Moist_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Moisture content',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: Temp_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Temperature',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: Humidity_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Humidity',
                ),
              ),
              SizedBox(height: 8),
              DropdownButton<User>(
                hint: Text("Select Soil Type"),
                value: selectedSoil,
                onChanged: (User? newValue) {
                  setState(() {
                    selectedSoil = newValue!;
                  });
                },
                items: soil.map((User user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(
                      user.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              DropdownButton<User>(
                hint: Text("Select Crop Type"),
                value: selectedCrop,
                onChanged: (User? newValue) {
                  setState(() {
                    selectedCrop = newValue!;
                  });
                },
                items: crop.map((User user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(
                      user.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Fertilizer_function();
                },
                child: Text('Predict'),
              ),
              SizedBox(height: 10),
              Text(
                'The Predicted Fertilizer is: $predValue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
