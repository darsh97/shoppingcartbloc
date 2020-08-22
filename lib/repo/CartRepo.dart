import 'dart:async';
import 'package:shoppingcartbloc/model/Item.dart';

class ShopCartRepo {
  double cartprice = 0;

  final cartStreamController = StreamController.broadcast();

  Stream get getStream => cartStreamController.stream;
  double get cartTotalPrice => cartprice;

  final Map allItems = {
    'shop items': [
      Item(id: 0, name: "Item A", price: 1.0),
      Item(id: 1, name: "Item B", price: 130.0),
      Item(id: 2, name: "Item C", price: 10.0),
      Item(id: 3, name: "Item D", price: 230.0),
      Item(id: 4, name: "Item E", price: 500.0),
    ],
    'cart items': []
  };

  void addToShop(item) {
    allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  void addToCart(item) {
    allItems['shop items'].remove(item);
    allItems['cart items'].add(item);
    cartprice += item.price;
    cartStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    allItems['cart items'].remove(item);
    allItems['shop items'].add(item);
    cartprice -= item.price;
    cartStreamController.sink.add(allItems);
  }

  void dispose() {
    cartStreamController.close();
  }
}
