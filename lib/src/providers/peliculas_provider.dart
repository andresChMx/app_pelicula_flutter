import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_pelicula_seccion7/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey="edd945b7ba2974a33ebbb8ee0bce990f";
  String _url="api.themoviedb.org";
  String _languaje="es-ES";
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp=await http.get(url);
    Map<String,dynamic> decodedData=json.decode(resp.body);
    Peliculas peliculas=new Peliculas.fromJsonList(decodedData["results"]);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async{
    final url=Uri.https(_url,"3/movie/now_playing",{
      'api_key' :_apikey,
      'languaje':_languaje  
    });
    return _procesarRespuesta(url);

  }
  Future<List<Pelicula>> getPopulares() async{
    final url=Uri.https(_url,"3/movie/popular",{
      'api_key' :_apikey,
      'languaje':_languaje  
    });
    return _procesarRespuesta(url);
  }
}