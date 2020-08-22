part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class LoadShopItemsSuccess extends ShopEvent {}

class AddItemsToShop extends ShopEvent {
  final Item item;
  AddItemsToShop({
    this.item,
  }) : assert(item != null);

  @override
  List<Object> get props => [item];
}

class AddItemToShop extends ShopEvent {
  final Item item;

  AddItemToShop({
    this.item,
  }) : assert(item != null);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromShop extends ShopEvent {
  final Item item;
  RemoveItemFromShop({
    this.item,
  }) : assert(item != null);

  @override
  List<Object> get props => [item];
}
