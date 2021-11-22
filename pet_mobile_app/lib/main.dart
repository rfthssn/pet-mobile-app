import 'package:flutter/material.dart';
import 'package:pet_mobile_app/auth/login.dart';
import 'package:pet_mobile_app/screens/weight_chart/weight_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(MaterialApp(
      title: 'Pet Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: token == null ? LoginPage() : WeightGraph()
  ));
}