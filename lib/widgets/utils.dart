import 'package:bellmoi_catalog/main.dart';
import 'package:bellmoi_catalog/pages/home.dart';
import 'package:bellmoi_catalog/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* ----- LOGGER ---------------- */
var logger = Logger( printer: PrettyPrinter(), );
var loggerNoStack = Logger( printer: PrettyPrinter(methodCount: 0), );
/* ----- LOGGER ---------------- */

/*=========================================== PERSISTENCIA DE DATOS =========================================== */
  // Variables ---> SESION INICIADA.
  final String spSesionEstado = 'spSesionEstado';
  final String spSesionEmail = 'spSesionEmail';

  // variables ---> Grupos - Categorias - Materiales
  final String spProductosGrupo               = 'spProductosGrupo';
  final String spProductosCategoria           = 'spProductosCategoria';
  final String spProductosMaterial            = 'spProductosMaterial';
  final String spProductosFechaActualizacion  = 'spProductosFechaActualizacion';
/*=========================================== PERSISTENCIA DE DATOS =========================================== */

final formatter = new NumberFormat("#.##");


iniciarvariablesDeSesion(BuildContext context) async {
  try {
    SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setBool(spSesionEstado, true);                         // true = INICIADA  false = NO iniciada
    sp.setString(spSesionEmail, 'invitado@invitado.com');     // Por default sin LOGIN "invitado@invitado.com"
  } catch (e) {
    logger.w(e.toString());
  }
}

indicarGrupoElegido(BuildContext context, String grupo) async {
  try {
    SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString(spProductosGrupo, grupo);
    spPintarDatosPersistencia();
    // Opciones: Hombres - Mujeres - Recuerdos
  } catch (e) {
    logger.w(e.toString());
  }
}

indicarCategoriaElegida(BuildContext context, String categoria) async {
  try {
    SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString(spProductosCategoria, categoria);
    spPintarDatosPersistencia();
  } catch (e) {
    logger.w(e.toString());
  }
}

spPintarDatosPersistencia() async {
  SharedPreferences sp = await SharedPreferences.getInstance();  
  logger.i(
  '=================================================\n =================================================\n'+
  'sp.getString(spSesionEstado): '        +sp.getBool(spSesionEstado).toString()+'\n'+
  'sp.getString(spSesionEmail): '         +sp.getString(spSesionEmail)+'\n'+

  'sp.getString(spProductosGrupo): '      +sp.getString(spProductosGrupo).toString()+'\n'+
  'sp.getString(spProductosCategoria): '  +sp.getString(spProductosCategoria).toString()+'\n'+
  'sp.getString(spProductosMaterial): '   +sp.getString(spProductosMaterial).toString()+'\n'+
  '=================================================\n =================================================');
}
/* ALERTAS -----------------------------------------------------------------------------------------------------*/
showAlertDialogRedireccionableOpcSIno(BuildContext context, String titulo, String mensaje, String page) {
  Widget siButton = FlatButton(
    child: Text( 'SI', style: TextStyle(color: Colors.green, fontSize: 30,) ),
    onPressed: (){
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, page);
    }
  );

  Widget noButton = FlatButton(
    child: Text( 'NO', style: TextStyle(color: Colors.red, fontSize: 30,) ),
    onPressed: (){
      Navigator.of(context).pop();
    }
  );

  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
    backgroundColor: Colors.black87,
    contentTextStyle: TextStyle(color: Color.fromRGBO(39, 191, 178, 1)),
    titleTextStyle: TextStyle(color: Color.fromRGBO(39, 191, 178, 1), fontSize: 20, fontWeight: FontWeight.bold),
    title: Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: prefix0.TextDirection.ltr,
        children: <Widget>[
          Icon(
            Icons.priority_high,
            color: Colors.red,
            size: 50,
            textDirection: prefix0.TextDirection.ltr,
          ),
          Text(titulo, style: TextStyle(color: Colors.red, fontSize: 25), textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    content: Text(
      '\n'+mensaje,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    actions: <Widget>[
      siButton,
      noButton
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}

showAlertDialog(BuildContext context, String titulo, String mensaje) {
  Widget okButton = FlatButton(
    child: Text( 'OK', style: TextStyle(color: Colors.green, fontSize: 30,) ),
    onPressed: (){
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }
  );

  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
    backgroundColor: Colors.black87,
    contentTextStyle: TextStyle(color: Color.fromRGBO(39, 191, 178, 1)),
    titleTextStyle: TextStyle(color: Color.fromRGBO(39, 191, 178, 1), fontSize: 20, fontWeight: FontWeight.bold),
    title: Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: prefix0.TextDirection.ltr,
        children: <Widget>[
          Icon(
            Icons.priority_high,
            color: Colors.red,
            size: 50,
            textDirection: prefix0.TextDirection.ltr,
          ),
          Text(titulo, style: TextStyle(color: Colors.red, fontSize: 25),  textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    content: Text(
      '\n'+mensaje,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    actions: <Widget>[
      okButton
    ],
  );

  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return alert;
    }
  );
}

showDetalle(BuildContext context, String nombreProducto, String descripcion, String foto, int estado, double precioNormal, double precioOferta, String codigo, int idProducto) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    titlePadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),

    title: Container(
      child: Column(
        children: <Widget>[
          // 1. NOMBRE del Producto
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(nombreProducto, 
              textAlign: TextAlign.center, 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22
              )
            ),
          ),
          // descripcion
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              //child: Text(descripcion,
              child: Text('COntenido super largo de relleno para ver si se acopla o no a la caja... contenido de relleno...',//descripcion,
                
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
    // 3. IMAGEN del Producto
    content: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: <Widget>[
          Image.network(foto, alignment: Alignment.center),
          // Código ID del PRODUCTO
          Positioned.directional(
            top: 0,
            start: 0,
            textDirection: prefix0.TextDirection.ltr,
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
        ],
      )
    ),

    actions: <Widget>[

      Column(
        children: <Widget>[          
          // 5. 3 ITEMS
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: Row(

              
              children: <Widget>[
                
                IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                    size: 35,
                  ),
                  onPressed: (){
                    print('Diste LIKE ');
                  }
                ),

                // ----> PRECIO NORMAL  <-------------------            
                precioNormal != null ? Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, style: BorderStyle.solid, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
    //                    alignment: Alignment.bottomRight,
                  child: Text('P. Normal\nS/. ' + formatter.format(precioNormal), style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.right,),
                ) : Container(),

                // ----> PRECIO OFERTA  <-------------------            
                precioOferta != null ? Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, style: BorderStyle.solid, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text('P. Oferta\nS/. '+ formatter.format(precioOferta), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.right),
                ) : Container()
                
              ],
            ),
          )
        
        ],
      ),
    ],

  );

  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return alert;
    }
  );
}

