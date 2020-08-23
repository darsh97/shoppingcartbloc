import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcartbloc/model/Item.dart';
import 'package:shoppingcartbloc/screens/cartpage.dart';
import 'package:shoppingcartbloc/shopbloc/shop_bloc.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Shopping Page"),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                }),
          ],
        ),
        body: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is ShopLoadSucess) {
              final repo = state.shopcartrepo;
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: StreamBuilder(
                  initialData: repo.allItems,
                  stream: repo.getStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data['shop items'].length,
                        itemBuilder: (context, index) {
                          final shoplst = snapshot.data['shop items'];
                          final item = shoplst[index] as Item;
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text("\$${item.price}"),
                            trailing: IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                BlocProvider.of<ShopBloc>(context)
                                    .add(RemoveItemFromShop(item: item));
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: Text("No data in snapshot"),
                        ),
                      );
                    }
                  },
                ),
              );
            } else {
              return Center(child: Text("$state"));
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add Shop Item"),
          onPressed: () {
            BlocProvider.of<ShopBloc>(context).add(AddItemToShop(
                item: Item(id: 10, name: "RandomItem", price: 20.0)));
          },
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
