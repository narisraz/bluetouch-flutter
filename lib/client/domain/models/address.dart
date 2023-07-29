class Address {
  final String? rue;
  final String? address;
  final String? lat;
  final String? long;

  Address({this.rue, this.address, this.lat, this.long});

  Map<String, dynamic> toJson() {
    return {
      'rue': rue,
      'address': address,
      'lat': lat,
      'long': long,
    };
  }

  static Address fromJson(Map<String, dynamic> data) {
    return Address(
      long: data['long'],
      lat: data['lat'],
      address: data['address'],
      rue: data['rue'],
    );
  }
}
