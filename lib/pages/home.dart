import 'package:bellmoi_catalog/widgets/categorias.dart';
import 'package:bellmoi_catalog/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/Constants/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

String tituloGrupo = '';
String tituloCategoria = '';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
} 

class _HomePageState extends State<HomePage> {

  
  String titulo;
  bool estadoCategoriasMujHom = true;
  bool estadoCategoriaMujeres = true;
  bool estadoCategoriaHombres = true;
  bool estadoCategoriaRecuerdos = true;

  final _keyCatMujeres = GlobalKey();
  final _keyCatHombres = GlobalKey();
  final _keyCatRecuerdos = GlobalKey();


  @override
  Widget build(BuildContext context) {

    setState(() {
      titulo = 'BellMoi - Catálogo';
    });
    iniciarvariablesDeSesion(context);

    // GRUPOS ---------------------------------------- INI
    final categoriaMujeres = [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: colorCatMujeres_05,
        padding: EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/grupos/dama.png', fit: BoxFit.cover)
            ),
          ],
        ),
      ),

      Container(
        color: colorCatMujeres_05,
        child: Center(
          child: subCatProductos(context),
        ),
      ),
    ];

    final categoriaHombres = [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: colorCatHombres_05,
        padding: EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/grupos/caballero2.png', fit: BoxFit.cover)
            ),
          ],
        ),
      ),
      Container(
        color: colorCatHombres_1,
        child: Center(
          child: catHombres(context),
        ),
      ),
    ];

    final categoriaRecuerdos = [

      Container(
        width: double.infinity,
        height: double.infinity,
        color: colorCatRecuerdos_05, //Color.fromRGBO(147, 112, 219, 0.5),
        padding: EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/grupos/recuerdo3.png', fit: BoxFit.cover)
            ),
          ],
        ),
      ),
      Container(
        color: Color.fromRGBO(147, 112, 219, 1),
        child: Center(
          child: catActividades(context) //ListaProductosPage()
        ),
      )
    ];
    // GRUPOS ---------------------------------------- FIN
    
    return Scaffold(
      appBar: showAppBar(context, titulo),
      body: WillPopScope(
        child:Container(
          color: Colors.black87,
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[

              // Categoria MUJERES y HOMBRES...
              estadoCategoriasMujHom ?
              Expanded(
                flex: 8,
                child: Container(
                  child: Row( 
                    children: <Widget>[
                      // MUJERES
                      estadoCategoriaMujeres ? 
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                          child: LiquidSwipe(
                            key: _keyCatMujeres,  
                            pages: categoriaMujeres,
                            fullTransitionValue: 200,
                            enableLoop: true,
                            enableSlideIcon: true,
                            positionSlideIcon: 0.95,
                            waveType: WaveType.liquidReveal,
                            onPageChangeCallback: (page) => pageChangeCallback(context, page, _keyCatMujeres),
                            //currentUpdateTypeCallback: ( updateType ) => updateTypeCallback( updateType ),
                            slideIconWidget: Icon( Icons.arrow_back_ios, size: 25, color: Colors.white,),
                          ),
                        ),
                      ) 
                      : Container(),
                      // HOMBRES
                      estadoCategoriaHombres ?
                      Expanded(
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: LiquidSwipe(
                            key: _keyCatHombres,
                            pages: categoriaHombres,
                            fullTransitionValue: 400,
                            enableLoop: true,
                            enableSlideIcon: true,
                            positionSlideIcon: 0.95,
                            waveType: WaveType.liquidReveal,
                            onPageChangeCallback: (page) => pageChangeCallback(context, page, _keyCatHombres),
                            //currentUpdateTypeCallback: ( updateType ) => updateTypeCallback( updateType ),
                            slideIconWidget: Icon(Icons.arrow_back_ios, size: 25, color: Colors.white,),
                          ),
                        ),
                      ) 
                      : Container(),
                    ],
                  ),
                ),
              ) 
              : Container(),
              
              // RECUERDOS
              estadoCategoriaRecuerdos ?
              Expanded(
                flex: 4,
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.all(0),
                  child: LiquidSwipe(
                    key: _keyCatRecuerdos,
                    pages: categoriaRecuerdos,
                    fullTransitionValue: 400,
                    enableLoop: true,
                    enableSlideIcon: true,
                    positionSlideIcon: 0.95,
                    waveType: WaveType.liquidReveal,
                    onPageChangeCallback: (page) => pageChangeCallback(context, page, _keyCatRecuerdos),
                    //currentUpdateTypeCallback: ( updateType ) => updateTypeCallback( updateType ),
                    slideIconWidget: Icon(Icons.arrow_back_ios, size: 25, color: Colors.white),
                  ),
                ),
              ) 
              : Container(),
            ],
          ),
        ),
        onWillPop: (){
          Future.value(false);
        }
      )
    );

  
/* FUENTE:  https://flutter.dev/docs/cookbook/navigation/navigation-basics */

  }

  pageChangeCallback(BuildContext context, int page, GlobalKey keySelect) {
    print('nroPage:'+page.toString()+'-key:' + keySelect.toString());


    if (page > 0 && keySelect == _keyCatMujeres) {
      setState(() {
        estadoCategoriaMujeres = true;
        estadoCategoriaHombres = false;
        estadoCategoriaRecuerdos = false;
        estadoCategoriasMujHom = true;
        titulo = 'BellMoi - Catálogo - Mujeres';
      });
        indicarGrupoElegido(context, 'Mujeres');
    } else if(page > 0 && keySelect == _keyCatHombres) {
      setState(() {
        estadoCategoriaMujeres = false;
        estadoCategoriaHombres = true;
        estadoCategoriaRecuerdos = false;
        estadoCategoriasMujHom = true;
        titulo = 'BellMoi - Catálogo - Hombres';
      }); 
      indicarGrupoElegido(context, 'Hombres');
    } else if(page > 0 && keySelect == _keyCatRecuerdos) {
      setState(() {
        estadoCategoriaMujeres = false;
        estadoCategoriaHombres = false;
        estadoCategoriaRecuerdos = true;
        estadoCategoriasMujHom = false;
        titulo = 'BellMoi - Catálogo - Recuerdos';
      });
      indicarGrupoElegido(context, 'Recuerdos');
      /* Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => ListaProductosPage()
        )
      ); */
    } else {
      if(page == 0){
        setState(() {
          estadoCategoriaMujeres = true;
          estadoCategoriaHombres = true;
          estadoCategoriaRecuerdos = true;
          estadoCategoriasMujHom = true;
        }); 
      }
    }
  }

    /* updateTypeCallback( UpdateType updateType ) {
      print(updateType);
    } */
}


/* 
  FUENTE: https://www.youtube.com/watch?v=svvJFb-LsgY 
*/

