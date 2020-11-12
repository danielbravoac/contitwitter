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
      title: 'Flutter Demo', //Nombre de la app
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mi aplicación conti'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(color: Colors.red, child: Text("hola")),
        actions: [Text("adasdsadrf")],
        backgroundColor: Colors.green,
        elevation: 7,
        
      ),
      body: Container(
        color: Colors.deepPurple,
        width: double.infinity,
        child:Column(
          children: [
            Text("estamo activo papi", style: TextStyle(color: Color(0xFFEF5350)),

            
            ),
            Text("Hola crack"),
            Row(children: [
              Column(
                children:[
                  Icon(Icons.card_giftcard),
                  Text("hola")
                ],
              ),
              Icon(Icons.verified_user),
              Icon(Icons.car_repair),
              Text("asasdasd"),
              Container(color:Colors.blue,
              child:Image.network("https://images.unsplash.com/photo-1600087626014-e652e18bbff2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80"))
              
              ],)
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
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
