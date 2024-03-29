// ignore_for_file:  sort_constructors_first
// ignore_for_file: avoid_dynamic_calls
// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.email,
    this.username,
    this.avatar,
    this.firstname,
    this.lastname,
    this.birthday,
    required this.isSetup,
  });

  factory Profile.fromJson(dynamic data) {
    return Profile(
      id: data['id'] as String,
      email: data['email'] as String,
      username: data['username'] as String?,
      avatar: data['avatar'] as String?,
      firstname: data['firstname'] as String?,
      lastname: data['lastname'] as String?,
      birthday: DateTime.tryParse(data['birthday'] as String? ?? ''),
      isSetup: data['is_setup'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'avatar': avatar,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': birthday!.toIso8601String(),
      'is_setup': isSetup,
    };
  }

  

  final String id;
  final String email;
  final String? username;
  final String? avatar;
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final bool isSetup;

  static const empty = Profile(
    id: '',
    email: '',
    isSetup: false,
  );

  bool get isEmpty => this == Profile.empty;

  bool get isNotEmpty => this != Profile.empty;

  bool get isSetupCompleted => isSetup;

  @override
  List<Object?> get props => [id, email, username, avatar, firstname, lastname, birthday, isSetup];

  Profile copyWith({
    String? id,
    String? email,
    String? username,
    String? avatar,
    String? firstname,
    String? lastname,
    DateTime? birthday,
    bool? isSetup,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      birthday: birthday ?? this.birthday,
      isSetup: isSetup ?? this.isSetup,
    );
  }
}
