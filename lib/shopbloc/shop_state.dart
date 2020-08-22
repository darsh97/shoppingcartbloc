part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoadSucess extends ShopState {
  final ShopCartRepo shopcartrepo;

  ShopLoadSucess({
    this.shopcartrepo,
  }) : assert(shopcartrepo != null);

  @override
  List<Object> get props => [shopcartrepo];
}

class ShopLoadFailure extends ShopState {
  final String error;

  ShopLoadFailure({
    this.error,
  });

  @override
  List<Object> get props => [error];
}
