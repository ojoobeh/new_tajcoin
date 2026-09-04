import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

export 'dart:async';
export 'dart:convert';

export 'package:get/get.dart';

export 'data/data.dart';
export 'data/dto/dto.dart';
export 'utility/enums.dart';
export 'utility/get.dart';



void initUtilities() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
}
