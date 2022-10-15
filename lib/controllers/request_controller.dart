import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';

//Controller handles HTTPS requests to the rpc endpoint
class RequestController extends GetxController with UiLoggy {
  Rx<String> rpcURL =
      "subnets.avax.network".obs; // /defi-kingdoms/dfk-chain/rpc".obs;
  Rx<String> path = "/defi-kingdoms/dfk-chain/rpc".obs;
  Rx<String> walletAddress = '0xf249CA466d82Bc4f244E83524DbF4Bb5D5E2433A'.obs;

  void setWalletAddress(String address) {
    walletAddress.value = address;
  }

  Future<http.Response> getBalanceRequest() async {
    // var body = jsonEncode({
    //   'data': {'apikey': '12345678901234567890'}
    // });

    var body = jsonEncode({
      'jsonrpc': '2.0',
      'method': 'eth_getBalance',
      'params': [walletAddress.value, 'latest'],
      'id': 1
    });

    logInfo("Body: " + body);
    var uri = Uri.https(rpcURL.value, path.value);
    logInfo(uri);

    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    logInfo("Response status: ${response.statusCode}");
    logInfo("Response body: ${response.body}");
    logInfo(response.headers);
    var value = jsonDecode(response.body);
    logInfo(value["result"].toString());
    var balance =
        int.parse(value["result"].toString().replaceAll("0x", ""), radix: 16);

    logInfo(balance.toDouble() / 1e18);
    return response;
  }
}
