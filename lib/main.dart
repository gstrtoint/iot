
/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iot/app/app_module.dart';

import 'app/app_widget.dart';
import 'app/modules/configuracao/configuracao_model.dart';

void main() async {
  /// Inicialiso o Hive
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
