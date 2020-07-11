import 'package:flutter/material.dart';
import 'package:fotos_app/src/pages/detalle_page.dart';
import 'package:fotos_app/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => DetallePage()
      },
    );
  }
}