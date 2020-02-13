import 'package:flutter/material.dart';

void main() => runApp(MyAppTest1());

class MyAppTest1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bellmoi - Catalogo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeTest1Page(title: 'Bellmoi - Catalogo'),
    );
  }
}

class MyHomeTest1Page extends StatefulWidget {
  MyHomeTest1Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeTest1PageState createState() => _MyHomeTest1PageState();
}

class _MyHomeTest1PageState extends State<MyHomeTest1Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text(widget.title),
      ),
      */
      backgroundColor: Colors.cyanAccent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
/*             Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.limeAccent,
                border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 5)
              ),
              width: 300,
              height: 300,
            ), */

            /* ARRIBA -------------- */
            Positioned(
                top: 10,
                width: 100,
                height: 100,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(100), bottom: Radius.zero),
                      color: Colors.redAccent,
                    ),
                    alignment: Alignment.center,
                    child: Text('1'),
                  ),
                  onTap: presionarBoton(),
                )),
            /* ABAJO -------------- */
            Positioned(
                bottom: 10,
                width: 100,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.zero, bottom: Radius.circular(100)),
                    color: Colors.purpleAccent,
                  ),
                  alignment: Alignment.center,
                  child: Text('1'),
                )),
            /* DERECHA -------------- */
            Positioned(
                left: 10,
                width: 100,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50), right: Radius.zero),
                    color: Colors.blueAccent,
                  ),
                  alignment: Alignment.center,
                  child: Text('2'),
                )),
            /* IZQUIERDA -------------- */
            Positioned(
                right: 10,
                width: 100,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.zero, right: Radius.circular(100)),
                    color: Colors.greenAccent,  
                  ),
                  alignment: Alignment.center,
                  child: Text('3'),
                )),
          ],
        ),
      ),

      /* BOTON FLOTANTE <------------------------------------------------------- */
      /* floatingActionButton: FloatingActionButton(
                        onPressed: _incrementCounter,
                        tooltip: 'Incrementa',
                        child: Icon(Icons.add),
                      ), */
    );
  }
}

presionarBoton() {
  print('Boton Presionado...');
}
