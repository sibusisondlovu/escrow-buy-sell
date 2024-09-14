import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class EscrowScreen extends StatefulWidget {
  const EscrowScreen({super.key, required this.product});
  final Product product;
  static const String id = "escrowScreen";

  @override
  State<EscrowScreen> createState() => _EscrowScreenState();
}

class _EscrowScreenState extends State<EscrowScreen> {

  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escrow Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image and Title
            Row(
              children: [
                Image.network(
                  widget.product.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${widget.product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Seller Information
            Text(
              'Seller: ${widget.product.seller}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Terms and Conditions Checkbox
            Row(
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I agree to the terms and conditions of the escrow service.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Proceed to Payment Button
            ElevatedButton(
              onPressed: _agreedToTerms
                  ? () {
                final queryParameters = {
                  'merchant_key': 'q1cd2rdny4a53',
                  'merchant_id': '10004002',
                  'amount': (widget.product.price).toString(),
                  'item_name': widget.product.title,
                  'return_url': 'https://jaspagroup.co.za/payfast/success.html',
                  'cancel_url': 'https://jaspagroup.co.za/payfast/cancel.html',
                };
                final uri =
                Uri.https('sandbox.payfast.co.za', "/eng/process", queryParameters);
                Navigator.pushNamed(context, 'payFast', arguments: uri);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Proceeding to payment...'),
                  ),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                textStyle: const TextStyle(fontSize: 16),
              ), // Disable button if terms not agreed
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
