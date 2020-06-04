import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  final String title;
  final String url;
  final String urlImage;
  final String source;
  final int index;
  NewsPage({this.title, this.url, this.urlImage, this.source, this.index});

  List<String> choices = ['Open with Browser'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.source),
            Text(
              this.url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => share(context),
          ),
          PopupMenuButton<String>(
            onSelected: choiceOption,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        flexibleSpace: (this.urlImage != '')
            ? Opacity(
                opacity: 0.4,
                child: Hero(
                  tag: 'photo${this.index}',
                  child: Image.network(
                    this.urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                child: Center(
                  child: Text(
                    'Image Not Available',
                    style: TextStyle(color: Colors.black26, fontSize: 20),
                  ),
                ),
              ),
      ),
      body: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  void share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final String sharedText =
        '${this.title}\n\nRead more about this topic-\n${this.url}';
    Share.share(sharedText,
        subject: this.title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void choiceOption(String choice) {
    if (choice == 'Open with Browser') {
      _launchInBrowser();
    }
  }

  Future<void> _launchInBrowser() async {
    if (await canLaunch(this.url)) {
      await launch(this.url, forceWebView: false);
    } else {
      throw 'Could not launch ${this.url}';
    }
  }
}
