import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metamask_inegration_flutter/controllers/card_controller.dart';
import 'package:metamask_inegration_flutter/controllers/navigation_controller.dart';
import 'package:metamask_inegration_flutter/enums/application_enums.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../controllers/meta_mask_controller.dart';
import '../controllers/request_controller.dart';

class WalletSelectPage extends StatelessWidget {
  WalletSelectPage({Key? key}) : super(key: key);

  final MetaMaskController mmController = Get.find();
  final RequestController requestController = Get.find();
  final NavigationController navigationController = Get.find();
  final CardController cardController = Get.find();

  @override
  Widget build(BuildContext context) {
    void _showSnackbar() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Text Copied")));
    }

    void _copytext(String copytext) {
      FlutterClipboard.copy(copytext).then((value) => _showSnackbar());
    }

    TextEditingController addressEditController = TextEditingController();
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Obx((() {
                  if (mmController.isConnected.value) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white54,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 15,
                      shadowColor: Colors.black,
                      color: const Color.fromARGB(255, 10, 17, 32),
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, bottom: 15),
                        height: 270,
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Account",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 150,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white60,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Connected to MetaMask",
                                          style:
                                              TextStyle(color: Colors.white60),
                                        ),
                                        Obx(() {
                                          return Text(
                                            '${mmController.account.value.substring(0, 7)}...',
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _copytext(
                                                    mmController.account.value);
                                                addressEditController.text =
                                                    mmController.account.value;
                                              },
                                              icon: const Icon(
                                                  Icons.content_copy_rounded),
                                              color: Colors.white60,
                                            ),
                                            const Text(
                                              "Copy Address",
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                mmController.clear();
                                              },
                                              icon: const Icon(
                                                  Icons.clear_rounded),
                                              color: Colors.white60,
                                            ),
                                            const Text(
                                              "Clear",
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (mmController.isEnabled.value) {
                    return ElevatedButton(
                      onPressed: () async {
                        await mmController.connect();
                        addressEditController.text = mmController.account.value;
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          primary: const Color.fromARGB(255, 19, 43, 98),
                          padding: const EdgeInsets.symmetric(horizontal: 10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Image.asset(
                              "assets/images/MetaMask_Fox.png",
                              height: 30,
                              width: 40,
                            ),
                          ),
                          const Text(
                            "Connect Wallet",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                      ),
                    );
                  } else {
                    return const Text('Please use a Web3 supported browser.');
                  }
                })),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Obx(() {
                          return Text(
                              "Wallet Address: ${mmController.currentAddress.value}, ChainID: ${mmController.currentChain.value}");
                        }),
                        Obx(() {
                          if (mmController.isConnected.value) {
                            return Container(
                              child: IconButton(
                                onPressed: () async {
                                  await requestController.getBalanceRequest();
                                },
                                icon: const Icon(Icons.post_add),
                                color: Colors.white60,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        })
                      ],
                    ),
                    Container(
                      width: 500,
                      height: 60,
                      child: TextField(
                        controller: addressEditController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter address',
                        ),
                      ),
                    ),
                    Obx(() {
                      return requestController.runningRequest.value
                          ? const SpinKitRotatingCircle(
                              color: Colors.white,
                              size: 50.0,
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (addressEditController.text.isNotEmpty) {
                                  requestController.walletAddress.value =
                                      addressEditController.text;
                                  await cardController.getCards();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  primary:
                                      const Color.fromARGB(255, 19, 43, 98),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Icon(Icons.download),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Get Cards",
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 10)
                                ],
                              ),
                            );
                    })
                  ],
                )
              ],
            )),
        Expanded(
            flex: 5,
            child: Container(child: Obx(
              () {
                return GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 5,
                    children: cardController.heroIDs
                        .map((element) => Text(element))
                        .toList());
              },
            )))
      ],
    );
  }
}
