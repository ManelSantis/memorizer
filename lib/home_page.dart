import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memorizer/level_1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF433C57),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.brain,
              color: Colors.white,
              size: 100.0,
            ),
            const Text(
              "MEMORIZER",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lexend Mega',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 75,
              width: 500,
            ),
            SizedBox(
              width: 200,
              height: 48,
              child: OutlinedButton(
                onPressed: () async {
                  late Widget page = Level1();
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      //side: const BorderSide(color: Color(0xFFAD00FF))
                    ))),
                child: const Text('NEW GAME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Lexend Mega',
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  // Respond to button press
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF6F399A)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      //side: const BorderSide(color: Color(0xFFAD00FF))
                    ))),
                child: const Text('ABOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Lexend Mega',
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            const SizedBox(
              width: 200,
              height: 100,
            )
          ],
        ),
      ),
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
