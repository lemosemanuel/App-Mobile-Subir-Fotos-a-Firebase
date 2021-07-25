import 'dart:io';

import 'package:formaulario_y_bloc/src/models/productoModel.dart';
import 'package:formaulario_y_bloc/src/providers/producto_provider.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc {
  final _productosController = BehaviorSubject<List<ProductoModel>>();
  final _cargandoControlller = BehaviorSubject<bool>();

  final _productosProvider = ProductosProvider();

  // escucho los dos string de _productosController y _cargandoController
  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;
  Stream<List<ProductoModel>> get cargando => _productosController.stream;

  cargarProductos() async {
    final productos = await _productosProvider.cargarProductos();
    // ahora inserto ese productos al string de _productoscontrollers
    _productosController.sink.add(productos);
  }

  agregarProducto(ProductoModel producto) async {
    _cargandoControlller.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoControlller.sink.add(false);
  }

  Future<String?> subirFoto(File foto) async {
    _cargandoControlller.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoControlller.sink.add(false);
    return fotoUrl;
  }

  editarProducto(ProductoModel producto) async {
    _cargandoControlller.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargandoControlller.sink.add(false);
  }

  borrarProducto(String id) async {
    await _productosProvider.eliminarProductos(id);
  }

  dispose() {
    _productosController.close();
    _cargandoControlller.close();
  }
}
