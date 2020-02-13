//import 'dart:convert';

// PromocionesModel codigosFromJson(String str) => PromocionesModel.fromJson(json.decode(str));
// String codigosToJson(PromocionesModel data) => json.encode(data.toJson()); 

class PromocionesModel {
  final int id;
  final int id_producto;
  final String des_corta;
  final String des_larga;
  final String foto;
  final double precio_oferta;
  final String fec_inicio;
  final String fec_vencimiento;
  final int estado;

  PromocionesModel(
    //{
    this.id, this.id_producto, this.des_corta, this.des_larga, this.foto, this.precio_oferta, this.fec_inicio, this.fec_vencimiento, this.estado
    //}
  );
  
/*    factory PromocionesModel.fromJson(Map<String, dynamic> json) {
    return PromocionesModel(
      id                : json["id"],
      id_producto       : json["id_producto"],
      des_corta         : json["des_corta"],
      des_larga         : json["des_larga"], 
      foto              : json["foto"],
      precio_oferta     : json["precio_oferta"],
      fec_inicio        : json["fec_inicio"],
      fec_vencimiento   : json["fec_vencimiento"],
      estado            : json["estado"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id"                : id,
    "id_producto"       : id_producto,
    "des_corta"         : des_corta,
    "des_larga"         : des_larga,
    "foto"              : foto,
    "precio_oferta"     : precio_oferta,
    "fec_inicio"        : fec_inicio,
    "fec_vencimiento"   : fec_vencimiento,
    "estado"            : estado,
  }; */ 

}

/*
  FUENTE: https://app.quicktype.io/
  -----> 
 */