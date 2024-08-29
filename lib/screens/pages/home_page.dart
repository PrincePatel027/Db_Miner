import 'dart:math';

import 'package:db_miner/helper/api_helper.dart';
import 'package:db_miner/helper/db_helper.dart';
import 'package:db_miner/model/api_quote_model.dart';
import 'package:db_miner/screens/components/left_drawer.dart';
import 'package:db_miner/screens/pages/detail_page.dart';
import 'package:flutter/material.dart';
import '../components/category_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiQuoteModel? randomQuote;

  List<ApiQuoteModel> apiData = [];

  @override
  void initState() {
    super.initState();
    callRandomQuote();
    fetchAPIQuotes();
    DbHelper.dbHelper.initDB();
  }

  callRandomQuote() async {
    randomQuote = await ApiHelper.apiHelper.fetchRandomQuote();
    setState(() {});
  }

  fetchAPIQuotes() async {
    apiData = await ApiHelper.apiHelper.fetchAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffcdc1ff),
      drawer: const LeftDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xff2e5eaa),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        centerTitle: false,
        title: const Text(
          "DB Minor",
          style: TextStyle(
            color: Color(0xff2e5eaa),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffcdc1ff),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "liked");
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red[300],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              const CategoryComponent(),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Random Quote",
                    style: TextStyle(
                      fontSize: width / 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff2e5eaa),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.02),
                    child: MaterialButton(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color(0xffa594f9),
                      onPressed: () async {
                        // My code
                        // randomQuote = await ApiHelper.apiHelper.fetchRandomQuote();
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: const Color(0xFF7F6AE5),
                        //       content: const Text(
                        //         "Random Quote generated succesfully...",
                        //       ),
                        //       action: SnackBarAction(
                        //         label: "Ok",
                        //         onPressed: () {},
                        //       ),
                        //     ),
                        //   );
                        ///
                        // AI Code
                        await ApiHelper.apiHelper
                            .fetchRandomQuote()
                            .then((quote) {
                          randomQuote = quote;
                        }).whenComplete(() {
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xFF7F6AE5),
                              content: const Text(
                                "Random Quote generated succesfully...",
                              ),
                              action: SnackBarAction(
                                label: "Ok",
                                onPressed: () {},
                              ),
                            ),
                          );
                        });
                      },
                      child: const Text("Generate one more"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                  color: const Color(0xffa594f9),
                  // color: Colors.teal[200],
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: width * 0.02),
                padding: EdgeInsets.all(width * 0.03),
                child: (randomQuote == null)
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            randomQuote!.quote,
                            style: TextStyle(
                              // fontStyle: FontStyle.italic,
                              fontSize: width * 0.042,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '- ${randomQuote!.author}',
                              style: TextStyle(
                                fontSize: width * 0.036,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "More Quotes",
                style: TextStyle(
                  fontSize: width / 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff2e5eaa),
                ),
              ),
              SizedBox(height: height * 0.011),
              ...List.generate(
                apiData.length,
                (index) => (apiData.isEmpty)
                    ? const Center(
                        child: Text("Loading..."),
                      )
                    : GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(
                                  apiQuotes: apiData,
                                  initialIndex: index,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: width * .02, bottom: height * .01),
                          decoration: BoxDecoration(
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
                            color: const Color(0xffa594f9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiData[index].quote,
                                style: TextStyle(
                                  fontSize: width * 0.042,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '- ${apiData[index].author}',
                                  style: TextStyle(
                                    fontSize: width * 0.036,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
