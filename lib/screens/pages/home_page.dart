import 'dart:math';

import 'package:db_miner/helper/api_helper.dart';
import 'package:db_miner/helper/db_helper.dart';
import 'package:db_miner/model/api_quote_model.dart';
import 'package:db_miner/screens/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:db_miner/helper/json_helper.dart';
import '../../model/json_quote_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JsonCategoriesName> allJSONCategoryNames = [];
  List<JsonQuoteModel> allJSONQuotes = [];

  ApiQuoteModel? randomQuote;

  List<ApiQuoteModel> apiData = [];

  @override
  void initState() {
    super.initState();
    getJSONCategoriesAndQuotes();
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

  getJSONCategoriesAndQuotes() async {
    allJSONCategoryNames = await JsonHelper.jsonHelper.fetchCategories();
    allJSONQuotes = await JsonHelper.jsonHelper.fetchJSONData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: Column(
          children: [
            const DrawerHeader(
              padding: EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                margin: EdgeInsets.all(0),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.supervised_user_circle_outlined),
                ),
                accountName: Text("Prince Patel"),
                accountEmail: Text("princeghadiya699@gmail.com"),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Change Theme",
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: height * 0.01),
            RadioListTile(
              title: const Text("Light theme"),
              value: "theme",
              groupValue: "Light",
              onChanged: (value) {},
            ),
            RadioListTile(
              title: const Text("Dark theme"),
              value: "theme",
              groupValue: "Dark",
              onChanged: (value) {},
            ),
            RadioListTile(
              title: const Text("System theme"),
              value: "system",
              groupValue: "Dark",
              onChanged: (value) {},
            ),
            const Divider(),
            Text(
              "Settings",
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text("DB Minor"),
        backgroundColor: Colors.teal,
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
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: width / 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
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
                              //
                              //
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: width * 0.02),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.teal[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                allJSONCategoryNames[index].categoryName,
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
                      allJSONQuotes.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: height / 6,
                          width: width / 2,
                          padding: EdgeInsets.all(width * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.primaries[Random().nextInt(15)][100]!,
                                Colors.primaries[Random().nextInt(15)][100]!,
                                Colors.primaries[Random().nextInt(15)][100]!,
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                '"${allJSONQuotes[index].quote}"',
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                '~ "${allJSONQuotes[index].author}"',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Random Quote",
                style: TextStyle(
                  fontSize: width / 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [
                    Colors.primaries[Random().nextInt(15)][100]!,
                    Colors.primaries[Random().nextInt(15)][100]!,
                    Colors.primaries[Random().nextInt(15)][100]!,
                  ]),
                  color: Colors.green,
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
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '- ${randomQuote!.author}',
                              style: const TextStyle(
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
                  color: Colors.teal[800],
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
                            gradient: LinearGradient(colors: [
                              Colors.primaries[Random().nextInt(15)][100]!,
                              Colors.primaries[Random().nextInt(15)][100]!,
                              Colors.primaries[Random().nextInt(15)][100]!,
                            ]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                apiData[index].quote,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '- ${apiData[index].author}',
                                  style: const TextStyle(
                                    fontSize: 16,
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
