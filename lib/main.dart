import "dart:io";
import 'package:contacts/android/android.app.dart';
import 'package:flutter/cupertino.dart';
import 'package:contacts/ios/ios.app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    runApp(IOSApp());
  } else {
    runApp(AndroidApp());
  }
}
