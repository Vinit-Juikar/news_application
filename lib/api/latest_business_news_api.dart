// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> getBusinessNews() async {
  const urlForBuisnessNews =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fe428972014842deb21bdf7860fdeaeb";
  final response = await http.get(Uri.parse(urlForBuisnessNews));
  if (response.statusCode == 200) {
    final jsonDataForBusinessNews = jsonDecode(response.body);
    final articlesForBusinessNews = jsonDataForBusinessNews['articles'];

    if (articlesForBusinessNews.isEmpty) {
      // If there are no articles, return locally stored data
      return getLocallyStoredData();
    } else {
      List<Map<String, String>> articleList = [];

      for (var article in articlesForBusinessNews) {
        final imageUrl = article["urlToImage"];
        final name = article["source"]["name"];
        final description = article["title"];

        Map<String, String> articleMap = {
          "name": name ?? "Tesla",
          "description": description ?? "There is a lot of Chaos due to stock fluctuation",
          "imageUrl": imageUrl ?? "https://picsum.photos/id/237/200/300"
        };

        articleList.add(articleMap);
      }

      return articleList;
    }
  }
  
  // If there's an error, return locally stored data
  return getLocallyStoredData();
}

List<Map<String, String>> getLocallyStoredData() {
  // Return some locally stored data as a list of maps
  return [
    {
      "name": "Local News 1",
      "description": "This is a locally stored news article.",
      "imageUrl": "https://example.com/image1.jpg"
    },
    {
      "name": "Local News 2",
      "description": "This is another locally stored news article.",
      "imageUrl": "https://example.com/image2.jpg"
    }
  ];
}
