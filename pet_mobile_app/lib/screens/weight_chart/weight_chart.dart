import 'package:flutter/material.dart';
import 'package:pet_mobile_app/auth/login.dart';
import 'package:pet_mobile_app/models/weight_model.dart';
import 'package:pet_mobile_app/screens/weight_chart/add_weight_button_.dart';
import 'package:pet_mobile_app/screens/weight_chart/show_chart.dart';
import 'package:pet_mobile_app/shared/app_bar.dart';
import 'package:pet_mobile_app/shared/language.dart';
import 'package:pet_mobile_app/ui/SideNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:pet_mobile_app/api/link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WeightGraph extends StatefulWidget {
  const WeightGraph({Key? key}) : super(key: key);

  @override
  _WeightGraphState createState() => _WeightGraphState();
}

class _WeightGraphState extends State<WeightGraph> {
  bool _isLoading = false;
  late final Future futureWeights = getWeight(widget);
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: PetDemoAppBar(
          title: Language.appStrings['weight_chart'] ?? "Weight Graph"),
      body: Center(
          child: FutureBuilder(
        future: futureWeights,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return loadGraph(snapshot.data);
          } else {
            return Align(
                alignment: Alignment.center,
                child: AddWeightButton());

          }
        },
      )),
    );
  }

  Container loadGraph(List<Weight> weights) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Weight Graph",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ShowChart(data: weights),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: AddWeightButton())
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<List<Weight>> getWeight(widget) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    List<Weight> weights = [];
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '${token}',
    };
    var jsonResponse = null;
    var response =
        await http.get(Uri.parse(App_Url.getWeights), headers: headers);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        for (var data in jsonResponse) {
          Weight weight =
              Weight(weightInKg: data['weight_in_kg'], date: data['date']);
          weights.add(weight);
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    return weights;
  }
}
