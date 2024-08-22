import 'dart:typed_data';

import 'package:db_miner/helper/db_helper.dart';
import 'package:db_miner/model/api_quote_model.dart';
import 'package:flutter/material.dart';

class LikeProvider extends ChangeNotifier {
  bool isLiked = false;
  List<ApiQuoteModel> likedList = [];

  void like({required ApiQuoteModel model, Uint8List? image}) {
    DbHelper.dbHelper.addDb(
      model.quote,
      model.author,
    );
    notifyListeners();
  }

  void disLike({required ApiQuoteModel model}) {
    DbHelper.dbHelper.removeDB(model.id);
    notifyListeners();
  }
}
