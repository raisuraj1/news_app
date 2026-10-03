//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/commons/common_colors.dart';
import 'package:news_app/screens/home_screen.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //spacing: 20,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: .circular(15)),
            child: Image.asset(
              "assets/image.jpg",
              height: 600,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Bringing the world's new to your fingerprint",
              textAlign: .center,
              style: TextStyle(fontSize: 26, fontWeight: .bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              textAlign: .center,
              "Taky your time , the world's stories waiting for you",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                ),
                child: Text("Get Started"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
