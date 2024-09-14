import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../controllers/cart_notifier.dart';
import '../../data/product_data.dart';
import '../../models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Featured Products',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildFeaturedProducts(),
          const SizedBox(height: 20),
          Expanded(
            child:  _buildProductGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    // Hardcoded list of featured products for now
    List<Product> featuredProducts = products.take(2).toList();

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredProducts.length,
        itemBuilder: (context, index) {
          final product = featuredProducts[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ProductDetailPage(product: product),
              //   ),
              // );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text("\$${product.price.toStringAsFixed(2)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProductDetailPage(product: product),
            //   ),
            // );
          },
          child: Stack(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Seller Avatar
                          const CircleAvatar(
                            backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                            radius: 15,
                          ),
                          const SizedBox(width: 8.0),
                          // Seller Username and Rating
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.seller,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              // Rating Bar (use flutter_rating_bar package)
                              RatingBarIndicator(
                                rating: 4.5, // Static rating for now
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 12.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            // Product Image
                            Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            // Name and Price on Top of the Image
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "\$${product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Seller Info Row with Avatar and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.voice_chat_sharp),
                            onPressed: () {
                              // TODO: Handle Add to Cart action
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              Navigator.pushNamed(context, 'productDetailScreen', arguments: product);
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddToCartDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Added to Cart',
      desc: 'The item has been added to your cart.',
      btnCancelOnPress: () {
        // Continue shopping
        Navigator.pop(context);
      },
      btnOkOnPress: () {
        // Go to checkout
        // For now, just close the dialog. You can implement a cart/checkout page.
        Navigator.pop(context);
      },
      btnOkText: 'Checkout',
      btnCancelText: 'Continue Shopping',
    ).show();
  }
}
