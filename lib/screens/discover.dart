import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/tab_news.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<String> _categories = [
    "General",
    "Business",
    "Entertainment",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  List<Widget> _createTabs() {
    List<Widget> res = [];
    for (var i = 0; i < _categories.length; i++) {
      res.add(Tab(
        text: _categories[i],
      ));
    }
    return res;
  }

  _createNewsTabs() {
    List<Widget> res = [];
    for (var i = 0; i < _categories.length; i++) {
      final String str = _categories[i].toLowerCase();
      res.add(TabNews(category: str));
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'News from all over the world',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 15,
                    color: Colors.blueGrey[300],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: AppBar(
                backgroundColor: Colors.black,
                bottom: TabBar(
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.white,
                  isScrollable: true,
                  tabs: _createTabs(),
                  labelStyle: GoogleFonts.robotoSlab(),
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: _createNewsTabs()),
          ),
        ],
      ),
    );
  }
}
