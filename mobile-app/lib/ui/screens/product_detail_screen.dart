import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/product_model.dart';
import 'video_chat_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;
  static const String id = "productDetailScreen";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final String  appId = "7a48ddd373904306aa9748fa578ba1a1";
  final String token = "007eJxTYFDuZl1yOpnP993lhr7/RyecjfGTm5S++PCppi0eXKqTF4QoMJgnmlikpKQYmxtbGpgYG5glJlqam1ikJZqaWyQlGiYaTrryLK0hkJHhYNJ+VkYGCATxORicSisVglNzchgYAAeNIfE=";
  final String channel = "Buy Sell";

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
                    "R ${widget.product.price.toStringAsFixed(2)}",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoChatScreen(
                            channelName: channel,
                            appId: appId,
                            token: token,
                          ),
                        ),
                      );
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
