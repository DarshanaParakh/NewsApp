import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsData {
  final dynamic newsArticles;
  final dynamic noOfArticles;

  NewsData({this.newsArticles, this.noOfArticles});

  factory NewsData.fromJson(Map<dynamic, dynamic> json) {
    return NewsData(
      newsArticles: json['articles'],
      noOfArticles: json['totalResults'],
    );
  }
}

Future<NewsData> getNewsArticles(String filter) async {
  String urlDomain = 'https://newsapi.org';
  String urlVersion = '/v2';
  String apiKey = '49afcb3e05554f62842b1dfd630ce594';
  String country = '', language = '';
  if (filter[1] == 't') {
    country = '&country=in';
  } else {
    language = '&language=en';
  }

  String url = urlDomain + urlVersion + filter + country + language + '&apiKey=' + apiKey;

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return NewsData.fromJson(json.decode(response.body));
  } else {
    print(response.statusCode);
    throw ('exception');
  }
}
