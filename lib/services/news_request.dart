import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/model/newsModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsRequest {
  int noOfPosts = 20;
  static String query = '';
  Future getLatestNews() async {
    List<NewsModel> newsList = List<NewsModel>();
    String url;
    await DotEnv().load('assets/api.env');
    String apiKey = DotEnv().env['NEWS_API'];
    if (query == '') {
      url = 'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey';
    } else {
      url = 'https://newsapi.org/v2/top-headlines?q=$query&apiKey=$apiKey';
    }
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map values = jsonDecode(response.body);
      if (values["totalResults"] <= 20)
        noOfPosts = values["totalResults"];
      else
        noOfPosts = 20;
      for (int i = 0; i < noOfPosts; i++) {
        String published = values["articles"][i]["publishedAt"];
        var result = published.split('T');
        String date = result[0];
        String time = result[1].split('Z')[0];
        NewsModel news = NewsModel(
            author: (values["articles"][i]["author"] != null)
                ? values["articles"][i]["author"]
                : '',
            title: (values["articles"][i]["title"] != null)
                ? values["articles"][i]["title"]
                : '',
            description: (values["articles"][i]["description"] != null)
                ? values["articles"][i]["description"]
                : '',
            url: (values["articles"][i]["url"] != null)
                ? values["articles"][i]["url"]
                : '',
            urlImage: (values["articles"][i]["urlToImage"] != null)
                ? values["articles"][i]["urlToImage"]
                : '',
            date: date,
            time: time,
            source: (values["articles"][i]["source"]["name"] != null)
                ? values["articles"][i]["source"]["name"]
                : '');
        newsList.add(news);
      }
      return newsList;
    }
  }
}
