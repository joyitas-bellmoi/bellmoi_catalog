import 'package:bellmoi_catalog/pages/productos_page.dart';
import 'package:bellmoi_catalog/widgets/utils.dart';
import 'package:flutter/material.dart';

class CategoriasPage extends StatefulWidget {

  @override
  _CategoriasPageState createState() => _CategoriasPageState();

}

class _CategoriasPageState extends State<CategoriasPage> {

  @override
  Widget build(BuildContext context) {
    return null;

  }
}
// CATEGORIAS

Widget subCatProductos(BuildContext context){
  return Container(
    margin: EdgeInsets.all(6),
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(0, 0, 3, 3),
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(255, 192, 203, 0.6),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/categorias/pulseras-2.jpg')
                          )
                        ),
                        child: null
                      ),
                      botonCategoria(context, 'Pulseras')
                    ],

                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ProductosPage()
                      )
                    );
                    indicarCategoriaElegida(context, 'Pulseras');
                  }
                )
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(3, 0, 0, 3),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                      color: Color.fromRGBO(255, 239, 213, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/categorias/aretes-2.jpg')
                      )
                    ),
                    child: botonCategoria(context, 'Aretes'),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ProductosPage()
                      )
                    );
                    indicarCategoriaElegida(context, 'Aretes');
                  }
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                color: Color.fromRGBO(255, 245, 238, 0.6),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/categorias/collares-2.jpg')
                )
              ),
              child: botonCategoria(context, 'Collares'),
            ),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => ProductosPage()
                )
              );
              indicarCategoriaElegida(context, 'Collares');
            }
          ),
        )
      ],
    ),
  );

}

Widget catHombres(BuildContext context){
  return Container(
    margin: EdgeInsets.all(6),
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 3, 3),
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(255, 192, 203, 0.6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/categorias/pulseras-3.jpg')
                )
              ),
              child: botonCategoria(context, 'Pulseras')
            ),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => ProductosPage()
                )
              );
              indicarCategoriaElegida(context, 'Pulseras');
            }
          )
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                color: Color.fromRGBO(255, 245, 238, 0.6),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/categorias/anillos-2.jpg')
                )
              ),
              child: botonCategoria(context, 'Anillos'),
            ),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => ProductosPage()
                )
              );
              indicarCategoriaElegida(context, 'Anillos');
            }
          ),
        )
      ],
    ),
  );

}

Widget botonCategoria(BuildContext context, String _categoria){
  return Center(
    child: Text(
      _categoria, 
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(147, 17, 126, 1),
      )
    )
  );
}

Widget catActividades(BuildContext context){
  return Container(
    margin: EdgeInsets.all(6),
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                      color: Color.fromRGBO(255, 245, 238, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/categorias/llaveros-02.png')
                      )
                    ),
                    child: botonCategoria(context, 'Llaveros'),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ProductosPage()
                      )
                    );
                    indicarCategoriaElegida(context, 'Llaveros');
                  }
                ),
              ),
              Expanded(
                flex: 6,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                      color: Color.fromRGBO(255, 245, 238, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/categorias/velas-02.png')
                      )
                    ),
                    child: botonCategoria(context, 'Velas'),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ProductosPage()
                      )
                    );
                    indicarCategoriaElegida(context, 'Velas');
                  }
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                      color: Color.fromRGBO(255, 245, 238, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/categorias/denarios-02.png')
                      )
                    ),
                    child: botonCategoria(context, 'Denarios'),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ProductosPage()
                      )
                    );
                    indicarCategoriaElegida(context, 'Denarios');
                  }
                ),
              ),
              Expanded(
                flex: 6,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2),
                      color: Color.fromRGBO(255, 245, 238, 0.6),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/categorias/otros-02.png')
                      )
                    ),
                    child: botonCategoria(context, 'Otros'),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ProductosPage()
                      )
                    );
                    indicarCategoriaElegida(context, 'Otros');
                  }
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );

}


