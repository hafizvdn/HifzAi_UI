import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_choice_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay of 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Authentication()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(25, 101, 128, 1), // Top
              Color.fromRGBO(107, 156, 173, 1),
              Color.fromRGBO(194, 214, 222, 1),
              Color.fromRGBO(255, 255, 255, 1), // Bottom
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("assets/image/HifzAI_logo-01.png"),
              ),
              SizedBox(height: 20),
              Text(
                "HifzAI",
                style: GoogleFonts.poppins(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 86, 96, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
