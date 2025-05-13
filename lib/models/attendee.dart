class AttendeeModel {
  final String uid;
  final String email;
  final String ticketNumber;
  final String ticketType;
  final String firstName;
  final String lastName;
  final String phone;
  final int goldCoin;
  final int silverCoin;

  // Normal constructor
  AttendeeModel({
    required this.uid,
    required this.email,
    required this.ticketNumber,
    required this.ticketType,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.goldCoin,
    required this.silverCoin,
  });

  //Factory constructor
  factory AttendeeModel.fromMap(String uid, Map<String, dynamic> map) {
    return AttendeeModel(
      uid: uid,
      email: map['email'] ?? '',
      ticketNumber: map['ticketNumber'] ?? '',
      ticketType: map['ticketType'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phone: map['phone'] ?? '',
      goldCoin: map['goldCoin'] ?? 0,
      silverCoin: map['silverCoin'] ?? 0,
    );
  }
}
