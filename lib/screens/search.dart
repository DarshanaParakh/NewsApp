import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/searched_news.dart';
import 'package:newsapp/widgets/button.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();

  int check = 0;

  Widget displaySearchedResults = Center(
    child: Text(
      'Search something',
      style: GoogleFonts.robotoSlab(
        fontSize: 15,
        color: Colors.blueGrey[300],
      ),
    ),
  );

  _updateDisplay(String _query) {
    return Expanded(child: SearchedNews(query: _query));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Get curated search results from various news topics all over the world',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 15,
                      color: Colors.blueGrey[300],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                maxLines: null,
                controller: controller,
                style: GoogleFonts.robotoSlab(),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(15.0), child: Icon(Icons.search)),
                  labelText: 'Search',
                  labelStyle: GoogleFonts.robotoSlab(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  text: 'Search',
                  padding: const EdgeInsets.only(right: 10),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    displaySearchedResults = _updateDisplay(controller.text);
                  },
                )
              ],
            ),
            displaySearchedResults
          ],
        ),
      ),
    );
  }
}
