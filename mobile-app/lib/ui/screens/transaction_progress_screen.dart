import 'package:flutter/material.dart';
import 'package:mobile_app/models/transaction_model.dart';
import 'package:mobile_app/ui/screens/main_layout_screen.dart';

class TransactionProgressScreen extends StatefulWidget {
  const TransactionProgressScreen(
      {super.key,
      required this.transaction,});
  static const String id = "transactionProgressScreen";

  final TransactionModel transaction;

  @override
  State<TransactionProgressScreen> createState() =>
      _TransactionProgressScreenState();
}

class _TransactionProgressScreenState extends State<TransactionProgressScreen> {

  int _currentStep = 2;
  bool _isDealApproved = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainLayout()),
                (Route<dynamic> route) => false, // This removes all previous routes
          );
        },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        backgroundColor: Colors.red,
        title: const Text('Escrow Transaction Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            // Transaction Summary
            _buildTransactionSummary(),
            const SizedBox(height: 20),
            // Stepper to track the transaction stages
            Expanded(
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (step) => setState(() => _currentStep = step),
                steps: _buildSteps(),
                controlsBuilder: (BuildContext context, ControlsDetails controls) {
                  return const SizedBox.shrink(); // Hide default controls
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSummary() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Details
            Row(
              children: [
                Image.network(
                  "https://th.bing.com/th/id/OIP.lTmSRLPfVUJxz76w1rT8eQHaEX?rs=1&pid=ImgDetMain",
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
                        widget.transaction.product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${widget.transaction.amountPaid.toStringAsFixed(2)} Paid",
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
            const SizedBox(height: 10),
            // Buyer and Seller Info
            Text(
              'Buyer: ${widget.transaction.buyer}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Seller: ${widget.transaction.seller}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  List<Step> _buildSteps() {
    return [
      // Step 1: Buyer Browses and Selects Product
      Step(
        title: const Text('Product Viewed'),
        content: const Text('Buyer has viewed the product details.'),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      // Step 2: Buyer Contacts Seller
      Step(
        title: const Text('Contact Seller'),
        content: const Text('Buyer has contacted the seller and agreed on terms.'),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      // Step 3: Buyer Loads Funds into Escrow
      Step(
        title: const Text('Funds Loaded into Escrow'),
        content: const Text('Buyer has loaded the funds into the escrow system.'),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      // Step 4: Seller Prepares Item for Shipment/Collection
      Step(
        title: const Text('Seller Preparing Item'),
        content: const Text('Seller has been notified and is preparing the item for delivery.'),
        isActive: _currentStep >= 3,
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      // Step 5: Buyer Receives the Item
      Step(
        title: const Text('Item Received'),
        content: const Text('Buyer has received the item via courier or collection.'),
        isActive: _currentStep >= 4,
        state: _currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
      // Step 6: Buyer Confirms Goods
      Step(
        title: const Text('Buyer Confirms Goods'),
        content: const Text('Buyer has confirmed the item is in order.'),
        isActive: _currentStep >= 5,
        state: _currentStep > 5 ? StepState.complete : StepState.indexed,
      ),
      // Step 7: Payment Released to Seller
      Step(
        title: const Text('Payment Released to Seller'),
        content: const Text('Payment has been released to the seller.'),
        isActive: _currentStep >= 6,
        state: _currentStep > 6 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

}
