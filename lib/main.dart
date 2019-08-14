import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taipei_zoo_flutter/zoo_data.dart';

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

    _fetch();

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

  _fetch() async {
    var url = 'https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    // 中文 Utf8 處理.
    Utf8Decoder decoder = Utf8Decoder();
    String result = decoder.convert(response.bodyBytes);
    print('Response body: ${result}');

    ZooData zooData = ZooData.fromJson(json.decode(result));
    print('zooData: ${zooData.result.limit}');

  }
}
