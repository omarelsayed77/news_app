import 'package:api_lec2/providers/news%20providder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> categories = ["general", "health", "sport", "science"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<NewsProvider>()
                              .changeCategory(categories[index]);
                        },
                        child: Consumer<NewsProvider>(
                          builder: (context, value, child) => Chip(
                            backgroundColor:
                                (value.selectedCategory == categories[index])
                                    ? Colors.greenAccent
                                    : Colors.grey,
                            label: Text(categories[index]),
                          ),
                        ),
                      ),
                    )),
          ),
          Consumer<NewsProvider>(
            builder: (context, value, child) => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .8,
              child: ListView(
                children: [
                  for (int i = 0; i < value.articles.length; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Card(
                        elevation: 6,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: (value.articles[i].urlToImage == null)
                                  ? Image(
                                      image: AssetImage(
                                          'assets/news-default.jpeg'),
                                    )
                                  : Image.network(
                                      value.articles[i].urlToImage!),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((value.articles[i].title!.length > 40)
                                    ? "${value.articles[i].title!.substring(0, 40)}..."
                                    : value.articles[i].title!),
                                Text("${value.articles[i].publishedAt!}")
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
