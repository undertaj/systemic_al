import 'package:flutter/material.dart';

import 'model/product_model.dart';


class ProductDetails extends StatefulWidget {
  final Product product;
  Map<Product,int> cartItems;
  ProductDetails({super.key, required this.product, required this.cartItems} );


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
                widget.product.image,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
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
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 150,
                  child: Text(
                      widget.product.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rs ${widget.product.price}'),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(categoryValues.reverse[widget.product.category]!,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                )
              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )
                ),
                Text(widget.product.description)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${widget.product.rating.rate}⭐'),
                    Text(' (${widget.product.rating.count} reviews)' ),
                  ],
                ),
                // IconButton(
                //   icon: Icon(Icons.add_shopping_cart),
                //   onPressed: () async {
                //
                //     widget.cartItems.update(widget.product, (value) => value + 1, ifAbsent: () => 1);
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text('Item ${widget.product.title} has been added to cart'),
                //       ),
                //     );
                //     setState(() {});
                //   },
                // ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

