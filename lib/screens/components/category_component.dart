import 'dart:math';

import 'package:flutter/material.dart';
import '../../helper/json_helper.dart';
import '../../model/json_quote_model.dart';

class CategoryComponent extends StatefulWidget {
  const CategoryComponent({super.key});

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  List<JsonCategoryModel> allJSONCategoryNames = [];
  List<JsonQuoteModel> allJSONQuotes = [];
  String? selectedCategory;
  List<JsonQuoteModel> filteredQuotes = [];

  getJSONCategoriesAndQuotes() async {
    allJSONCategoryNames = await JsonHelper.jsonHelper.fetchCategories();
    allJSONQuotes = await JsonHelper.jsonHelper.fetchJSONData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getJSONCategoriesAndQuotes();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: width / 18,
            fontWeight: FontWeight.bold,
            // color: const Color(0xffa379c9),
            // color: const Color(0xff7353ba),
            color: const Color(0xff2e5eaa),
            // color: const Color(0xff646e78),
          ),
        ),
        SizedBox(height: height * 0.011),
        SizedBox(
          height: height / 20,
          child: allJSONCategoryNames.isEmpty
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allJSONCategoryNames.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedCategory = allJSONCategoryNames[index].name;
                        if (selectedCategory == "Sad") {
                          filteredQuotes.clear();
                          for (int i = 0; i < 7; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        } else if (selectedCategory == "Happy") {
                          filteredQuotes.clear();
                          for (int i = 7; i < 14; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        } else if (selectedCategory == "Love") {
                          filteredQuotes.clear();
                          for (int i = 14; i < 21; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        } else if (selectedCategory == "Motivation") {
                          filteredQuotes.clear();
                          for (int i = 21; i < 28; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        } else if (selectedCategory == "Morning") {
                          filteredQuotes.clear();
                          for (int i = 28; i < 35; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        } else if (selectedCategory == "Wisdom") {
                          filteredQuotes.clear();
                          for (int i = 35; i < 48; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        } else if (selectedCategory == "Inspirational") {
                          filteredQuotes.clear();
                          for (int i = 48; i < 50; i++) {
                            filteredQuotes.add(allJSONQuotes[i]);
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: width * 0.02),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (allJSONCategoryNames[index].name.toString() ==
                                  selectedCategory)
                              ? const Color(0xff7371fc)
                              : const Color(0xffa594f9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          allJSONCategoryNames[index].name,
                          style: TextStyle(
                            fontSize: width / 24,
                            color: Colors.teal[900],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        SizedBox(height: height * 0.01),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                selectedCategory != null
                    ? filteredQuotes.length
                    : allJSONQuotes.length,
                (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: height / 6,
                    width: width / 2,
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffa594f9),
                      gradient: LinearGradient(
                        begin: Alignment(
                          Random().nextDouble(),
                          Random().nextDouble(),
                        ),
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xffa594f9),
                          const Color(0xff7371fc).withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          '"${selectedCategory != null ? filteredQuotes[index].quote : allJSONQuotes[index].quote}"',
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          '~ "${selectedCategory != null ? filteredQuotes[index].author : allJSONQuotes[index].author}"',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
