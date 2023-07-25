/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */

import 'package:flutter_modular/flutter_modular.dart';
import 'package:iot/app/modules/configuracao/configuracao_module.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
        ModuleRoute('/settings', module: ConfiguracaoModule())
    ];
}
