import 'package:flutter/material.dart';
import 'package:photo_app/pages/home_page/home_page.dart';
import 'package:photo_app/teste.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}