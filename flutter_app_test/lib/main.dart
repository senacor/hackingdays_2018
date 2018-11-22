import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.deepPurple,
        backgroundColor: Colors.pinkAccent,
        secondaryHeaderColor: Colors.green
      ),
      home: RandomWords(
          title: 'Reload ' + Random.secure().nextInt(1000).toString()),
    );
  }
}

class RandomWords extends StatefulWidget {
  final String title;

  const RandomWords({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.menu), onPressed: _pushSaved)
        ],
      ),
      body: Center(
        child: DisplayList(
          displayed: _suggestions,
          saved: _saved,
          generate: true,
        ),
      ),
    );
  }

  _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: DisplayList(
          displayed: _saved,
          saved: _saved,
          generate: false,
        ),
      );
    }));
  }
}

class DisplayList extends StatefulWidget {
  final List<WordPair> displayed;
  final List<WordPair> saved;
  final bool generate;

  const DisplayList({Key key, this.displayed, this.saved, this.generate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DisplayListState();
  }
}

class DisplayListState extends State<DisplayList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          var index = i ~/ 2;

          if (index >= widget.displayed.length) {
            if (widget.generate) {
              widget.displayed.addAll(generateWordPairs().take(10));
            } else {
              return null;
            }
          }

          var content = widget.displayed[index];

          return buildRow(content, widget.saved.contains(content));
        });
  }

  Widget buildRow(WordPair content, bool favorite) {
    return ListTile(
      title:
          Text(content.first + "_" + content.second),
      trailing: Icon(
        favorite ? Icons.favorite : Icons.favorite_border,
        color: favorite ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (favorite) {
            widget.saved.remove(content);
          } else {
            widget.saved.add(content);
          }
        });
      },
    );
  }
}
