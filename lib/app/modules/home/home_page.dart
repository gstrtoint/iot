/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:iot/app/modules/configuracao/configuracao_model.dart';
import 'package:iot/app/modules/home/home_controller.dart';
import 'package:iot/utils/neubutton.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/coordenadas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isButtonPressed = false;
  Settings? st;
  bool configok = false;

  alertinfo(String tx) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("INFORMACAO"),
              content: Text(tx),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Modular.to.pop();
                  },
                )
              ]);
        });
  }

  opendb() async {
    final box = await Hive.openBox("settings");

    if (box.values.isNotEmpty) {
      st = box.values.first as Settings;
      isButtonPressed = true;
      configok = true;
    } else {
      setState(() {
        isButtonPressed = false;
        configok = false;
      });
    }
  }

  Future<void> postRequest(String end, String keyaccess, String dalay) async {
    final url = Uri.http(end, '/endpoint'); // URL da API

    // Cria o mapa com os parâmetros do corpo
    final body = {
      'key': keyaccess,
      'delay': dalay,
    };

    // Converte os dados para uma string JSON
    final jsonBody = jsonEncode(body);

    // Define o cabeçalho da solicitação
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // A solicitação foi bem-sucedida
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Acionamento executado com sucesso!'),
          ),
        );
      } else {
        // A solicitação falhou
        alertinfo("Não foi possível acionar o portal");
      }
    } catch (e) {
      // Ocorreu um erro durante a solicitação
      alertinfo('Ocorreu uma exeção inesperada! Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opendb();
  }

  atualizaButton() {
    setState(() {
      isButtonPressed = !isButtonPressed;
    });
  }

  void buttonPressed() async {
    if (configok == true) {
      if (!isButtonPressed) {
        atualizaButton();
      }
      if (isButtonPressed) {
        final cnxLocal = await HomeController.conexLocal();
        if (cnxLocal) {
          postRequest(st!.urlacionamento, st!.keyacionamento,
                  st!.delayrele.toString())
              .then((value) => buttonUnpressed());
        } else {
          GetCoordenadas gcoord = GetCoordenadas();
          bool permit = await gcoord.checkIfWithinRadius(st!.lat!, st!.lon!);
          if (permit) {
            postRequest(st!.urlacionamentointernet, st!.keyacionamento,
                    st!.delayrele.toString())
                .then((value) => buttonUnpressed());
          } else {
            buttonUnpressed();
            alertinfo(
                'Não foi possível acessar a rede local e nem validar se você esta proximo ao portão. Certifique de esta proximo ao portão');
          }
        }
        /////
      }
    } else {
      alertinfo('É necessário configurar o aplicativo!');
    }
  }

  void buttonUnpressed() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isButtonPressed = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('IOT'),
          backgroundColor: Colors.white10,
          actions: [
            IconButton(
                onPressed: () =>
                    Modular.to.pushNamed('/settings').then((value) => opendb()),
                icon: const Icon(Icons.edit))
          ]),
      backgroundColor: Colors.grey[300],
      body: Center(
          child: NeuButton(
        onTap: buttonPressed,
        isButtonPressed: isButtonPressed,
      )),
    );
  }
}
