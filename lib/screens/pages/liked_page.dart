import 'package:db_miner/helper/db_helper.dart';
import 'package:db_miner/model/api_quote_model.dart';
import 'package:flutter/material.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Liked Quotes"),
      ),
      body: FutureBuilder(
        future: DbHelper.dbHelper.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List data = snapshot.data as List<ApiQuoteModel>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text(data[index].quote.toString()),
                  subtitle: Text("~ ${data[index].author.toString()}"),
                );
              },
            );
          }
          return const Center(
            child: Text("Loading..."),
          );
        },
      ),
    );
  }
}
