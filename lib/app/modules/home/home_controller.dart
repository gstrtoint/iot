/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController {
  /// Se a conexão for local wifi retorna true se não false
  static Future<bool> conexLocal() async {
    Completer<bool> completer = Completer<bool>();
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      completer.complete(false);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      completer.complete(true);
    }
    return completer.future;
  }
}
