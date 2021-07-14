import 'dart:ui';
import 'package:flutter_locyin/common/lang/zh_Hans.dart';
import 'package:flutter_locyin/utils/getx.dart';
import 'package:get/get.dart';
import 'en_US.dart';

class Messages extends Translations {

  static Locale? get locale => Get.find<LocaleController>().locale;
  static final fallbackLocale = Locale('zh', 'Hans');
  @override


  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_Hans': zh_Hans,
  };
}