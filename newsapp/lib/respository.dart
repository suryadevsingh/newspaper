import 'package:newsapp/basehelperclass.dart';
import 'package:newsapp/jsonclass.dart';

class MovieRepository {
  final String _apikey = "4d561835cb754e9989cec5c287c17964";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<NewsResponse> fetchArticles() async {
    final response = await ApiBaseHelper().get(_apikey);
    return NewsResponse.fromJson(response);
  }
}
