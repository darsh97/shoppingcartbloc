import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartbloc/cartBloc/cart_bloc.dart';
import 'package:shoppingcartbloc/repo/CartRepo.dart';
import 'package:shoppingcartbloc/screens/shoppage.dart';
import 'package:shoppingcartbloc/shopbloc/shop_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ShopCartRepo _shopCartRepo = ShopCartRepo();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopBloc(_shopCartRepo)..add(LoadShopItemsSuccess()),
          ),
          BlocProvider(
              create: (context) => CartBloc(_shopCartRepo)..add(CartItemsLoadSucess()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ShoppingPage(),
        ));
  }
}
