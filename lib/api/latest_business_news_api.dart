import 'dart:convert';
import 'package:http/http.dart' as http;

//here we have to define the future function to get the data

Future<List<String>> getBusinessNews() async {
  const apiKey = "fe428972014842deb21bdf7860fdeaeb";
  const urlForBuisnessNews =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fe428972014842deb21bdf7860fdeaeb";
  final response = await http.get(Uri.parse(urlForBuisnessNews));
  if (response.statusCode == 200) {
    final jsonDataForBusinessNews = jsonDecode(response.body);
    final articlesForBusinessNews = jsonDataForBusinessNews['articles'];

    List<String> nameUrlsForBusinessNews = [];
    List<String> descriptionForBusinessNews = [];
    List<String> imageUrlsForBusinessNews = [];

    for (var article in articlesForBusinessNews) {
      final imageUrlsForBusinessNewsRaw = article["urlToImage"];
      final nameUrlsForBusinessNewsRaw = article["name"];
      final descriptionForBusinessNewsRaw = article["title"];

      if (imageUrlsForBusinessNewsRaw != null) {
        nameUrlsForBusinessNews.add(imageUrlsForBusinessNewsRaw);
      }
      else {

      }
      if (nameUrlsForBusinessNewsRaw != null) {
        nameUrlsForBusinessNews.add(nameUrlsForBusinessNewsRaw);
      }else {
        
      }
      if (descriptionForBusinessNewsRaw != null) {
        descriptionForBusinessNews.add(descriptionForBusinessNewsRaw);
      }
    }
  }
}
