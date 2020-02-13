
// import 'dart:convert';

// import 'package:bellmoi_catalog/models/materiales_model.dart';
// import 'package:bellmoi_catalog/models/promociones_model.dart';
// import 'package:bellmoi_catalog/providers/productos_provider.dart';
// import 'package:bellmoi_catalog/widgets/json.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:bellmoi_catalog/models/producto_model.dart';
// import 'package:bellmoi_catalog/widgets/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart'; 

// import 'package:kt_dart/kt.dart';

// ProductosModel productoModel;

// List<int> productosGrupo_0 = [];  // Mujeres
// List<int> productosGrupo_1 = [];  // Hombres
// List<int> productosGrupo_2 = [];  // Actividades
// List<int> listaIdCategorias = [];
// List<int> listaIdMateriales = [];
// List<int> listaGrupos = [];

// int idGrupo;
// int idCategoria;
// String tituloGrupo = 'Recuerdos';
// String tituloCategoria = '';

// class ProductosPage extends StatefulWidget {
//   @override
//   _ProductosPageState createState() => _ProductosPageState();
// }

// class _ProductosPageState extends State<ProductosPage> {

//   final productosProvider = new ProductosProvider();

//   Future<List<MaterialesModel>> _getMateriales() async {
//     try {
//       var parsedJson = json.decode(jsonMateriales);

//       List<MaterialesModel> materiales = [];
//       for(var p in parsedJson){
//         MaterialesModel material = MaterialesModel(p["ID"], p["NOMBRE"], p["DESCRIPCION"]);
//         materiales.add(material);
//       }
//       return materiales;
//     } catch (e) {
//       logger.w('ERROR CATCH\n'+e.toString());
//     }
//   }

//   Future<List<String>> _getMateriales2(int idGrupo, int idCategoria) async {
//     try {
//       var parsedJsonP = json.decode(jsonProductosVarios);
//       var parsedJsonM = json.decode(jsonMateriales);

//       List<String> listaNombreMateriales = [];
//       List<int> listIdMateriales =  [];

//       for (var i = 0; i < parsedJsonP.length ; i++) {
//         if ( parsedJsonP[i]['id_grupo'] == idGrupo ) {
//           if ( parsedJsonP[i]['id_categoria'] == idCategoria ) {
//             listIdMateriales.add( parsedJsonP[i]['id_material']);
//           }
//         }
//       }

//       KtList<int> distinct = listFrom(listIdMateriales).distinct();
//       print(distinct);

//       for (var item in distinct.iter) {
//         print('item ktlist: ' + item.toString());
//         for (var j = 0; j < parsedJsonM.length ; j++) {
//           if ( parsedJsonM[j]['ID'] == item) {
//             listaNombreMateriales.add(parsedJsonM[j]['NOMBRE']);
//             print(listaNombreMateriales);
//           }
//         }
//       } 


//       return listaNombreMateriales;
//     } catch (e) {
//       logger.w('ERROR CATCH\n'+e.toString());
//     }
//   }

//   _getIdMateriales(int idGrupo, int idCategoria) async {
//     try {
//       var parsedJson = json.decode(jsonProductosVarios);
//       List<int> list1 =  [];


//       for (var i = 0; i < parsedJson.length ; i++) {
//         if ( parsedJson[i]['id_grupo'] == idGrupo ) {
//           if ( parsedJson[i]['id_categoria'] == idCategoria ) {
//             list1.add( parsedJson[i]['id_material']);
//           }
//         }
//       }

//       final distinct = listFrom(list1).distinct();
//       print(distinct);

//     } catch (e) {
//       logger.w('ERROR CATCH\n'+e.toString());
//     }
//   }

//   Future<List<PromocionesModel>> _getPromociones() async {
//     try {
//       var parsedJsonPromociones = json.decode(jsonPromociones);
//       /* LISTA LOS PRODUCTOS Filtrado por GRUPO <------------------------------------ */
//       List<PromocionesModel> promociones = [];
//       for(var p in parsedJsonPromociones){
//         PromocionesModel promocion = PromocionesModel(p["id"], p["id_producto"], p["des_corta"], p["des_larga"], p["foto"], p["precio_oferta"], p["fec_inicio"], p["fec_vencimiento"], p["estado"]);
//         promociones.add(promocion);
//       }
//       return promociones;
//     } catch (e) {
//       logger.w('ERROR CATCH\n'+e.toString());
//     }
//   }

