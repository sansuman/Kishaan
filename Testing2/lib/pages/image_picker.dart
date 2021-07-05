
import 'dart:io';
import 'package:Testing2/pages/disease_identification_page.dart';
import 'package:flutter/material.dart';
import 'package:Testing2/data/model.dart';


class Test extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<Test> {
  File fileMedia;
  MediaSource source;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Test"),
    ),
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
            child: fileMedia == null
            ? Icon(Icons.photo, size: 120)
              :  Image.file(fileMedia)
            ),

            const SizedBox(height: 24),
            RaisedButton(
              child: Text('Capture Image'),
              shape: StadiumBorder(),
              onPressed: () => capture(MediaSource.image),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            const SizedBox(height: 12),
            RaisedButton(
              child: Text('Capture Video'),
              shape: StadiumBorder(),
              onPressed: () => capture(MediaSource.video),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}
