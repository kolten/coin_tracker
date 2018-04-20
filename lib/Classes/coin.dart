class Coin {
  // final String id;
  final String name;
  // final String symbol;
  final String price;

  // Coin();
  // Coin({this.id, this.name, this.price, this.symbol});
  Coin({this.name, this.price});

  // Helper function
  // Structure from https://api.coinmarketcap.com/v1/ticker
  // Coin.fromJson(Map json)
  //   : id = json['id'],
  //     name = json['name'],
  //     price = double.parse(json['price_usd']),
  //     symbol = json["symbol"];

  // GDAX
  Coin.fromJson(Map json):
       name = json['product_id'],
       price = json['price'];
       //symbol = json["symbol"];
}