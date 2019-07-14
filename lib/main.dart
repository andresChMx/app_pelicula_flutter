import 'package:app_pelicula_seccion7/src/pages/home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelicula',
      initialRoute: '/',
      routes:{
        '/':  (BuildContext context)=>HomePage()
      }
    );
  }
}