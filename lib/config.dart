import 'package:get/get.dart';

import 'common/controllers/common_controller/app_controller.dart';

var appCtrl = Get.isRegistered<AppController>()
    ? Get.find<AppController>()
    : Get.put(AppController());
