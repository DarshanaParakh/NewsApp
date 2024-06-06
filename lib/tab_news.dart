import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/news_data.dart' as nd;
import 'package:url_launcher/url_launcher.dart';

class TabNews extends StatefulWidget {
  final String category;

  const TabNews({required this.category});
  @override
  _TabNewsState createState() => _TabNewsState();
}

class _TabNewsState extends State<TabNews> {
  late Future<nd.NewsData> data;

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  void initState() {
    super.initState();
    data = nd.getNewsArticles('/top-headlines?category=${widget.category}');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<nd.NewsData>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 3), () {
                  setState(() {
                    data = nd.getNewsArticles(
                        '/top-headlines?category=${widget.category}');
                  });
                });
              },
              child: ListView.builder(
                itemCount: snapshot.data!.noOfArticles > 10
                    ? 10
                    : snapshot.data!.noOfArticles,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        _launchURL(snapshot.data!.newsArticles[index]["url"]),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              snapshot.data!.newsArticles[index]
                                          ["urlToImage"] !=
                                      null
                                  ? CircleAvatar(
                                      maxRadius: 40,
                                      backgroundImage: NetworkImage(
                                        snapshot.data!.newsArticles[index]
                                            ["urlToImage"],
                                      ))
                                  : CircleAvatar(
                                      maxRadius: 40,
                                      backgroundImage: AssetImage(
                                          'assets/images/splash_screen_image_2.png'),
                                    ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width - 120,
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.newsArticles[index]
                                          ["title"],
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.robotoSlab(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot
                                                .data!
                                                .newsArticles[index]
                                                    ["publishedAt"]
                                                .substring(
                                                    snapshot
                                                            .data!
                                                            .newsArticles[index]
                                                                ["publishedAt"]
                                                            .indexOf('T') +
                                                        1,
                                                    snapshot
                                                            .data!
                                                            .newsArticles[index]
                                                                ["publishedAt"]
                                                            .indexOf('T') +
                                                        6),
                                            style: TextStyle(
                                                color: Colors.grey[700]),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot
                                                .data!
                                                .newsArticles[index]
                                                    ["publishedAt"]
                                                .substring(
                                                    0,
                                                    snapshot
                                                        .data!
                                                        .newsArticles[index]
                                                            ["publishedAt"]
                                                        .indexOf('T'))
                                                .split('-')
                                                .reversed
                                                .join('-'),
                                            style: TextStyle(
                                                color: Colors.grey[700]),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}
