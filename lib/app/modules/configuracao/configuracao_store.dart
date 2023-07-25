/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iot/app/modules/configuracao/configuracao_model.dart';

class ConfiguracaoStore {
  ///Variável que guada o banco!
  var box;

  _ConfiguracaoStoreBase() {
    opendb();
  }

  Settings settings = Settings();

  ///Função que abre o banco para leitura e escrita
  Future<bool> opendb() async {
    loading = true;
    box = await Hive.openBox("settings");
    if (box.values.isNotEmpty) {
      settings = box.values.first as Settings;
      loading = false;
      return true;
    } else {
      loading = false;
      return false;
    }
  }

  bool loading = true;

  Future<bool> save(String url, String key, int d, String urlonline, String lon,
      String lat) async {
    try {
      //Vou lipar para os novos dados
      loading = true;
      await box.clear();
      //Carregos os dados no objeto
      Settings st = Settings();
      st.urlacionamento = url;
      st.keyacionamento = key;
      st.urlacionamentointernet = urlonline;
      st.lon = double.tryParse(lon);
      st.lat = double.tryParse(lat);
      st.delayrele = d;
      //adiciono ao banco de dados
      box.add(st);
      loading = false;
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future excluiImg(int index) async {
    await box.deleteAt(index);
  }
}
