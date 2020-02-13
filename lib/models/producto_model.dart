
class ProductosModel {
  final int id;
  final String codigo;
  final int id_categoria_material;
  final int id_categoria;
  final int id_material;
  final int id_grupo;
  final String grupo;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final String foto;
  final int estado;

  ProductosModel(
    this.id,
    this.codigo,
    this.id_categoria_material, 
    this.id_categoria, 
    this.id_material, 
    this.id_grupo, 
    this.grupo, 
    this.nombre, 
    this.descripcion, 
    this.precio, 
    this.stock, 
    this.foto, 
    this.estado
  );

    /* ProductosModel({
    this.id,
    this.codigo,
    this.id_categoria_material, 
    this.id_categoria, 
    this.id_material, 
    this.id_grupo, 
    this.grupo, 
    this.nombre, 
    this.descripcion, 
    this.precio, 
    this.stock, 
    this.foto, 
    this.estado
    });

  factory ProductosModel.fromJson(Map<String, dynamic> json) {
    return ProductosModel(
      id                      : json['id'],
      codigo                  : json['codigo'],
      id_categoria_material   : json['id_categoria_material'],
      id_categoria            : json['id_categoria'],
      id_material             : json['id_material'],
      id_grupo                : json['id_grupo'],
      grupo                   : json['grupo'],
      nombre                  : json['nombre'],
      descripcion             : json['descripcion'],
      precio                  : json['precio'],
      stock                   : json['stock'],
      foto                    : json['foto'],
      estado                  : json['estado'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id"                      : id,
    "codigo"                  : codigo,
    "id_categoria_material"   : id_categoria_material,
    "id_categoria"            : id_categoria,
    "id_material"             : id_material,
    "id_grupo"                : id_grupo,
    "grupo"                   : grupo,
    "nombre"                  : nombre,
    "descripcion"             : descripcion,
    "precio"                  : precio,
    "stock"                   : stock,
    "foto"                    : foto,
    "estado"                  : estado
  }; */
  
}

/*
  FUENTE: https://app.quicktype.io/
  -----> 
 */