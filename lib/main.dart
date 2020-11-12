import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: getTwittsResponse(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var list = getTwitts(snapshot.data);
                return ListView(
                  children: list
                      .map<Widget>((t) => Text("Twitt: ${t.content}"))
                      .toList(),
                );
              } else
                return Text("no twits");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Response> getTwittsResponse() async {
    String url =
        'http://django-env.eba-7mzjkynm.us-west-2.elasticbeanstalk.com/api/v1/twitts/';
    return await http.get(
      '$url',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
  }

  List<Twitt> getTwitts(Response response) {
    var json = convert.jsonDecode(response.body);
    List<Twitt> twitts = json.map<Twitt>(Twitt.fromJSON).toList();
    return twitts;
  }
}

class Twitt {
  String content;
  DateTime createAt;
  String authorRef;

  Twitt({this.content, this.createAt, this.authorRef});

  static Twitt fromJSON(dynamic json) {
    return new Twitt(
        content: json['content'],
        createAt: DateTime.parse(json['created_on']),
        authorRef: json['author']);
  }
}
