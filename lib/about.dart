import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF433C57),
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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'SOBRE',
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontFamily: 'K2D'),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Divider(color: Colors.white60,),
          Center(
            child: Padding(
              padding: EdgeInsets.all(39.0),
              child: Text(
                'Apresentando o MEMORIZE : um aplicativo desenvolvido como parte de um projeto da disciplina de Desenvolvimento para Dispositivos Móveis. Importante ressaltar que o projeto é estritamente educacional, sem qualquer intenção comercial. Aproveite para exercitar sua memória e habilidades de programação de forma leve e envolvente!',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(color: Colors.white60,),
          Center(
            child: Text(
              "0.0.1",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                fontWeight: FontWeight.w300,

              ),
            ),
          )
        ],
      ),
    );
    throw UnimplementedError();
  }
}
