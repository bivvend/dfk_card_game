import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class MetaMaskController extends GetxController with UiLoggy {
  static const operatingChain = 4;

  RxString currentAddress = ''.obs;

  RxString account = "".obs;

  RxInt currentChain = (-1).obs;

  RxBool get isEnabled => (ethereum != null).obs;

  bool get isInOperatingChain => currentChain.value == operatingChain;

  RxBool get isConnected => (isEnabled.value && currentAddress.isNotEmpty).obs;

  Future<void> connect() async {
    if (isEnabled.value) {
      final accs = await ethereum!.requestAccount();
      // debugPrint("***********************************");
      // debugPrint(accs[0]);
      // debugPrint("***********************************");

      if (accs.isNotEmpty) {
        currentAddress.value = accs.first;
        account.value = accs[0];
        currentChain.value = await ethereum!.getChainId();
        logInfo("Current chain is ${currentChain.value}");
      } else {
        logError("No accounts found");
      }
    }
  }

  clear() {
    currentAddress.value = '';
    currentChain.value = -1;
    account.value = '';
  }

  init() {
    if (isEnabled.value) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}
