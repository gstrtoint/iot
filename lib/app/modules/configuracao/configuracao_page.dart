/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iot/app/modules/configuracao/configuracao_store.dart';
import 'package:iot/utils/coordenadas.dart';

class ConfiguracaoPage extends StatefulWidget {
  final String title;
  const ConfiguracaoPage({Key? key, this.title = 'Configuracao'})
      : super(key: key);
  @override
  ConfiguracaoPageState createState() => ConfiguracaoPageState();
}

class ConfiguracaoPageState extends State<ConfiguracaoPage> {
  final store = Modular.get<ConfiguracaoStore>();
  bool loadposition = false;

  final _formKey = GlobalKey<FormState>();
  final _ctrlurllocal = TextEditingController();
  final _ctrlkey = TextEditingController();
  final _ctrllat = TextEditingController();
  final _ctrllon = TextEditingController();
  final _ctrlonline = TextEditingController();
  final _intController = TextEditingController();

  final coordenadas = GetCoordenadas();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.opendb().then((value) {
      setState(() {
        if (value) {
          _ctrlurllocal.text = store.settings.urlacionamento;
          _ctrlkey.text = store.settings.keyacionamento;
          _intController.text = store.settings.delayrele.toString();
          _ctrllat.text = store.settings.lat.toString();
          _ctrllon.text = store.settings.lon.toString();
          _ctrlonline.text = store.settings.urlacionamentointernet;
        }
      });
    });
  }

  AlertDialog alert = AlertDialog(
      title: const Text("CONFIRME"),
      content: const Text("Não foi possível salvar a configuração!"),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Modular.to.pop();
          },
        )
      ]);
  List<Widget> getcoord() {
    return [
      loadposition == true
          ? const SizedBox(
              height: 20,
              width: 20,
              child: Center(child: CircularProgressIndicator()))
          : IconButton(
              onPressed: () async {
                setState(() {
                  loadposition = true;
                });
                Position p = await coordenadas.determinePosition();
                _ctrllat.text = p.latitude.toString();
                _ctrllon.text = p.longitude.toString();
                setState(() {
                  loadposition = false;
                });
              },
              icon: const Icon(Icons.pin_drop_sharp, color: Colors.blueGrey)),
      const SizedBox(width: 10),
      Expanded(
        child: TextFormField(
          controller: _ctrllat,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Latitude',
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: TextFormField(
          controller: _ctrllon,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Longitude',
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(children: [
          store.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _ctrlurllocal,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText:
                                'IP ou DNS da interface de acionamento local',
                          ),
                        ),
                        TextFormField(
                          controller: _ctrlonline,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText:
                                'IP ou DNS da interface de acionamento externo',
                          ),
                        ),
                        Row(children: getcoord()),
                        TextFormField(
                          controller: _ctrlkey,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Chave de acesso',
                          ),
                        ),
                        TextFormField(
                          controller: _intController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (int.tryParse(value!) == null) {
                              return 'Digite um valor numérico';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tempo que o rele ficara acionado',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                            child: const Text('Enviar'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Realize ações com os valores preenchidos
                                String url = _ctrlurllocal.text;
                                String key = _ctrlkey.text;
                                int d = int.parse(_intController.text);
                                String urlonline = _ctrlonline.text;
                                String lon = _ctrllon.text;
                                String lat = _ctrllat.text;
                                store
                                    .save(url, key, d, urlonline, lon, lat)
                                    .then((r) {
                                  if (r) {
                                    Modular.to.pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Dados salvo com sucesso!'),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        });
                                  }
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                )
        ]));
  }
}
