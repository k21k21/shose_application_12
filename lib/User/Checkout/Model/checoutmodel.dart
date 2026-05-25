class ShippingAddress {
  final String fullName;
  final String city;
  final String streetAddress;
  final String buildingNumber;
  final String phoneNumber;

  ShippingAddress({
    required this.fullName,
    required this.city,
    required this.streetAddress,
    required this.buildingNumber,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'Full Name': fullName,
      'City': city,
      'Street Address': streetAddress,
      'Building Number': buildingNumber,
      'Phone Number': phoneNumber,
      'Order Date': DateTime.now(),
    };
  }
}
