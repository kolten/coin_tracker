import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:coin_tracker/Classes/coin.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CoinTracker',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new CoinList(
          title: 'CoinTracker', 
          channel: new IOWebSocketChannel.connect("wss://ws-feed.gdax.com"),
      ),
    );
  }
}

class CoinList extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  CoinList({Key key, @required this.title, @required this.channel})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _CoinListState createState() => new _CoinListState();
}

class _CoinListState extends State<CoinList> {
  // Create a Set of Coins, this will help eliminate duplicates
  List<Coin> coins;
  // We'll copy everything from the set to the dynamic list
  //List<Coin> fromCoins;

  Map coinMap;

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      widget.channel.sink.add(
        JSON.encode({
        "type": "subscribe",
        "channels": [
          {
            "name": "ticker",
            "product_ids": [
              "ETH-USD",
              "BCH-USD",
              "BTC-USD",
              "LTC-USD",
            ]
          }
        ]
        }));
    }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
              final Map map = snapshot.hasData ? json.decode(snapshot.data) : {};
               return new Container(
                 //width: 0.0,
                 //height: 0.0,
                 child: new Column(
                   children: <Widget>[
                     map.isNotEmpty ?
                     new ListTile(
                       leading: _leadingWidget(map['product_id']),
                       title: new Text(map['product_id']),
                       subtitle: new Text(map['price']),
                       isThreeLine: true,
                     ) : new Text("")
                   ]),
               );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, int index){
    // Check if the index is large than or equal to the list size
    if(index >= coins.length){
      return null;
    }

    return new ListTile(
      // leading: _leadingWidget(fromCoins[index].symbol),
      title: new Text(coins[index].name),
      subtitle: new Text(coins[index].price.toString()),
      isThreeLine: true,
    );
  }

  _leadingWidget(String symbol){
    return new CircleAvatar(
      backgroundColor: Colors.blue,
      child: new Text(symbol[0]),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}