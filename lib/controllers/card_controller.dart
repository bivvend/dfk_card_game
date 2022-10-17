import 'dart:convert';

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:metamask_inegration_flutter/controllers/request_controller.dart';

import '../enums/application_enums.dart';

class CardController extends GetxController with UiLoggy {
  //All calls to GraphQL endpoint made via request controller
  RequestController requestController = Get.find();

  RxList<String> heroIDs = <String>[].obs;

  Future getCards() async {
    heroIDs.clear();
    var hereosResponse = await requestController.getHeroRequest();

    var value = jsonDecode(hereosResponse.body);
    var data = value["data"];
    List<dynamic> heroes = data["heroes"];
    logInfo(heroes);
    heroes.forEach((element) {
      heroIDs.add(element.toString());
    });
  }
}
