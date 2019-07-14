class Peliculas{
  List<Pelicula> items=new List<Pelicula>();
  Peliculas();
  Peliculas.fromJsonList(List<dynamic> jsonList){
    if(jsonList==null) return;
    for(var item in jsonList){
      final pelicula=new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}
class Pelicula {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });
  Pelicula.fromJsonMap(Map<String,dynamic> json){
    this.voteCount         =json["vote_count"];
    this.id                =json["id"];
    this.video             =json["video"];
    this.voteAverage       =json["vote_average"] / 1;
    this.title             =json["title"];
    this.popularity        =json["popularity"] / 1;
    this.posterPath        =json["poster_path"];
    this.originalLanguage  =json["original_language"];
    this.originalTitle     =json["original_title"];
    this.genreIds          =json["genre_ids"].cast<int>();
    this.backdropPath      =json["backdrop_path"];
    this.adult             =json["adult"];
    this.overview          =json["overview"];
    this.releaseDate       =json["release_date"];
  }
  getPostImg(){
    if(posterPath==null){
      return "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/1024px-Imagen_no_disponible.svg.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }

  }
}

