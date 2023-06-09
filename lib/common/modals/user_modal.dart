class UserModel {
  final String username;
  final String uid;
  final String profileImageUrl;
  final String phoneNumber;
  final int lastSeen;
  final bool active;
  final List<String> groupId;

  UserModel({
    required this.username,
    required this.uid,
    required this.profileImageUrl,
    required this.phoneNumber,
    required this.lastSeen,
    required this.active,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'profileImageUrl': profileImageUrl,
      'active': active,
      'phoneNumber': phoneNumber,
      'lastSeen': lastSeen,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      lastSeen: map['lastSeen'] ?? 0,
      active: map['active'] ?? false,
      groupId: List<String>.from(map['groupId']),
    );
  }
}
