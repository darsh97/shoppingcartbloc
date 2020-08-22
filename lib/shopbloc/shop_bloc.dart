import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:shoppingcartbloc/model/Item.dart';
import 'package:shoppingcartbloc/repo/CartRepo.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopCartRepo shopcartrepo;
  ShopBloc(this.shopcartrepo) : super(ShopInitial());

  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if (event is LoadShopItemsSuccess) {
      try {
        yield ShopLoadSucess(shopcartrepo: shopcartrepo);
      } catch (error) {
        yield ShopLoadFailure(error: "{$error}");
      }
    }

    if (event is AddItemToShop) {
      if (state is ShopLoadSucess) {
        debugPrint(
            ((state as ShopLoadSucess).shopcartrepo.allItems).toString());

        yield ShopLoadSucess(
            shopcartrepo: ((state as ShopLoadSucess).shopcartrepo)
              ..addToShop(event.item));
      }
    }

    if (event is RemoveItemFromShop) {
      if (state is ShopLoadSucess) {
        yield ShopLoadSucess(
            shopcartrepo: ((state as ShopLoadSucess).shopcartrepo)
              ..addToCart(event.item));
        debugPrint(
            ((state as ShopLoadSucess).shopcartrepo.allItems).toString());
      }
    }
  }
}
