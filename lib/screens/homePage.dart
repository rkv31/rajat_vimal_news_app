import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/card_tile.dart';
import 'package:newsapp/model/newsModel.dart';
import 'package:newsapp/services/news_request.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon customIcon = Icon(Icons.search);
  Widget customTitleWidget = Text('News App');
  NewsRequest _request = NewsRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customTitleWidget,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = Icon(Icons.cancel);
                  customTitleWidget = TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        )),
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    onSubmitted: (value) {
                      if (value == '') {
                        print('Search text not provided');
                      } else {
                        NewsRequest.query = value;
                        setState(() {});
                      }
                    },
                  );
                } else {
                  customIcon = Icon(Icons.search);
                  customTitleWidget = Text('News App');
                  NewsRequest.query = '';
                  setState(() {});
                }
              });
            },
            icon: customIcon,
          ),
        ],
      ),
      body: projectWidget(),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, newsSnap) {
        if (newsSnap.connectionState == ConnectionState.none ||
            newsSnap.hasData == false)
          return Container(
            child: Center(
              child: Text(
                'News Not Available',
                style: TextStyle(color: Colors.black26, fontSize: 20),
              ),
            ),
          );
        return ListView.builder(
          itemCount: newsSnap.data.length,
          itemBuilder: (context, index) {
            NewsModel news = newsSnap.data[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Widget to display the list of project
                (index == 0)
                    ? Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 10.0),
                        child: Text(
                          'Top Headlines',
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    : Container(),
                CardTile(
                  author: news.author,
                  title: news.title,
                  description: news.description,
                  url: news.url,
                  urlImage: news.urlImage,
                  date: news.date,
                  time: news.time,
                  source: news.source,
                  index: index,
                ),
              ],
            );
          },
        );
      },
      future: _request.getLatestNews(),
    );
  }
}
