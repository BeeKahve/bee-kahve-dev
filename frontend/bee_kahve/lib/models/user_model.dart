class User {
  final int customerId;
  final String name;
  final String email;
  final String address;
  final int loyaltyCount;

  User({
    required this.customerId,
    required this.name,
    required this.email,
    required this.address,
    required this.loyaltyCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      customerId: json['customer_id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      loyaltyCount: json['loyalty_count'],
    );
  }
}
