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
    items = List<String>.generate(10, (i) => "Item $i");

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
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: <Widget>[
                Image.asset("images/ic_placeholder.png"),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "什麼館" + items[index],
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("詳細內容" + items[index]),
                    SizedBox(
                      height: 8,
                    ),
                    Text("休館日" + items[index]),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.black,
            height: 2,
          );
        },
      ),
    );
  }
}
