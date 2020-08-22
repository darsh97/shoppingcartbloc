import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppingcartbloc/model/Item.dart';
import 'package:shoppingcartbloc/repo/CartRepo.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShopCartRepo shopcartrepo;
  CartBloc(this.shopcartrepo) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartItemsLoadSucess) {
      try {
        debugPrint("Cart Bloc instance => ${shopcartrepo.allItems}");
        yield CartLoadSucess(shopcartrepo);
      } catch (error) {
        yield CartLoadFailure("$error");
      }
    }

    if (event is RemoveCartItem) {
      if (state is CartLoadSucess) {
        yield CartLoadSucess(((state as CartLoadSucess).shopCartRepo)
          ..removeFromCart(event.item));
      }
    }
  }
}
