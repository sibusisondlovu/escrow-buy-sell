import 'package:mobile_app/models/product_model.dart';
import 'package:mobile_app/models/user_model.dart';

class TransactionModel {
  final String transactionId;      // Unique ID for the transaction
  final Product product;           // Details about the product being bought
  final String buyer;                // Buyer user details (using the User model)
  final String seller;               // Seller user details (using the User model)
  final double amountPaid;         // Amount paid by the buyer
  final TransactionStatus status;  // Current status of the transaction
  final DateTime transactionDate;  // Date and time of the transaction
  final DateTime transactionTime;  // Time of the transaction (optional)
  final String paymentGateway;     // Payment gateway used for the transaction (e.g., Stripe, PayPal)

  TransactionModel({
    required this.transactionId,
    required this.product,
    required this.buyer,
    required this.seller,
    required this.amountPaid,
    required this.status,
    required this.transactionDate,
    required this.paymentGateway,
    required this.transactionTime
  });
}
// Enum to hold the status of the transaction
enum TransactionStatus {
  pending,     // Payment is pending
  paid,        // Payment completed, funds in escrow
  shipped,     // Item shipped by seller
  delivered,   // Item delivered to buyer
  confirmed,   // Buyer confirmed goods
  released,    // Funds released to seller
  cancelled, completed,   // Transaction cancelled
}
