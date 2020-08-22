part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadSucess extends CartState {
  final ShopCartRepo shopCartRepo;

  CartLoadSucess(this.shopCartRepo);

  @override
  List<Object> get props => [shopCartRepo];
}

class CartLoadFailure extends CartState {
  final String error;

  CartLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
