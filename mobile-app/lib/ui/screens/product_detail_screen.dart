import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;
  static const String id = "productDetailScreen";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Image.network(
              widget.product.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    widget. product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Product Price
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Product Description
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  // Seller Information
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                        radius: 25,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.seller,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          RatingBarIndicator(
                            rating: 4.5, // Dummy data for now
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 12.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Start Chat with Seller Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Open chat screen with seller
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('Start Chat with Seller'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Deal Button - Redirect to Escrow Payment
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'escrowScreen', arguments: widget.product);
                    },
                    icon: const Icon(Icons.security),
                    label: const Text('Proceed to Deal'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