showMedidas(BuildContext context, String imagen) {

  AlertDialog alert = AlertDialog(
    titlePadding: EdgeInsets.all(0),
    title: Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      //color: Colors.black87,
      child: Stack(
        textDirection: prefix0.TextDirection.ltr,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            child: Image.asset(imagen, alignment: Alignment.center)
          ),
        ]
      )
    ),
    content: null,
    actions: null
  );

  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return alert;
    }
  );
}

// APPBAR -------------------------------------------------------------
Widget showAppBar(BuildContext context, String titulo){
  return AppBar(
    backgroundColor: Colors.black87,
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
      child: GestureDetector(
        child: Image(
          image: ExactAssetImage('assets/logo/bellmoi3.png'),
          height: 20,
        ),
        onTap: (){
          print('Llego a HOME');
        },
      ),
    ),
    title: Text(titulo),
    actions: <Widget>[
      PopupMenuButton<String>(
        onSelected: (value){ 
          choiceAction(context, value);
        },
        itemBuilder: (BuildContext context){
          return Constants.choices.map((String choice){
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice)
            );
          }).toList();
        }
      ),
      IconButton(
        icon: Icon(Icons.power_settings_new, color: Colors.redAccent,),
        onPressed: (){
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      )
    ]
  );
}

choiceAction(BuildContext context, String choice) {
  if (choice == Constants.TallasCollares) {
    //Navigator.pushReplacementNamed(context, GuiaTallas();
    showMedidas(context, 'assets/medidas1.png');
  } else if(choice == Constants.TallasPulseras){
    showMedidas(context, 'assets/medidas2.png');
  } else if(choice == Constants.SignOut){
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

goPage(BuildContext context, Widget page) {
  SchedulerBinding.instance.addPostFrameCallback((_) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  });
}

//==================================================================================================================================
// COLORES PREDEFINIDOS =================================================================
  
  double opacidad_1 = 1;
  double opacidad_08 = 0.8;
  double opacidad_05 = 0.5;
  double opacidad_03 = 0.3;
  Color colorCatMujeres_1   = Color.fromRGBO(255, 105, 180, opacidad_1);
  Color colorCatMujeres_08  = Color.fromRGBO(255, 105, 180, opacidad_08);
  Color colorCatMujeres_05   = Color.fromRGBO(255, 105, 180, opacidad_05);
  Color colorCatMujeres_03   = Color.fromRGBO(255, 105, 180, opacidad_03);

  Color colorCatHombres_1 = Color.fromRGBO(0, 191, 255, opacidad_1);
  Color colorCatHombres_08 = Color.fromRGBO(0, 191, 255, opacidad_08);
  Color colorCatHombres_05 = Color.fromRGBO(0, 191, 255, opacidad_05);
  Color colorCatHombres_03 = Color.fromRGBO(0, 191, 255, opacidad_03);

  Color colorCatRecuerdos_1 = Color.fromRGBO(147, 112, 219, opacidad_1);
  Color colorCatRecuerdos_08 = Color.fromRGBO(147, 112, 219, opacidad_08);
  Color colorCatRecuerdos_05 = Color.fromRGBO(147, 112, 219, opacidad_05);
  Color colorCatRecuerdos_03 = Color.fromRGBO(147, 112, 219, opacidad_03);

//==================================================================================================================================
//==================================================================================================================================