//   Future<List<ProductosModel>>  _getProductos(int idMaterial) async {
//     /* Personalizar poara el API en la nube. */
//     /* var data = await http.get("https://miincode.firebaseio.com/usuarios.json");
//     var jsonData = json.decode(data.body);
//     print('jsonData:\n'+jsonData.toString());
//     */

//     try {
//       var parsedJson_Productos = json.decode(jsonProductosVarios);

//       SharedPreferences sp = await SharedPreferences.getInstance();
//       // Obttiene el Grupo y Categoria Seleccionados.
//       var grupo = sp.getString(spProductosGrupo);
//       var categoria = sp.getString(spProductosCategoria);



//       setState(() {
//         tituloGrupo = grupo;
//         tituloCategoria = categoria;
//       });

//       switch(grupo) {
//         case 'Hombres'    : idGrupo = 1;  break;
//         case 'Mujeres'    : idGrupo = 3;  break;
//         case 'Recuerdos'  : idGrupo = 5;  break;
//       }

//       switch (categoria) {
//         case 'Collares'           : idCategoria = 1;  break;
//         case 'Pulseras'           : idCategoria = 2;  break;
//         case 'Aretes'             : idCategoria = 3;  break;
//         case 'Pulsera Tobillera'  : idCategoria = 4;  break;
//         case 'Packs'              : idCategoria = 5;  break;
//         case 'Otros'              : idCategoria = 6;  break;
//         case 'Eventos'            : idCategoria = 7;  break;
//         case 'Anillos'            : idCategoria = 8;  break;
//       }

//       /* LISTA las CATEGORIAS */
//       List<int> idMateriales =[];
//       /* LISTA LOS PRODUCTOS Filtrado por GRUPO <------------------------------------ */
//       List<ProductosModel> productos = [];

//       for(var p in parsedJson_Productos){
//         if (p["id_grupo"] == idGrupo) {  
//           if (p["id_categoria"] == idCategoria) {
//             if (p["id_material"] == idMaterial) {
//               ProductosModel producto = ProductosModel(p["id"], p["codigo"], p["id_categoria_material"], p["id_categoria"], p["id_material"], p["id_grupo"], p["grupo"], p["nombre"], p["descripcion"], p["precio"], p["stock"], p["foto"], p["estado"]);
//               productos.add(producto);
//               //print('========================================================>'+parsedJson_Productos.length.toString());
//             }
//           }
//         }
//       }

//       return productos;
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       //title: title,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: showAppBar(context, tituloCategoria + ': ' + tituloGrupo),
//         body: Column(
//           children: <Widget>[
//             // BLOQUE ---> PROMOCIONES
//             /*
//             Container(
//               child: Column(
//                 children: <Widget>[
//                   // HEADER ---> PROMOCIONES
//                   Container(
//                     height: 30,
//                     padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                     alignment: Alignment.centerLeft,
//                     decoration: BoxDecoration(
//                       //color: Color.fromRGBO(253, 247, 22, 1),
//                       border: Border(
//                         //bottom: BorderSide(color: Colors.red[500], style: BorderStyle.solid, width: 1), 
//                         //top: BorderSide(color: Colors.red[500], style: BorderStyle.solid, width: 1)

