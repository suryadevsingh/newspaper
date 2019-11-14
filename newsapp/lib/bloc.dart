import 'dart:async';
import 'package:newsapp/apiresponse.dart';
import 'package:newsapp/jsonclass.dart';
import 'package:newsapp/respository.dart';

class   Articlesbloc {

  MovieRepository repository  = MovieRepository();

  StreamController<ApiResponse<NewsResponse>>  _articlesStreamController = StreamController<ApiResponse<NewsResponse>>();

  Stream<ApiResponse<NewsResponse>> get streamData => _articlesStreamController.stream;

//  StreamSink<List<NewsResponse>> get ArticleseData => _ArticlesStreamController.sink;




  fetchArticlesbloc()async{
    _articlesStreamController.sink.add(ApiResponse.loading("fetching latest news"));
    try{
      var news =await repository.fetchArticles();
      _articlesStreamController.sink.add(ApiResponse.completed(news));
    }catch (e){
      _articlesStreamController.sink.add(ApiResponse.error((e.toString())));
    }
  }


}
