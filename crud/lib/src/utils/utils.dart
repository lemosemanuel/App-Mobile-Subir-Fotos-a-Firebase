import 'package:flutter/material.dart';

bool esNumero(String i) {
  // si es nulo ya de por si no es un numero , retorno false
  if (i.isEmpty) return false;
  // veo si se puede parsear a numero
  final n = num.tryParse(i);
  return (n == null) ? false : true;
}

mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informacion incorrecta'),
          content: Text(mensaje),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}
