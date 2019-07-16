import 'package:flutter/material.dart';
import 'package:app_pelicula_seccion7/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Detalle"),),
      body: Center(
        
        child: Text(pelicula.title),
      ),
    );
  }
}
