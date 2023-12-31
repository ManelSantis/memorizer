import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memorizer/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_logic.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _best = 0;

  int time =60;

  Timer? countdownTimer;
  Duration myDuration =  const Duration(seconds: 5);
  final Game _game = Game();
  int score = 0;
  List<String> open = [];
  int opened = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
    _game.initGame();
    _getBestScore();
  }

  @override
  void dispose() {
    //...
    countdownTimer!.cancel();
    super.dispose();

    //...
  }

  @override
  Widget build(BuildContext context) {
    //Timer
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);

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

          //time =  time - 5;
          _game.resetGame();
          setState(() {
            score = 0;
          });
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
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                // width: 323,
                height: 73,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best: $_best',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'K2D',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 18),
                          Text(
                            '${int.parse(minutes) > 0 ? "$minutes:" : ''}$seconds${myDuration.inSeconds <= 60 ? "" : ''} ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'K2D',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Score:$score',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'K2D',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*ElevatedButton(
              onPressed: startTimer,
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),*/
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    itemCount: _game.cards!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!open.contains(_game.gameImg![index]) &&
                                (_game.matchCheck.length < 2)) {
                              _game.gameImg![index] = _game.cards[index];
                              _game.matchCheck.add({index: _game.cards[index]});
                            }
                          });
                          if (_game.matchCheck.length == 2) {
                            if (_game.matchCheck[0].values.first ==
                                _game.matchCheck[1].values.first) {
                              open.add(_game.matchCheck[0].values.first);
                              score += 100;
                              _game.matchCheck.clear();
                              opened += 2;
                              if (opened == 16) {
                                _handleBestScore();
                                opened = 0;
                                Future.delayed(Duration(milliseconds: 500), () {
                                  //resetTimer(60);
                                  time =  time - 5;
                                  resetTimer(time);
                                  startTimer();
                                  _game.resetGame();
                                });
                              }
                            } else {
                              Future.delayed(Duration(milliseconds: 250), () {
                                setState(() {
                                  _game.gameImg![_game.matchCheck[0].keys
                                      .first] = _game.hiddenCard;
                                  _game.gameImg![_game.matchCheck[1].keys
                                      .first] = _game.hiddenCard;
                                  _game.matchCheck.clear();
                                });
                              });
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF6F399A),
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(_game.gameImg![index]),
                              //fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    })),
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
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        _showDialog(context,score);
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void _getBestScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _best = (prefs.getInt('best') ?? 0);
    await prefs.setInt('best', _best);
    setState(() {
      _best;
    });
  }

  void _handleBestScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int temp = (prefs.getInt('best') ?? 0);
    if (score > _best) {
      await prefs.setInt('best', score);
      setState(() {
        _best = score;
      });
    }
  }

  _showDialog(BuildContext context,int finalScore) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog.fullscreen(
            backgroundColor: const Color(0xFF433C57),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$finalScore",
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'LexendMega',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 5.0),
                          blurRadius: 15.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        /*Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(125, 0, 0, 255),
                  ),*/
                      ],
                    ),
                  ),
                  TextButton(
                    child: const Text("Try Again",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'LexendMega',
                          fontWeight: FontWeight.w500,
                        )),
                    onPressed: () {
                      print("Restart!!!");
                      _game.resetGame();
                      resetTimer(60);
                      setState(() {
                        score = 0;
                      });
                      startTimer();
                      Navigator.pop(context); // Fechar Dialog
                    },
                  ),
                  SizedBox(
                    width: 100,
                    height: 24,
                    child: OutlinedButton(
                      onPressed: () async {
                        late Widget page = const HomePage();
                        String retorno = "";
                        try {
                          retorno = await push(context, page);
                        } catch (error) {
                          print(retorno);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF6F399A)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: const BorderSide(
                                        color: Color(0xFFAD00FF)))),
                      ),
                      child: const Text('Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'LexendMega',
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future push(BuildContext context, Widget page, {bool flagBack = true}) {
    if (flagBack) {
      // Pode voltar, ou seja, a página é adicionada na pilha.
      return Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }));
    } else {
      // Não pode voltar, ou seja, a página nova substitui a página atual.
      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }));
    }
  }
}
