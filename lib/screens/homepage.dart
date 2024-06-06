import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/tab_news.dart';
import 'package:url_launcher/url_launcher.dart';

import '../news_data.dart' as nd;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<nd.NewsData> data;
  late User loggedinUser;
  final _auth = FirebaseAuth.instance;

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    data = nd.getNewsArticles('/top-headlines?category=general');
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Material(
          color: Colors.black,
          child: ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () {
                  _auth.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                title: Text(
                  'Logout',
                  style:
                      GoogleFonts.robotoSlab(fontSize: 15, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          FutureBuilder<nd.NewsData>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () =>
                      _launchURL(snapshot.data!.newsArticles[0]["url"]),
                  child: Container(
                    decoration: BoxDecoration(
                      image: snapshot.data!.newsArticles[0]["urlToImage"] !=
                              null
                          ? DecorationImage(
                              image: NetworkImage(
                                '${snapshot.data!.newsArticles[0]["urlToImage"]}',
                              ),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: AssetImage(
                                  'assets/images/splash_screen_image_2.png'),
                              fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Breaking News',
                  style: GoogleFonts.robotoSlab(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabNews(
              category: 'general',
            ),
          ),
        ],
      ),
    );
  }
}
