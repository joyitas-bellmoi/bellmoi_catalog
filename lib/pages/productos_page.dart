import 'dart:convert';

import 'package:bellmoi_catalog/models/materiales_model.dart';
import 'package:bellmoi_catalog/providers/productos_provider.dart';
import 'package:bellmoi_catalog/widgets/json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bellmoi_catalog/models/producto_model.dart';
import 'package:bellmoi_catalog/widgets/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProductosModel productoModel;
ProductosProvider pp = new ProductosProvider();

int idGrupo;
int idCategoria;
String tituloGrupo = '';
String tituloCategoria = '';
bool estadoPromocion = true;

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  actualizaGrupoCategoria() async {
    // OBTIENE el GRUPO y CATEGORIA -------> Seleccionados.
    SharedPreferences sp = await SharedPreferences.getInstance();
    var grupo = sp.getString(spProductosGrupo);
    var categoria = sp.getString(spProductosCategoria);

    setState(() {
      tituloGrupo = grupo;
      tituloCategoria = categoria;
    });

    switch (grupo) {
      case 'Hombres': idGrupo = 1;    break;
      case 'Mujeres': idGrupo = 3;    break;
      case 'Recuerdos': idGrupo = 5;  break;
    }

    switch (categoria) {
      case 'Collares':  idCategoria = 1;    break;
      case 'Pulseras':  idCategoria = 2;    break;
      case 'Aretes':    idCategoria = 3;    break;
      case 'Pulsera Tobillera': idCategoria = 4;    break;
      case 'Packs':     idCategoria = 5;    break;
      case 'Otros':     idCategoria = 6;    break;
      case 'Eventos':   idCategoria = 7;    break;
      case 'Anillos':   idCategoria = 8;    break;
      case 'Llaveros':  idCategoria = 9;    break;
      case 'Velas':     idCategoria = 10;   break;
      case 'Denarios':  idCategoria = 11;   break;
    }

/*     if (pp.getPromotionsXGrupoCategoria(idGrupo, idCategoria) == true){
      setState(() {
        estadoPromocion = true;
      });
    } */
  }

  Future<List<ProductosModel>> getProductos(int idMaterial) async {
    /* Personalizar poara el API en la nube. */
    /* var data = await http.get("https://miincode.firebaseio.com/usuarios.json");
    var jsonData = json.decode(data.body);
    print('jsonData:\n'+jsonData.toString());
    */

    actualizaGrupoCategoria();

    try {
      var parsedJson_Productos = json.decode(jsonProductosVarios);

      /* LISTA LOS PRODUCTOS Filtrado por GRUPO <------------------------------------ */
      List<ProductosModel> productos = [];

      for (var p in parsedJson_Productos) {
        if (p["id_grupo"] == idGrupo) {
          if (p["id_categoria"] == idCategoria) {
            if (p["id_material"] == idMaterial) {
              ProductosModel producto = ProductosModel(p["id"], p["codigo"], p["id_categoria_material"], p["id_categoria"], p["id_material"],
                  p["id_grupo"], p["grupo"], p["nombre"], p["descripcion"], p["precio"], p["stock"], p["foto"], p["estado"]);
              productos.add(producto);
            }
          }
        }
      }

      return productos;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<MaterialesModel>> getMateriales(
      int idGrupo, int idCategoria) async {
    try {
      var parsedJson = json.decode(jsonMateriales);

      actualizaGrupoCategoria();

      List<MaterialesModel> materiales = [];

      List<int> idMat = pp.getMateriales2(idGrupo, idCategoria);

      for (var i = 0; i < idMat.length; i++) {
        for (var p in parsedJson) {
          if (p["ID"] == idMat[i]) {
            MaterialesModel material =
                MaterialesModel(p["ID"], p["NOMBRE"], p["DESCRIPCION"]);
            materiales.add(material);
          }
        }
      }
      return materiales;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: title,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: showAppBar(context, tituloGrupo + ': ' + tituloCategoria),
        body: Column(
          children: <Widget>[
            // BLOQUE ---> PROMOCIONES
            estadoPromocion == true ?
            Container(
              child: Column(
                children: <Widget>[
                  // HEADER ---> PROMOCIONES
                  Container(
                    height: 30,
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(253, 247, 22, 1),
                          style: BorderStyle.solid,
                          width: 1),
                        top: BorderSide(
                          color: Color.fromRGBO(253, 247, 22, 1),
                          style: BorderStyle.solid,
                          width: 1
                        )
                      )
                    ),
                    child: Row(children: <Widget>[
                      Text('OFERTAS & PROMOCIONES',
                        style: TextStyle(
                          color: Color.fromRGBO(253, 247, 22, 1),
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Icon(Icons.arrow_right,
                        color: Color.fromRGBO(253, 247, 22, 1)
                      )
                    ]
                  )
                ),

                  // BODY ---> PROMOCIONES
                  Container(
                    height: 150,
                    child: FutureBuilder(
                      future: pp.getPromociones(idGrupo, idCategoria),
                      builder: (BuildContext context, AsyncSnapshot snapshotPromociones) {
                        if (snapshotPromociones.data == null) {
                          return Container(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshotPromociones.data.length,
                              itemBuilder: (BuildContext context, int index0) {

                                //return pp.getHasPromotion(snapshotPromociones.data[index0].id_producto, idGrupo, idCategoria) == true 
                                return Container(
                                    height: 150,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(253, 247, 22, 1),
                                      style: BorderStyle.solid,
                                      width: 1),
                                    borderRadius: BorderRadius.circular(17)),
                                  child: caraFrontal(
                                    context, 
                                    snapshotPromociones.data[index0].foto, 
                                    snapshotPromociones.data[index0].des_corta, 
                                    snapshotPromociones.data[index0].des_larga,
                                    snapshotPromociones.data[index0].estado, 
                                    pp.getPrecioNormalProducto(snapshotPromociones.data[index0].id_producto), 
                                    snapshotPromociones.data[index0].precio_oferta,
                                    pp.getCodigoProducto(snapshotPromociones.data[index0].id_producto), 
                                    pp.getFecFinPromocion(snapshotPromociones.data[index0].id_producto),
                                    snapshotPromociones.data[index0].id_producto
                                )
                              );
                            }
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
            : Container(),
            // BLOQUE PRODUCTOS por CATEGORIAS
            Expanded(
                child: Container(
                    //color: Colors.blue,
                    child: FutureBuilder(
                        future: getMateriales(idGrupo, idCategoria),
                        //future: _getMateriales2(idGrupo, idCategoria),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshotMateriales) {
                          if (snapshotMateriales.data == null) {
                            return Container(
                                child: Center(
                                    child: CircularProgressIndicator(
                                        backgroundColor: Colors.white)));
                          } else {
                            return (idCategoria == 6 || idCategoria == 8 || idCategoria == 9 || idCategoria == 10 || idCategoria == 11)
                              ? cat_8(context, snapshotMateriales)
                              : ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshotMateriales.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (snapshotMateriales.data.length == 0) {
                                    Container(
                                      child: Text('No se encontraron Materiales',
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          // HEADER ---> PRODUCTOS x MATERIAL
                                          Container(
                                              padding:
                                                  EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              alignment:
                                                  Alignment.centerLeft,
                                              //height: 50,
                                              decoration: BoxDecoration(
                                                  //color: Colors.blue[500],
                                                  border: Border(
                                                bottom: BorderSide(
                                                    color: Colors
                                                        .blue[500],
                                                    style: BorderStyle
                                                        .solid,
                                                    width: 1),
                                                //top: BorderSide(color: Colors.blue[500], style: BorderStyle.solid, width: 1)
                                              )),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                      snapshotMateriales
                                                          .data[index]
                                                          .nombre,
                                                      style: TextStyle(
                                                          //color: Colors.white,
                                                          color: Colors
                                                                  .blue[
                                                              500],
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                  Icon(
                                                      Icons.arrow_right,
                                                      color: Colors
                                                          .blue[500])
                                                ],
                                              )),
                                          // BODY ---> PRODUCTOS x MATERIAL
                                          Container(
                                            //margin: EdgeInsets.fromLTRB(3, 0, 3, 3),
                                            height: 150,
                                            color: Colors.black38,
                                            child: Center(
                                              child: FutureBuilder(
                                                future: getProductos(snapshotMateriales.data[index].id),
                                                builder: (BuildContext context, AsyncSnapshot snapshotProductos) {
                                                  if (snapshotProductos.data ==null) {
                                                    return Container(
                                                      child: Text('NULOOOOOOOOOO'),
                                                    );
                                                  } else {
                                                    return ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: snapshotProductos.data.length,
                                                      itemBuilder: (BuildContext context, int index2) {
                                                      return Container(
                                                          margin: EdgeInsets.all(5),
                                                          child: caraFrontal( context, 
                                                                              snapshotProductos.data[index2].foto, 
                                                                              snapshotProductos.data[index2].nombre, 
                                                                              snapshotProductos.data[index2].descripcion, 
                                                                              snapshotProductos.data[index2].estado, 
                                                                              snapshotProductos.data[index2].precio, 
                                                                              pp.getPrecioPromocion(snapshotProductos.data[index2].id), 
                                                                              snapshotProductos.data[index2].codigo, 
                                                                              pp.getFecFinPromocion(snapshotProductos.data[index2].id), 
                                                                              snapshotProductos.data[index2].id
                                                                            )
                                                      );
                                                    }
                                                  );
                                                }
                                              }
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }
                            );
                          }
                        }
                      )
                    )
                //child: _gridProductos(context)
                )
          ],
        )
      )
    );
  }

  Widget cat_8(BuildContext context, AsyncSnapshot snapshotMateriales) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: snapshotMateriales.data.length,
        itemBuilder: (BuildContext context, int index) {
          if (snapshotMateriales.data.length == 0) {
            Container(
              child: Text(
                'No se encontraron Materiales',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Container(
              child: Column(
                children: <Widget>[
                  // HEADER ---> PRODUCTOS x MATERIAL
                  Container(
                    height: 25,
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.centerLeft,

                    decoration: BoxDecoration(
                      border: Border(
                      bottom: BorderSide(
                        color: Colors.blue[500],
                        style: BorderStyle.solid,
                        width: 1
                      ),
                    )
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(snapshotMateriales.data[index].nombre,
                          style: TextStyle(
                              //color: Colors.white,
                              color: Colors.blue[500],
                              fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_right, color: Colors.blue[500])
                    ],
                  )),
                  // BODY ---> PRODUCTOS x MATERIAL
                  Container(
                    height: 350,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    color: Colors.black38,
                    child: Center(
                      child: FutureBuilder(
                          future:
                              getProductos(snapshotMateriales.data[index].id),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshotProductos) {
                            if (snapshotProductos.data == null) {
                              return Container(
                                child: Text('NULOOOOOOOOOO'),
                              );
                            } else {
                              return GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshotProductos.data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder:(BuildContext context, int index2) {
                                    return Container(
                                      margin: EdgeInsets.all(5),
                                      child: caraFrontal(context, snapshotProductos.data[index2].foto, snapshotProductos.data[index2].nombre, snapshotProductos.data[index2].descripcion, 
                                      snapshotProductos.data[index2].estado, snapshotProductos.data[index2].precio, 
                                      pp.getPrecioPromocion(snapshotProductos.data[index2].id), snapshotProductos.data[index2].codigo, pp.getFecFinPromocion(snapshotProductos.data[index2].id), snapshotProductos.data[index2].id
                                      )
                                    );
                                  }
                                );
                            }
                          }
                        )    
                      ),
                  )
                ],
              ),
            );
          }
        }
      );
  }

  Widget caraFrontal( BuildContext context, String foto, String nombreProducto, String descripcion, int estado, double precioNormal, 
                      double precioOferta, String codigo, String fecVencimientoPromocion, int idProducto) {

    return Container(
      child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        // Imagen del PRODUCTO de fondo.
        GestureDetector(
          child: Container(
            width: 150,
            //height: 250,
            alignment: Alignment.center,
            child: (foto == '' || foto.isEmpty)
            ? Image(image: AssetImage('assets/no-image.png'))
            : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                image: NetworkImage(foto),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 150.0,
                width: 150.0, //double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          onTap: () {
            showDetalle(context, nombreProducto, descripcion, foto, estado, precioNormal, precioOferta, codigo, idProducto);
          },
        ),
        // Precio PROMOCION
        precioOferta != null 
        ? Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset('assets/icons/promocion.png'),
                Text(
                  'S/.\n' + formatter.format(precioOferta),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        )
        : Container(),

        // Icon NUEVO PRODUCTO
        estado == 2
        ? Positioned(
          top: 0,
          right: 0,
          child: Transform.rotate(
            angle: 45.0,
            child: Container(
              width: 50,
              height: 50,
              child: Image.asset('assets/icons/nuevo.png'),
            ),
          )
        )
        : Container(),


        // Precio NORMAL
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 100,
            width: 100,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Icon(
                    Icons.local_offer,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Positioned(
                  bottom: 18,
                  left: 17,
                  child: Transform.rotate(
                    angle: 11.8,
                    child: Text(  
                      'S/.\n' + formatter.format(precioNormal),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ),
        // Código ID del PRODUCTO
        Positioned.directional(
          top: 0,
          start: 0,
          textDirection: TextDirection.ltr,
          child: Container(
            margin: EdgeInsets.fromLTRB(3, 3, 0, 0),
            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              codigo, 
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold
              ),
            )
          )
        )
      ]
      ),
    );
  }
}

/*
  FUENTE: 
  - https://medium.com/flutter-community/how-to-parse-json-in-flutter-for-beginners-8074a68d7a79
  - https://www.filledstacks.com/tag/Animation/
*/

/*
    FUENTE:   CONVERTER  TO  BASE 64
    1. https://bezkoder.com/dart-base64-image/
    2. https://issue.life/questions/52850851
    3. https://artisan.com.my/flutter-convert-to-base64-image-and-display-it/
    
 */
