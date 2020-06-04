import 'package:flutter/material.dart';
import 'package:newsapp/screens/newsPage.dart';

class CardTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                    title: this.title,
                    url: this.url,
                    urlImage: this.urlImage,
                    source: this.source,
                    index: this.index),
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
                        child: (this.urlImage != '')
                            ? Hero(
                                tag: 'photo${this.index}',
                                child: Image.network(
                                  this.urlImage,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    'Image Not Available',
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 20),
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
                        this.author,
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
                        backgroundColor: Colors.white,
                        avatar: Icon(
                          Icons.calendar_today,
                          color: Colors.black38,
                          size: 15,
                        ),
                        label: Text(this.date),
                        labelStyle:
                            TextStyle(color: Colors.black38, fontSize: 12),
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
                      this.title,
                      style: TextStyle(fontSize: 16.0, height: 1.5),
                    ),
                    Text(
                      this.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black38, height: 1.9),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          this.source,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          this.time,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black38),
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
