import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/json_quote_model.dart';

class JsonHelper {
  JsonHelper._();

  static final JsonHelper jsonHelper = JsonHelper._();

  Future<List<JsonQuoteModel>> fetchJSONData() async {
    String rowData = await rootBundle.loadString("assets/json/data.json");
    List data = jsonDecode(rowData);

    List<JsonQuoteModel> mainData = [];

    data.map((category) {
      List<JsonQuoteModel> quotes = (category['quotes'] as List).map((quote) {
        return JsonQuoteModel.fromJson(quote);
      }).toList();
      mainData.addAll(quotes);
    }).toList();

    return mainData;
  }

  Future<List<JsonCategoryModel>> fetchCategories() async {
    String rowData = await rootBundle.loadString("assets/json/data.json");
    List data = jsonDecode(rowData);

    List<JsonCategoryModel> categoryNames =
        data.map((e) => JsonCategoryModel.fromJson(e)).toList();

    return categoryNames;
  }
}
