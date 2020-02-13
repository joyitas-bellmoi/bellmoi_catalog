import 'package:bellmoi_catalog/pages/home.dart';
import 'package:bellmoi_catalog/pages/productos_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bellmoi - Catalogo',
      initialRoute: 'home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomePage()
      routes: {
        'home'          : (BuildContext context) => HomePage(),
        'productos'     : (BuildContext context) => ProductosPage(),
      }
    );
  }
}
