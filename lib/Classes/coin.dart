class Coin {
  final String id;
  final String name;
  final String symbol;
  final double price;

  Coin({this.id, this.name, this.price, this.symbol});

  // Helper function
  // Structure from https://api.coinmarketcap.com/v1/ticker
  Coin.fromJson(Map json)
    : id = json['id'],
      name = json['name'],
      price = double.parse(json['price_usd']),
      symbol = json["symbol"];
}