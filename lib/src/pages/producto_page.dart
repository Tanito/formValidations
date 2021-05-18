import 'package:flutter/material.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProdcutoPage extends StatefulWidget {
  @override
  _ProdcutoPageState createState() => _ProdcutoPageState();
}

class _ProdcutoPageState extends State<ProdcutoPage> {

  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductosProvider();
  
  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _crearNombre(),
                    _crearPrecio(),
                    _crearDisponible(),
                    _crearBoton(),
                  ],
                ))),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      }
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumber(value)) {
          return null;
        } else {
          return 'Ingrese sólo números';
        }
      }
    );
  }

  Widget _crearDisponible(){

    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.greenAccent,
      onChanged: (value)=> setState((){
        producto.disponible = value;
      }),
      );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return Colors.green;
          }),
        ),
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        autofocus: true,
        onPressed: _submit
        );
  }

  void _submit() {

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print( producto.titulo );
    print( producto.valor );
    print( producto.disponible );

    productoProvider.crearProducto(producto);
  }
}
