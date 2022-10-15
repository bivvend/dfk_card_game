import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../enums/application_enums.dart';

class NavigationController extends GetxController with UiLoggy {
  Rx<NavigationState> navigationState = NavigationState.walletSelect.obs;
}
