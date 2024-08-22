class JsonQuoteModel {
  int id;
  String quote;
  String author;

  JsonQuoteModel({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory JsonQuoteModel.fromMap({required Map<String, dynamic> data}) {
    return JsonQuoteModel(
      id: data['id'],
      quote: data['quote'],
      author: data['author'],
    );
  }
}

class JsonCategoriesName {
  String categoryName;

  JsonCategoriesName({required this.categoryName});

  factory JsonCategoriesName.fromMap({required Map<String, dynamic> data}) {
    return JsonCategoriesName(
      categoryName: data['name'],
    );
  }
}
