// class JsonQuoteModel {
//   int id;
//   String quote;
//   String author;

//   JsonQuoteModel({
//     required this.id,
//     required this.quote,
//     required this.author,
//   });

//   factory JsonQuoteModel.fromMap({required Map<String, dynamic> data}) {
//     return JsonQuoteModel(
//       id: data['id'],
//       quote: data['quote'],
//       author: data['author'],
//     );
//   }
// }

// class JsonCategoriesName {
//   String categoryName;

//   JsonCategoriesName({required this.categoryName});

//   factory JsonCategoriesName.fromMap({required Map<String, dynamic> data}) {
//     return JsonCategoriesName(
//       categoryName: data['name'],
//     );
//   }
// }
class JsonQuoteModel {
  String quote;
  String author;
  List<JsonCategoryModel> categories;

  JsonQuoteModel({
    required this.quote,
    required this.author,
    required this.categories,
  });

  factory JsonQuoteModel.fromJson(Map<String, dynamic> json) {
    return JsonQuoteModel(
      quote: json['quote'],
      author: json['author'],
      categories: json['categories'] != null
          ? json['categories']
              .map((category) => JsonCategoryModel.fromJson(category))
              .toList()
          : [],
    );
  }
}

class JsonCategoryModel {
  String name;

  JsonCategoryModel({required this.name});

  factory JsonCategoryModel.fromJson(Map<String, dynamic> json) {
    return JsonCategoryModel(name: json['name']);
  }
}
