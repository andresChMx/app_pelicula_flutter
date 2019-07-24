
import 'dart:async';

import 'package:app_pelicula_seccion7/src/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_pelicula_seccion7/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey="edd945b7ba2974a33ebbb8ee0bce990f";
  String _url="api.themoviedb.org";
  String _language="es-ES";

  int _popularesPage=0;

  List<Pelicula> _populares=new List();

  bool _cargando=false;

  final StreamController _popularesStreamController=StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get  popularesSink=>_popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream=> _popularesStreamController.stream; 

  void disposeStreams(){
    _popularesStreamController?.close();
  }
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp=await http.get(url);
    Map<String,dynamic> decodedData=json.decode(resp.body);
    Peliculas peliculas=new Peliculas.fromJsonList(decodedData["results"]);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async{
    final url=Uri.https(_url,"3/movie/now_playing",{
      'api_key' :_apikey,
      'languaje':_language  
    });
    return _procesarRespuesta(url);

  }
  Future<List<Pelicula>> getPopulares() async{
    if(_cargando){return [];}
    print("cargando");
    _cargando=true;
    this._popularesPage++;
    final url=Uri.https(_url,"3/movie/popular",{
      'api_key' :_apikey,
      'languaje':_language,
      'page':this._popularesPage.toString()  
    });
    final resp=await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando=false;
    return resp;
  }
  Future<List<Actor>> getCast(String peliId) async{
    final url=Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key':_apikey,
      'language':_language
    });
    final resp= await http.get(url);
    final decodedData=json.decode(resp.body);
    final cast=new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }
  Future<List<Pelicula>> buscarPelicula(String query) async{
    final url=Uri.https(_url,'3/search/movie',{
      'api_key':_apikey,
      'language':_language,
      'query':query
    });
    return await _procesarRespuesta(url);
  }
}