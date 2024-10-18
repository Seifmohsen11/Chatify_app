import 'dart:async';

import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/chatBackground.jpg"),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Center(
                    child: Image.asset(
                      "assets/images/text-message-icon.png",
                      height: 200,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Chatify',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Pacifico"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
