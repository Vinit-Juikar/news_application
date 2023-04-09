// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/api_data_for_searching.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  List<String> suggestions = List.generate(
      articles.length, (index) => articles[index]['source']['name']);
  List<String> filteredSuggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 40, 39, 39),
              border: Border(
                bottom: BorderSide(width: 0.3, color: Colors.white),
              ),
            ),
            height: kToolbarHeight,
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 30.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.2),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: (query) {
                          setState(() {
                            filteredSuggestions = suggestions
                                .where((suggestion) => suggestion
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSuggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(16.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        filteredSuggestions[index],
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Do something when a suggestion is tapped
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
