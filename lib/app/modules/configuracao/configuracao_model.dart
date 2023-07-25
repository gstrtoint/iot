/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'package:hive_flutter/hive_flutter.dart';
part 'configuracao_model.g.dart';

@HiveType(typeId: 0)
class Settings extends HiveObject {
  @HiveField(0)
  String urlacionamento = '';

  @HiveField(1)
  int delayrele = 2;

  @HiveField(2)
  String keyacionamento = '';

  @HiveField(3)
  double? lat;

  @HiveField(4)
  double? lon;

  @HiveField(5)
  String urlacionamentointernet = '';
}
