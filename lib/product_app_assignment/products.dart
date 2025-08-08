import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:systemic_altruism_/product_app_assignment/product_details.dart';

import 'bloc/product_cubit.dart';
import 'model/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductBloc _pb = ProductBloc();
  late Map<Product,int> cartItems;
  late List<Product> items;
  final GlobalKey _sKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    cartItems = {};
    _pb.getProducts();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text('Products'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                if(value != '') {
                  _pb.searchProducts(value, items);
                }
                else {
                  _pb.getProducts();
                }
              },
            ),
          ),
        ),

      ),
      drawer: Drawer(

        child: Container(
          width: 150,
          height: 600,
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Cart Items'),
              ),
              Container(
                height: 500,
                width: 150,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      Product p = cartItems.keys.elementAt(index);
                      // int quantity = cartItems.values.elementAt(index);
                      return Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          height: 80,
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      p.title,
                                      maxLines: 2,
                                      style: TextStyle(fontWeight: FontWeight.bold,),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text('Rs ${p.price}'),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if(cartItems[p] == 1) {


                                          setState(() {
                                            cartItems.remove(p);
                                          });
                                        }
                                        else if(cartItems[p]! > 1)
                                          cartItems[p] = (cartItems[p]! - 1);
                                      });
                                    },
                                  ),
                                  Text('${cartItems.values.elementAt(index)}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        cartItems[p] = (cartItems[p]! + 1);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                  ),
              ),



            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _pb,
        builder: (context, state) {
          if (state is ProductInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            items = state.products;

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(product: state.products[index], cartItems: cartItems,)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                        surfaceTintColor: Colors.white,
                        borderOnForeground: true,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.network(
                                  state.products[index].image,
                                fit: BoxFit.contain,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        // value: loadingProgress.expectedTotalBytes != null
                                        //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        //     : null,
                                      ),
                                    );
                                  }
                                },
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 110,
                                        // height: 80,
                                        child: Text(
                                            state.products[index].title,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Text('Rs ${state.products[index].price}')
                                    ]
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_shopping_cart),
                                    onPressed: () async {
                                      cartItems.update(state.products[index], (value) => value + 1, ifAbsent: () => 1);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Item ${state.products[index].title} has been added to cart'),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                  ),

                                ],
                              ),
                            )
                          ]
                        )
                      ),
                    );
                    // return Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Card(
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //           flex: 1,
                    //           child: Image.network(
                    //               state.products[index].image,
                    //             loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    //               if (loadingProgress == null) {
                    //                 return child;
                    //               } else {
                    //                 return Center(
                    //                   child: CircularProgressIndicator(
                    //                     // value: loadingProgress.expectedTotalBytes != null
                    //                     //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    //                     //     : null,
                    //                   ),
                    //                 );
                    //               }
                    //             },
                    //             width: double.infinity,
                    //             height: 200,
                    //           ),
                    //         ),
                    //         Expanded(
                    //           flex: 2,
                    //           child: Column(
                    //             children: [
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     // width: 150,
                    //                     child: Text(
                    //                         state.products[index].title,
                    //                       style: TextStyle(
                    //                         fontSize: 20,
                    //                         fontWeight: FontWeight.bold,
                    //                       )
                    //                     ),
                    //                   ),
                    //                   Text('Rs ${state.products[index].price}')
                    //                 ]
                    //               ),
                    //               Text(
                    //                   state.products[index].description,
                    //                 maxLines: 4,
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text('${state.products[index].rating.rate}⭐'),
                    //                   Text(' (${state.products[index].rating.count} reviews)' ),
                    //                   IconButton(
                    //                     icon: Icon(Icons.add_shopping_cart),
                    //                     onPressed: () async {
                    //
                    //                       cartItems.update(state.products[index], (value) => value + 1, ifAbsent: () => 1);
                    //                       ScaffoldMessenger.of(context).showSnackBar(
                    //                         SnackBar(
                    //                           content: Text('Item ${state.products[index].title} has been added to cart'),
                    //                         ),
                    //                       );
                    //                       setState(() {});
                    //                     },
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //
                    //       ]
                    //     )
                    //   ),
                    // );
                  },
                ),
              ),
            );
          } else if (state is ProductError) {
            return Center(
              child: Text('Error loading products'),
            );
          } else {
            return Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}
