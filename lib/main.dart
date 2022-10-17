import 'package:get/get.dart';
import 'package:metamask_inegration_flutter/controllers/card_controller.dart';
import 'package:metamask_inegration_flutter/controllers/meta_mask_controller.dart';
import 'package:metamask_inegration_flutter/controllers/navigation_controller.dart';
import 'package:metamask_inegration_flutter/controllers/request_controller.dart';
import 'package:metamask_inegration_flutter/metamask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';
import 'pages/navigation_flow_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );

  //Inject Metamask Controller
  Get.put<MetaMaskController>(MetaMaskController());
  //Inject Http request Controller
  Get.put<RequestController>(RequestController());
  //Inject App navigation controller
  Get.put<NavigationController>(NavigationController());

  //Inject Card controller  for data storage  //this needs to be last as has dependecies
  Get.put<CardController>(CardController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DFK Card Game',
      theme: ThemeData.dark(),
      home: const NavigationFlowControlPage(),
    );
  }
}
