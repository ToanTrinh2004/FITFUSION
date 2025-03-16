import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/screen/intro.dart';

void main() {
  runApp(FitFusionApp());
}

class FitFusionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroApp(), // Đặt màn hình khởi động đúng
    );
  }
}
