class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;
  final bool profileCompleted;
  String? photoUrl;
  Map<String, dynamic>? profileData;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.profileCompleted,
    this.photoUrl,
    this.profileData,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? 'user',
      profileCompleted: map['profileCompleted'] ?? false,
      photoUrl: map['photoUrl'],
      profileData: map['profileData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'profileCompleted': profileCompleted,
      'photoUrl': photoUrl,
      'profileData': profileData,
    };
  }
}