//                         //bottom: BorderSide(color: Colors.red[500], style: BorderStyle.solid, width: 1), 
//                         //top: BorderSide(color: Colors.red[500], style: BorderStyle.solid, width: 1)
//                         bottom: BorderSide(color: Color.fromRGBO(253, 247, 22, 1), style: BorderStyle.solid, width: 1), 
//                         top: BorderSide(color: Color.fromRGBO(253, 247, 22, 1), style: BorderStyle.solid, width: 1)
//                       )
//                     ),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           'PROMOCIONES',
//                           style: TextStyle(
//                             //color: Colors.red[500],
//                             //color: Colors.red[500],
//                             color: Color.fromRGBO(253, 247, 22, 1),
//                             fontWeight: FontWeight.bold
//                           )
//                         ),
//                         //Icon(Icons.arrow_right, color: Colors.white)
//                         //Icon(Icons.arrow_right, color: Colors.red[500])
//                         Icon(Icons.arrow_right, color: Color.fromRGBO(253, 247, 22, 1))
//                       ]
//                     )
//                   ),

//                   // BODY ---> PROMOCIONES
//                   Container(
//                     height: 150,
//                     //color: Colors.black38,
//                     child: Center(
//                       child: FutureBuilder(
//                         future: _getPromociones(),
//                         builder: (BuildContext context, AsyncSnapshot snapshotPromociones){
//                           if ( snapshotPromociones.data == null) {
//                             return Container(
//                               child: CircularProgressIndicator()
//                             );
//                           } else {  
//                             return ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: snapshotPromociones.data.length,
//                               itemBuilder: (BuildContext context, int index0){
//                                 return Container(
//                                   margin: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     //border: Border.all(color: Colors.red[500], style: BorderStyle.solid, width: 1),
//                                     border: Border.all(color: Color.fromRGBO(253, 247, 22, 1), style: BorderStyle.solid, width: 1),
//                                     borderRadius: BorderRadius.circular(17)
//                                   ),
//                                   child: caraFrontal(
//                                     context, 
//                                     snapshotPromociones.data[index0].foto, 
//                                     snapshotPromociones.data[index0].des_corta,
//                                     snapshotPromociones.data[index0].des_larga,
//                                     snapshotPromociones.data[index0].estado,
//                                     '',
//                                     snapshotPromociones.data[index0].precio_oferta,
//                                     'DEFAULT-$index0'
//                                   )
//                                 );
//                               }
//                             );                          
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ), */
            
//             // BLOQUE PRODUCTOS por CATEGORIAS
//             Expanded(
//               child: Container(
//                 //color: Colors.blue,
//                 child: FutureBuilder(
//                   future: _getMateriales(),
//                   builder: (BuildContext  context, AsyncSnapshot snapshotMateriales){
//                     if ( snapshotMateriales.data == null) {
//                       return Container(
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             backgroundColor: Colors.white
//                           )
//                         )
//                       );
//                     } else {
//                       //_getIdMateriales(idGrupo, idCategoria);
//                       _getMateriales2(idGrupo, idCategoria);

//                       return ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: snapshotMateriales.data.length,
//                         itemBuilder: (BuildContext context, int index){
//                           //print('Se encontraron '+snapshotMateriales.data.length.toString() + ' materiales');
//                           if ( snapshotMateriales.data.length == 0 ) {
//                             print('NO Se encontraron MATERIALES ['+snapshotMateriales.data.length.toString() + ']');
//                             Container(
//                               child: Text('No se encontraron Materiales', style: TextStyle(color: Colors.white),),
//                             );
//                           } else {
//                             return Container(
//                               child: Column(
//                                 children: <Widget>[
//                                   // HEADER ---> PRODUCTOS x MATERIAL
//                                   Container(
//                                     padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                                     alignment: Alignment.centerLeft,
//                                     //height: 50,
//                                     decoration: BoxDecoration(
//                                       //color: Colors.blue[500],
//                                       border: Border(
//                                         bottom: BorderSide(color: Colors.blue[500], style: BorderStyle.solid, width: 1), 
//                                         //top: BorderSide(color: Colors.blue[500], style: BorderStyle.solid, width: 1)
//                                       )
//                                     ),
//                                     child: Row(
//                                       children: <Widget>[
//                                         Text(  
//                                           snapshotMateriales.data[index].nombre,
//                                           style: TextStyle(
//                                             //color: Colors.white,
//                                             color: Colors.blue[500],
//                                             fontWeight: FontWeight.bold
//                                           )
//                                         ),
//                                         Icon(Icons.arrow_right, color: Colors.blue[500])
//                                       ],
//                                     )
//                                   ),
//                                   // BODY ---> PRODUCTOS x MATERIAL
//                                   Container(
//                                     //margin: EdgeInsets.fromLTRB(3, 0, 3, 3),
//                                     height: 150,
//                                     color: Colors.black38,
//                                     child: Center(
//                                       child: FutureBuilder(
//                                         future: _getProductos(snapshotMateriales.data[index].id),
//                                         builder: (BuildContext context, AsyncSnapshot snapshotProductos){
//                                           //print('---->Materiales ' + snapshotMateriales.data[index].id.toString());
//                                           if ( snapshotProductos.data == null) {
//                                             return Container(
//                                               child: Text('NULOOOOOOOOOO'),
//                                               /* child: Center(
//                                                 child: CircularProgressIndicator(
//                                                   backgroundColor: Colors.black12
//                                                 )
//                                               ) */
//                                             );
//                                           } else {                                        
//                                             return ListView.builder(
//                                               scrollDirection: Axis.horizontal,
//                                               itemCount: snapshotProductos.data.length,
//                                               itemBuilder: (BuildContext context, int index2){

