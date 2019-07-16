import 'package:app_pelicula_seccion7/src/providers/peliculas_provider.dart';
import 'package:app_pelicula_seccion7/src/widgets/card_swiper_widget.dart';
import 'package:app_pelicula_seccion7/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Peliculas en cines"),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            _swiperTarjetas(),
            Column(
              children: <Widget>[
                _footer(context) //argumento debido al stack
              ],
            )
          ],
        )));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
              height: 300.9, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: (MediaQuery.of(context).size).height * 0.5 + 70.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text("Populares", style: Theme.of(context).textTheme.subhead),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
