import 'package:app_pelicula_seccion7/src/models/pelicula_model.dart';
import 'package:app_pelicula_seccion7/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String seleccion='';
  final peliculasProvider=new PeliculasProvider();
  final peliculas = [
    'Avengers',
    'Xmen',
    'Mulan',
    'Malefica',
    'Transformers',
    'Rapidos y furiosos'
  ];
  final peliculasRecienes = [
    'Spiderman',
    'Capitan ameirca'
        'algo mas'
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar(icono para limpiar el campo)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height:100.0,
        width:100.0,
        color:Colors.blue,
        child: Text(seleccion),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context){
    if(query.isEmpty){
      print("esta vacio");
      return Container();
    }
    return FutureBuilder(
      future:peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
        if(snapshot.hasData){
          return ListView(
            children: snapshot.data.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPostImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, '');
                  pelicula.uniqueId='';
                  Navigator.pushNamed(context, 'detalle',arguments:pelicula);
                },
              );
            }).toList()
          );
        }else{
          return Center(child:CircularProgressIndicator());
        }
      },
    );
  }
//  @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe
  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecienes
  //       : peliculas.where((p) {
  //           return p.toLowerCase().startsWith(query.toLowerCase());
  //         }).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion=listaSugerida[i];
  //           showResults(context);
            
  //         },
  //       );
  //     },
      
  //   );
  // }
}