//                                                 return Container(
//                                                   margin: EdgeInsets.all(5),
//                                                   child: caraFrontal(
//                                                     context, 
//                                                     snapshotProductos.data[index2].foto, 
//                                                     snapshotProductos.data[index2].nombre,
//                                                     snapshotProductos.data[index2].descripcion,
//                                                     1, snapshotProductos.data[index2].precio.toString(),
//                                                     '',
//                                                     snapshotProductos.data[index2].codigo
//                                                   ),
//                                                 );
//                                               }
//                                             );
//                                           }
//                                         }
//                                       ) 
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           }
//                         }
//                       );
//                     }    
//                   }
//                 )
//               )
//               //child: _gridProductos(context)              
//             )
//           ],
//         )
//       )
//     );
//   }

// }

// Widget caraFrontal(BuildContext context, String foto, String nombreProducto, String descripcion, int estado, String precioNormal, String precioOferta, String codigo) {
//   //print(foto+' '+nombreProducto+' '+descripcion+' '+ estado.toString());
//   bool existeFoto;
//   String precio_normal;
//   String precio_oferta;
//   if(foto.isEmpty){ existeFoto = false; }

//   return Container(
//     child: Stack(
//       alignment: Alignment.bottomCenter,
//       children: <Widget>[
//         // Imagen del PRODUCTO de fondo.
//         GestureDetector(
//           child: Container(
//             width: 150,
//             //height: 250,
//             alignment: Alignment.center,
//             child: ( foto == '' || foto.isEmpty ) 
//                 ? Image(image: AssetImage('assets/no-image.png'))
//                 : ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: FadeInImage(
//                     image: NetworkImage( foto ),
//                     placeholder: AssetImage('assets/jar-loading.gif'),
//                     height: 150.0,
//                     width: 150.0, //double.infinity,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//           ),
//           onTap: (){
//             showDetalle(context, nombreProducto, descripcion, foto, estado, '', precioOferta, codigo);
//           },
//         ),
//         // Precio PROMOCION
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: Container(
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 Image.asset('assets/icons/promocion.png'),
//                 Text('s/.\n' + precioOferta, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
//               ],
//             ),
//           )
//         ),
//         // Código ID del PRODUCTO
//         Positioned.directional(
//           top: 0,
//           start: 0,          
//           textDirection: TextDirection.ltr,
//           child: Container(
//             margin: EdgeInsets.fromLTRB(3, 3, 0, 0),
//             padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//             decoration: BoxDecoration(
//               color: Colors.white70,
//               borderRadius: BorderRadius.circular(5)
//             ),
//             child: Text(
//               codigo,style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold
//               ),
//             )
//           )
//         )
//       ]
//     ),
//   );
// }

// /*
//   FUENTE: 
//   - https://medium.com/flutter-community/how-to-parse-json-in-flutter-for-beginners-8074a68d7a79
//   - https://www.filledstacks.com/tag/Animation/
// */