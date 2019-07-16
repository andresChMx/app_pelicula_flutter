import 'package:app_pelicula_seccion7/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageController=new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );
  MovieHorizontal({@required this.peliculas,@required this.siguientePagina});
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){
      if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
        siguientePagina();
      }
    });
    return Container(
        height: (MediaQuery.of(context).size.height * 0.5) - 200.0,
        child: PageView(
          pageSnapping: false,
          controller:_pageController,
          children: _tarjetas(context),
        ));
  }

  List<Widget> _tarjetas(context) {
    return peliculas.map((pelicula) {
      return Container(
          margin: EdgeInsets.only(right: 20.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPostImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  height: (MediaQuery.of(context).size.height * 0.45) - 200.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ));
    }).toList();
  }
}
