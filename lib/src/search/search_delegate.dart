import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar(icono para limpiar el campo)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      icon:Icon(Icons.arrow_back),
      onPressed: () {
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    return Container();
  }
}
