class UserData {
  final String email;
  final String uId;

  UserData({
    required this.email,
    required this.uId,
  });

  UserData copyWith({
    String? email,
    String? uId,
  }) {
    return UserData(
      email: email ?? this.email,
      uId: uId ?? this.uId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uId': uId,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'],
      uId: map['uId'],
    );
  }
}
