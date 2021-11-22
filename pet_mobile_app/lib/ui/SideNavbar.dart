import 'package:flutter/material.dart';
import 'package:pet_mobile_app/auth/login.dart';
import 'package:pet_mobile_app/shared/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Side menu',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(Language.appStrings['logout'] ?? "Logout"),
            onTap: () => {
              Logout(),
              Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    (Route<dynamic> route) => false)

            },
          ),
        ],
      ),
    );
  }

 Logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
      }
}