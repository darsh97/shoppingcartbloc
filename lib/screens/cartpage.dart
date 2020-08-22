import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartbloc/cartBloc/cart_bloc.dart';
import 'package:shoppingcartbloc/model/Item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Cart Page"),
            centerTitle: true,
          ),
          body: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadSucess) {
                final repo = state.shopCartRepo;
                return StreamBuilder(
                  initialData: repo.allItems,
                  stream: repo.getStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data['cart items'].length,
                              itemBuilder: (context, index) {
                                final cartitem =
                                    snapshot.data['cart items'][index] as Item;
                                return ListTile(
                                  title: Text(cartitem.name),
                                  subtitle: Text("\$${cartitem.price}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.remove_shopping_cart),
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context)
                                          .add(RemoveCartItem(cartitem));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 30.0, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blueAccent,
                                  ),
                                  child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Go Shopping",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Subtotal ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "\$${repo.cartTotalPrice}",
                                          style: TextStyle(
                                              color: Colors.teal[200])),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: Text("Snapshot data missing",
                              style: TextStyle(color: Colors.red)),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Container(
                    child: Text("$state"),
                  ),
                );
              }
            },
          )),
    );
  }
}
