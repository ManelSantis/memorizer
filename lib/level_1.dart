import 'package:flutter/material.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x433C57FF),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Memorizer",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lexend Mega',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Level 1",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lexend Mega',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}