/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'package:iot/app/modules/configuracao/configuracao_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iot/app/modules/configuracao/configuracao_page.dart';

class ConfiguracaoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ConfiguracaoStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((_, args) => const ConfiguracaoPage()))
  ];
}
