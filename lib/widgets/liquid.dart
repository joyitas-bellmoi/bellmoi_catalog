import 'package:bellmoi_catalog/test1.dart';
import 'package:flutter/material.dart';

final estiloTexto = TextStyle(fontSize: 20.0, color: Colors.greenAccent);

final liquidPages = [

  Container(
    color: Colors.purpleAccent,
    child: Center(
      child: Text('Producto 1',style: estiloTexto ),
    ),
  ),

  Container(
    color: Colors.orangeAccent,
    child: Center(
      child: Text('Details\nProduct 1',style: estiloTexto, textAlign: TextAlign.center),
    ),
  ),

];

final liquidPages2 = [

  Container(
    color: Colors.blueAccent,
    child: Center(
      child: Text('Slide 3',style: estiloTexto ),
    ),
  ),

  Container(
    color: Colors.redAccent,
    child: Center(
      child: Text('Slide 4',style: estiloTexto ),
    ),
  ),

];

final liquidPages3 = [

  Container(
    color: Colors.yellowAccent,
    child: Center(
      child: Text('Slide 5',style: estiloTexto ),
    ),
  ),

  Container(
    color: Colors.black12,
    child: Center(
      child: MyAppTest1(),
    ),
  ),

];