import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredModel extends StatefulWidget {
  @override
  _PredModelState createState() => _PredModelState();
}

class _PredModelState extends State<PredModel> {
  var predValue = "";

  @override
  void initState() {
    super.initState();
    predValue = "Click Predict Button";
  }

  final N_Controller = TextEditingController();
  final P_Controller = TextEditingController();
  final K_Controller = TextEditingController();
  final Temp_Controller = TextEditingController();
  final Humidity_Controller = TextEditingController();
  final Ph_Controller = TextEditingController();
  final Rain_Controller = TextEditingController();

  Future<void> predData() async {
    final interpreter = await Interpreter.fromAsset('ml_model.tflite');
    var N_ = double.parse(N_Controller.text);
    var P_ = double.parse(P_Controller.text);
    var K_ = double.parse(K_Controller.text);
    var Temp_ = double.parse(Temp_Controller.text);
    var Humidity_ = double.parse(Humidity_Controller.text);
    var Ph_ = double.parse(Ph_Controller.text);
    var Rain_ = double.parse(Rain_Controller.text);

    var input = [
      [N_, P_, K_, Temp_, Humidity_, Ph_, Rain_]
    ];

    var output = List.filled(22, 0).reshape([1, 22]);
    interpreter.run(input, output);

    var x = 0;
    var max = output[0][0];
    var index = 0;
    for (x; x < 22; x++) {
      if (output[0][x] > max) {
        max = output[0][x];
        index = x;
      }
    }

    this.setState(() {
      if (index == 0) predValue = 'Apple';
      if (index == 1) predValue = 'Banana';
      if (index == 2) predValue = 'Black Gram';
      if (index == 3) predValue = 'Chickpea';
      if (index == 4) predValue = 'Coconut';
      if (index == 5) predValue = 'Coffee';
      if (index == 6) predValue = 'Cotton';
      if (index == 7) predValue = 'Grapes';
      if (index == 8) predValue = 'Jute';
      if (index == 9) predValue = 'Kidney Beans';
      if (index == 10) predValue = 'Lentil';
      if (index == 11) predValue = 'Maize';
      if (index == 12) predValue = 'Mango';
      if (index == 13) predValue = 'Moth Beans';
      if (index == 14) predValue = 'Mungbean';
      if (index == 15) predValue = 'Muskmelon';
      if (index == 16) predValue = 'Orange';
      if (index == 17) predValue = 'Papaya';
      if (index == 18) predValue = 'Pigeon Peas';
      if (index == 19) predValue = 'Pomegranate';
      if (index == 20) predValue = 'Rice';
      if (index == 21) predValue = 'Watermelon';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Predictor'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Color.fromARGB(255, 248, 249, 195),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.0),
              Text(
                'Enter the nutrient content and environmental conditions:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: N_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nitrogen Content',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: P_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phosphorus Content',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: K_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Potassium Content',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: Temp_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Temperature',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: Humidity_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Humidity Content',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: Ph_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'pH Value',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: Rain_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Rainfall Content',
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: predData,
                child: Text(
                  'Predict',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Predicted Crop: $predValue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
