// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> getLocalNews() async {
  const urlForBuisnessNews =
"https://newsapi.org/v2/top-headlines?country=us&apiKey=fe428972014842deb21bdf7860fdeaeb";
  final response = await http.get(Uri.parse(urlForBuisnessNews));
  if (response.statusCode == 200) {
    final jsonDataForBusinessNews = jsonDecode(response.body);
    final articlesForBusinessNews = jsonDataForBusinessNews['articles'];

    if (articlesForBusinessNews.isEmpty) {
      // If there are no articles, return locally stored data
      return getLocallyStoredDataLocalNews();
    } else {
      List<Map<String, String>> articleListLocalNews = [];

      for (var article in articlesForBusinessNews) {
        final imageUrl = article["urlToImage"];
        final name = article["source"]["name"];
        final description = article["title"];

        Map<String, String> articleMap = {
          "name": name ?? "Major Theft in Mumbai",
          "description": description ?? "Loss of crores of wealth from jwellery shop, questions of security rise",
          "imageUrl": imageUrl ?? "https://picsum.photos/id/237/200/300"
        };

        articleListLocalNews.add(articleMap);
      }

      return articleListLocalNews;
    }
  }
  
  // If there's an error, return locally stored data
  return getLocallyStoredDataLocalNews();
}

List<Map<String, String>> getLocallyStoredDataLocalNews() {
  // Return some locally stored data as a list of maps
  return [
    {
      "name": "Top News 1",
      "description": "This is a locally stored news article.",
      "imageUrl": "https://example.com/image1.jpg"
    },
    {
      "name": "Top News 2",
      "description": "This is another locally stored news article.",
      "imageUrl": "https://example.com/image2.jpg"
    }
  ];
}
