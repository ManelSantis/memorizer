import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      backgroundColor: const Color(0xFF433C57),
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        backgroundColor: const Color(0xFF2E2741),
        title: const Column(
          children: [
            Icon(
              FontAwesomeIcons.brain,
              color: Colors.white,
              size: 25.0,
            ),
            Text(
              'MEMORIZE',
              style: TextStyle(
                fontFamily: 'LexendMega',
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        elevation: 10,
        hoverElevation: 50,
        backgroundColor: const Color(0xFF41F393),
        onPressed: () => {},
        tooltip: 'Start Again',
        child: const Icon(FontAwesomeIcons.arrowRotateLeft),
      ),
      body: Form(
        key: _formKey,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 323,
              height: 73,
              child: const Stack(
                children: [
                  Positioned(
                    left: 87,
                    top: 34,
                    child: SizedBox(
                      width: 145,
                      height: 39,
                      child: Text(
                        '120 s',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'K2D',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 3,
                    child: SizedBox(
                      width: 56,
                      height: 25,
                      child: Text(
                        'Lvl: 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'K2D',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                   Positioned(
                    left: 217,
                    top: 0,
                    child: Text(
                      'Score:100',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'K2D',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Memorizer",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lexend Mega',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
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
