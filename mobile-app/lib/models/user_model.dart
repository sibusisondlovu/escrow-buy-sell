class UserModel {
  final String userUid;        // Unique identifier for the user
  final String fullName;       // Full name of the user
  final String location;       // User's location (e.g., city, country)
  final String avatarUrl;      // URL to the user's avatar/profile picture
  final double rating;         // General rating (aggregate of buyer and seller ratings)
  final DateTime memberSince;  // Date the user joined the platform

  final SellerProfile? sellerProfile;  // Seller-specific profile, optional
  final BuyerProfile? buyerProfile;    // Buyer-specific profile, optional

  UserModel({
    required this.userUid,
    required this.fullName,
    required this.location,
    required this.avatarUrl,
    required this.rating,
    required this.memberSince,
    this.sellerProfile,
    this.buyerProfile,
  });
}

class SellerProfile {
  final double sellerRating;    // Seller-specific rating
  final int totalSales;         // Total number of sales as a seller
  final List<String> products;  // List of product IDs the seller is selling

  SellerProfile({
    required this.sellerRating,
    required this.totalSales,
    required this.products,
  });
}

class BuyerProfile {
  final double buyerRating;   // Buyer-specific rating
  final int totalPurchases;   // Total number of purchases as a buyer
  final List<String> purchasedItems;  // List of product IDs the buyer has purchased

  BuyerProfile({
    required this.buyerRating,
    required this.totalPurchases,
    required this.purchasedItems,
  });
}