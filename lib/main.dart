import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '台北市立動物園'),
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
  List<String> items;

  @override
  Widget build(BuildContext context) {
    items = new List<String>.generate(10, (i) => "Item $i");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.dehaze),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {},
          )
        ],
      ),
      body: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return new Row(
            children: <Widget>[
              Expanded(
                  //child: new Image.asset("images/car.jpg"),
                  child: new Image(
                image: new NetworkImage(
                    "https://flutter.io/images/homepage/screenshot-2.png"),
              )),
              Expanded(
                child: new Column(
                  children: <Widget>[
                    new Text("什麼館"+items[index], style: TextStyle(fontSize: 24),),
                    new SizedBox(height: 8,),
                    new Text("詳細內容"+items[index]),
                    new SizedBox(height: 8,),
                    new Text("休館日"+items[index]),
                    new SizedBox(height: 8,),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
