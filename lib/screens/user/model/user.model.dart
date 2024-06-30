class UserMetaInfo {
  final String uid;
  final String email;
  final String? firstName;
  final String? lastName;
  final String displayName;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserMetaInfo({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    required this.displayName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserMetaInfo.fromJson(Map<String, dynamic> json) {
    return UserMetaInfo(
      uid: json['uid'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserMetaInfo copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? displayName,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserMetaInfo(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      displayName: displayName ?? this.displayName, 
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}