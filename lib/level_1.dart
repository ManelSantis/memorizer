import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => startTimer());
    //startTimer();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 60);
  @override
  Widget build(BuildContext context) {

    //Timer
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));


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
        onPressed: () {
          resetTimer(60);
          startTimer();
        },
        tooltip: 'Start Again',
        child: const Icon(FontAwesomeIcons.arrowRotateLeft),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
             // width: 323,
              height: 73,
              child:  Stack(
                children: [
                  Positioned(
                    left: 87,
                    top: 34,
                    child: SizedBox(
                      width: 145,
                      height: 39,
                      child: Text(
                        '${int.parse(minutes) > 0 ? "$minutes:" : ''}$seconds ${myDuration.inSeconds<=60? "s": ''} ',
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
                      'Score:10',
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
            ElevatedButton(
              onPressed: startTimer,
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //==============
  //countdown code
  //==============

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer(int time) {
    stopTimer();
    setState(() => myDuration = Duration(seconds: time));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

}
