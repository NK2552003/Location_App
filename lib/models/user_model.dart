class UserModel {
  final String userId;
  final String status;

  UserModel({required this.userId, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'status': status,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      status: json['status'],
    );
  }
}
