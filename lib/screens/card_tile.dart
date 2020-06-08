import 'package:flutter/material.dart';
import 'package:newsapp/screens/newsPage.dart';

class CardTile extends StatefulWidget {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlImage;
  final String date;
  final String time;
  final String source;
  final int index;

  CardTile(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlImage,
      this.date,
      this.time,
      this.source,
      this.index});

  @override
  _CardTileState createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsPage(
                    title: this.widget.title,
                    url: this.widget.url,
                    urlImage: this.widget.urlImage,
                    source: this.widget.source,
                    index: this.widget.index),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        child: (this.widget.urlImage != '')
                            ? Hero(
                                tag: 'photo${this.widget.index}',
                                child: Image.network(
                                  this.widget.urlImage,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    'Image Not Available',
                                    style: TextStyle(
                                        color: (themeData.brightness ==
                                                Brightness.light)
                                            ? Colors.black26
                                            : Colors.white.withOpacity(0.3),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      width: width / 2,
                      child: Text(
                        this.widget.author,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Chip(
                        backgroundColor:
                            (themeData.brightness == Brightness.light)
                                ? Colors.white
                                : Colors.grey[700],
                        avatar: Icon(
                          Icons.calendar_today,
                          color: (themeData.brightness == Brightness.light)
                              ? Colors.black38
                              : Colors.white.withOpacity(0.5),
                          size: 15,
                        ),
                        label: Text(this.widget.date),
                        labelStyle: TextStyle(
                            color: (themeData.brightness == Brightness.light)
                                ? Colors.black38
                                : Colors.white.withOpacity(0.5),
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.widget.title,
                      style: TextStyle(fontSize: 16.0, height: 1.5),
                    ),
                    Text(
                      this.widget.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: (themeData.brightness == Brightness.light)
                              ? Colors.black38
                              : Colors.white.withOpacity(0.3),
                          height: 1.9),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          this.widget.source,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          this.widget.time,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: (themeData.brightness == Brightness.light)
                                  ? Colors.black38
                                  : Colors.white.withOpacity(0.3)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
