import 'package:flutter/material.dart';
import 'package:formaulario_y_bloc/src/bloc/login_bloc.dart';
import 'package:formaulario_y_bloc/src/bloc/productos_bloc.dart';
export 'package:formaulario_y_bloc/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  // llamo la clase del login_bloc.dart
  final loginBloc = LoginBloc();

  final _productosBloc = ProductosBloc();

  // creo la instancia actual
  static Provider? _instancial;
  factory Provider({Key? key, required Widget child}) {
    if (_instancial == null) {
      _instancial = new Provider._internal(key: key, child: child);
    }
    return _instancial!;
  }
  // creo el contructor
  Provider._internal({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .loginBloc;
  }

  static ProductosBloc productoBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        ._productosBloc;
  }
}
