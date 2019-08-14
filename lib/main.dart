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
  @override
  Widget build(BuildContext context) {
    return new StoreListPage(widget: widget);
  }
}

class StoreListPage extends StatefulWidget {
  const StoreListPage({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MyHomePage widget;

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  ZooData zooData;

  @override
  void initState() {
    super.initState();
    _getDataFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widget.title),
        leading: Icon(Icons.dehaze),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {},
          )
        ],
      ),
      body: _getListView(),
    );
  }

  ListView _getListView() {
    print('_getListView');

    if (zooData == null) {
      print('_getListView zooDat == null');

      return null;
    }

    return ListView.separated(
      itemCount: zooData.result.results.length,
      itemBuilder: _getListItem,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Color(0xFFAACCAA),
          height: 2,
        );
      },
    );
  }

  Widget _getListItem(context, index) {
    Results item = zooData.result.results[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: <Widget>[
          //Image.asset("images/ic_placeholder.png"),
          Image.network(item.ePicURL,
              width: 100, height: 100, fit: BoxFit.fitHeight),

          SizedBox(
            width: 8,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.eName,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  item.eInfo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  item.eMemo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getDataFromWeb() async {
    var url =
        'https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    // 中文 Utf8 處理.
    Utf8Decoder decoder = Utf8Decoder();
    String result = decoder.convert(response.bodyBytes);
    print('Response body: ${result}');

    //zooData = ZooData.fromJson(json.decode(result));
    print('before setState');
    setState(() {
      zooData = ZooData.fromJson(json.decode(result));

      print('in setState');
    });
  }
}
