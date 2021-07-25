import 'package:flutter/material.dart';
import 'package:formaulario_y_bloc/src/bloc/productos_bloc.dart';
import 'package:formaulario_y_bloc/src/bloc/provider.dart';
// import 'package:formaulario_y_bloc/src/bloc/provider.dart';
import 'package:formaulario_y_bloc/src/models/productoModel.dart';
// import 'package:formaulario_y_bloc/src/providers/producto_provider.dart';

class HomePage extends StatelessWidget {
  // final productoProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    final productosBloc = Provider.productoBloc(context);
    productosBloc.cargarProductos();
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos!.length,
            itemBuilder: (context, i) =>
                _crearItem(context, productosBloc, productos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) =>
            productosBloc.borrarProducto(producto.id.toString()),
        child: Card(
          child: Column(
            children: <Widget>[
              (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl.toString()),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id.toString()),
                onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
              ),
            ],
          ),
        ));
  }
}
