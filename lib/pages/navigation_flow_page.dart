import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metamask_inegration_flutter/controllers/meta_mask_controller.dart';
import 'package:metamask_inegration_flutter/controllers/navigation_controller.dart';
import 'package:metamask_inegration_flutter/controllers/request_controller.dart';
import 'package:metamask_inegration_flutter/enums/application_enums.dart';

import 'wallet_select_page.dart';

class NavigationFlowControlPage extends StatefulWidget {
  const NavigationFlowControlPage({Key? key}) : super(key: key);

  @override
  State<NavigationFlowControlPage> createState() =>
      _NavigationFlowControlPage();
}

class _NavigationFlowControlPage extends State<NavigationFlowControlPage> {
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1b202b),
      body: Container(child: selectCurrentPage()),
    );
  }

  Widget selectCurrentPage() {
    return Obx(() {
      if (navigationController.navigationState.value ==
          NavigationState.walletSelect) {
        return WalletSelectPage();
      } else {
        return Container();
      }
    });
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Text Copied")));
  }

  void _copytext(String copytext) {
    FlutterClipboard.copy(copytext).then((value) => _showSnackbar());
  }
}
