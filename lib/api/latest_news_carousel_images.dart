// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> getNewsApiImages() async {
  const apiKey = "fe428972014842deb21bdf7860fdeaeb";
  const urlForLatestNewsImages =
      "https://newsapi.org/v2/top-headlines?category=technology&apiKey=fe428972014842deb21bdf7860fdeaeb";

  final response = await http.get(Uri.parse(urlForLatestNewsImages));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final articles = jsonData['articles'];

    List<String> imageUrls = [];

    for (var article in articles) {
      final urlToImage = article["urlToImage"];

      if (urlToImage != null) {
        imageUrls.add(urlToImage);
      }
    }
    return imageUrls.isNotEmpty ? imageUrls : _generateRandomImageUrls();
  } else {
    return _generateRandomImageUrls();
  }
}

List<String> _generateRandomImageUrls() {
  return [
    "https://picsum.photos/id/239/200/300",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/238/200/300",
    "https://picsum.photos/id/240/200/300",
    "https://picsum.photos/id/241/200/300",
  ];
}


