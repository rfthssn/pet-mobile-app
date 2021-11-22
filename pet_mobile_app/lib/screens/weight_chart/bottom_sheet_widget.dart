import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_mobile_app/screens/weight_chart/weight_chart.dart';
import 'package:pet_mobile_app/shared/language.dart';
import 'package:http/http.dart' as http;
import 'package:pet_mobile_app/api/link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 5)
              ]
            ),
            child: Column(
              children: <Widget>[
                textSection(),
                addButtonSection()
              ],
            ),
          ),


        ],
      ),
    );
  }


  final TextEditingController weightController = new TextEditingController();
  DateTime _dateTime = DateTime.now();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
            RaisedButton(

              child: Text(_dateTime.day.toString() + "." + _dateTime.month.toString()+ "." + _dateTime.year.toString()),
                onPressed: (){
              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2121)
              ).then((date) {
                setState(() {
                   _dateTime = date ?? DateTime.now();
                });
              });
            }),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: weightController,
            cursorColor: Colors.orangeAccent,
            style: TextStyle(color: Colors.orangeAccent),
            decoration: InputDecoration(
              icon: Icon(Icons.apps, color: Colors.orangeAccent),
              hintText: "Weight",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent)),
              hintStyle: TextStyle(color: Colors.orangeAccent),
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),

        ],
      ),
    );
  }

  Container addButtonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: weightController.text == ""
            ? null
            : () {
          addWeight(_dateTime.toString(), int.parse(weightController.text));
        },
        elevation: 0.0,
        color: Colors.purple,
        child: Text(Language.appStrings['add']?? "Add", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Future<http.Response> addWeight(String date, int weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Map data = {'weight_in_kg': weight, 'date': date};
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '${token}',
    };
    var jsonResponse = null;
    var response = await http.post(Uri.parse(App_Url.addWeight),
        body: jsonEncode(data), headers: headers);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => WeightGraph()),
                (Route<dynamic> route) => false);
      }
    }
    return jsonResponse;
  }
}


