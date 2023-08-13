import 'package:flutter/material.dart';
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
            SizedBox(height: 40, width: 500,),
            SizedBox(
                width: 200,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    late Widget page = Level1();
                    String retorno = "";
                    try {
                      retorno = await push(context, page);
                    } catch(error) {
                      print(retorno);
                    }
                  },
                  child: Text(
                      'NEW GAME',
                      style: TextStyle (
                        fontSize: 20,
                      fontFamily: 'Lexend Mega',
                      )
                  ),
                ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text(
                      'ABOUT',
                      style: TextStyle (
                        fontSize: 20,
                        fontFamily: 'Lexend Mega',
                      )
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future push(BuildContext context, Widget page, {bool flagBack=true}) {
    if (flagBack) {
      // Pode voltar, ou seja, a página é adicionada na pilha.
      return Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) { return page; })
      );
    } else {
      // Não pode voltar, ou seja, a página nova substitui a página atual.
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) { return page; })
      );
    }
  }
}