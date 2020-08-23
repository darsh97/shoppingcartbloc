import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shoppingcartbloc/cartBloc/cart_bloc.dart';
import 'package:shoppingcartbloc/repo/CartRepo.dart';
import 'package:shoppingcartbloc/screens/shoppage.dart';
import 'package:shoppingcartbloc/shopbloc/shop_bloc.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ShopCartRepo());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ShopCartRepo get shopcartrepo => GetIt.I<ShopCartRepo>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ShopBloc(shopcartrepo)..add(LoadShopItemsSuccess()),
          ),
          BlocProvider(
              create: (context) =>
                  CartBloc(shopcartrepo)..add(CartItemsLoadSucess()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ShoppingPage(),
        ));
  }
}
