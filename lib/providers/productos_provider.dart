import 'dart:convert';

import 'package:bellmoi_catalog/models/materiales_model.dart';
import 'package:bellmoi_catalog/models/producto_model.dart';
import 'package:bellmoi_catalog/models/promociones_model.dart';
import 'package:bellmoi_catalog/pages/productos_page.dart';
import 'package:bellmoi_catalog/widgets/json.dart';
import 'package:bellmoi_catalog/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';
import 'package:shared_preferences/shared_preferences.dart';

int idGrupo;
int idCategoria;
String tituloGrupo = '';
String tituloCategoria = '';

//void main() => runApp(ProductosProvider());

class ProductosProvider extends StatefulWidget {
  @override
  _ProductosProviderState createState() => _ProductosProviderState();

  List<int> getMateriales2(int idGrupo, int idCategoria) {
    try {
      var parsedJsonP = json.decode(jsonProductosVarios);
      var parsedJsonM = json.decode(jsonMateriales);

      List<String> listaNombreMateriales = [];
      List<int> listIdMateriales = [];
      List<int> listIds = [];

      for (var i = 0; i < parsedJsonP.length; i++) {
        if (parsedJsonP[i]['id_grupo'] == idGrupo) {
          if (parsedJsonP[i]['id_categoria'] == idCategoria) {
            listIdMateriales.add(parsedJsonP[i]['id_material']);
          }
        }
      }

      KtList<int> distinct = listFrom(listIdMateriales).distinct();

      for (var item in distinct.iter) {
        for (var j = 0; j < parsedJsonM.length; j++) {
          if (parsedJsonM[j]['ID'] == item) {
            listaNombreMateriales.add(parsedJsonM[j]['NOMBRE']);
            listIds.add(parsedJsonM[j]['ID']);
          }
        }
      }
      return listIds;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  Future<List<PromocionesModel>> getPromociones(int idGrupo, idCategoria) async {
    try {
      var parsedJsonPromociones = json.decode(jsonPromociones);
      var parsedJsonProductos = json.decode(jsonProductosVarios);

      for (var prod in parsedJsonProductos) {}
      /* LISTA LOS PRODUCTOS Filtrado por GRUPO <------------------------------------ */
      List<PromocionesModel> promociones = [];
      for (var p in parsedJsonPromociones) {
        PromocionesModel promocion = PromocionesModel(
            p["id"],
            p["id_producto"],
            p["des_corta"],
            p["des_larga"],
            p["foto"],
            p["precio_oferta"],
            p["fec_inicio"],
            p["fec_vencimiento"],
            p["estado"]);
        promociones.add(promocion);
      }
      return promociones;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  // Obtiene todas las promociones habilitadas en 1 PRODUCTO
  List<PromocionesModel> getPromocionesXIdProducto(int idProducto) {
    try {
      List<PromocionesModel> promociones = [];
      var parsedJsonPromociones = json.decode(jsonPromociones);
      for (var p in parsedJsonPromociones) {
        if (p["id_producto"] == idProducto) {
          PromocionesModel promocion = PromocionesModel(
              p["id"],
              p["id_producto"],
              p["des_corta"],
              p["des_larga"],
              p["foto"],
              p["precio_oferta"],
              p["fec_inicio"],
              p["fec_vencimiento"],
              p["estado"]);
          promociones.add(promocion);
        }
      }
      return promociones;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }


  //  DATOS DE LA PROMOCION ----------------------------

  String getDescCortoPromocion(int idProducto) {
    try {
      String dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["des_corta"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  String getDescLargaPromocion(int idProducto) {
    try {
      String dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["des_larga"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  String getFotoPromocion(int idProducto) {
    try {
      String dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["foto"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  double getPrecioPromocion(int idProducto) {
    try {
      double dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["precio_oferta"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  String getFecIniPromocion(int idProducto) {
    try {
      String dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["fec_inicio"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  String getFecFinPromocion(int idProducto) {
    try {
      String dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["fec_vencimiento"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  int getEstadoPromocion(int idProducto) {
    try {
      int dato;
      var parsedJsonPromocion = json.decode(jsonPromociones);
      for (var p in parsedJsonPromocion) {
        if (p["id_producto"] == idProducto) {
          dato = p["estado"];
        }
      }
      return dato;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  
  // DATOS DEL PRODUCTO...
  bool getHasPromotion(int idProducto, int idGrupo, int idCategoria) {
    try {
      bool estado = false;
      var parsedJsonProductos = json.decode(jsonProductosVarios);
      for (var p in parsedJsonProductos) {
        if (p["id"] == idProducto) {
          if (p["id_grupo"] == idGrupo) {
            if (p["id_categoria"] == idCategoria) {
              estado = true;
            } 
          }
        }
      }
      return estado;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  bool getPromotionsXGrupoCategoria(int idGrupo, int idCategoria) {
    try {
      /* int contador;
      bool estado = false;
      var parsedJsonPromociones = json.decode(jsonPromociones); 
      var parsedJsonProductos = json.decode(jsonProductosVarios);
      for (var item in parsedJsonPromociones) {
        for (var p in parsedJsonProductos) {
          if (item['id_producto'] == p['id'] ) {
             if (p["id_grupo"] == idGrupo) {
              if (p["id_categoria"] == idCategoria) {
                
                estado = true;
                contador = contador +1;
              } 
            }
          }
        }        
      }
      print('CONTADOR: '+contador.toString());
      return estado; */
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  double getPrecioNormalProducto(int idProducto) {
    try {
      ProductosModel producto;
      double precioNormal;
      var parsedJsonProductos = json.decode(jsonProductosVarios);
      for (var p in parsedJsonProductos) {
        if (p["id"] == idProducto) {
          precioNormal = p["precio"];
        }
      }
      return precioNormal;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

  String getCodigoProducto(int idProducto) {
    try {
      String codigo;
      var parsedJsonProductos = json.decode(jsonProductosVarios);
      for (var p in parsedJsonProductos) {
        if (p["id"] == idProducto) {
          codigo = p["codigo"];
        }
      }
      return codigo;
    } catch (e) {
      logger.w('ERROR CATCH\n' + e.toString());
    }
  }

}

class _ProductosProviderState extends State<ProductosProvider> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
