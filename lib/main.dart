import 'package:coin_tracker/Classes/coin.dart';
import 'package:flutter/material.dart';

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
      home: new CoinList(title: 'CoinTracker'),
    );
  }
}

class CoinList extends StatefulWidget {
  CoinList({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CoinListState createState() => new _CoinListState();
}

class _CoinListState extends State<CoinList> {
  // Create a list of Coins, similar to Python, just with types!
  List<Coin> coins = [];
  // set our initial state
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      
      // Dummy data for the moment
      coins.add(new Coin(id: "1", name: "Bitcoin", symbol:"BTC", price: 0.001));
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
      body: Center(
        // ListView
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => _buildTile(context, index),
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
      leading: _leadingWidget(coins[index].symbol[0]),
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
}