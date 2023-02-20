part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.id = '',
    this.email = '',
    this.avatar = '',
    this.username = '',
    this.firstname = '',
    this.lastname = '',
    this.birthday,
    this.isSetup = false,
    this.status = ProfileStatus.initial,
  });

  final String id;
  final String email;
  final String avatar;
  final String username;
  final String firstname;
  final String lastname;
  final DateTime? birthday;
  final bool isSetup;
  final ProfileStatus status;

  @override
  List<Object?> get props =>
      [id, email, avatar, username, firstname, lastname, birthday, status];

  ProfileState copyWith({
    String? id,
    String? email,
    String? avatar,
    String? username,
    String? firstname,
    String? lastname,
    DateTime? birthday,
    bool? isSetup,
    ProfileStatus? status,
  }) {
    return ProfileState(
      id: id ?? this.id,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      birthday: birthday ?? this.birthday,
      isSetup: isSetup ?? this.isSetup,
      status: status ?? this.status,
    );
  }

  Profile toProfile() {
    return Profile(
      id: id,
      email: email,
      avatar: avatar,
      username: username,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday,
      isSetup: isSetup,
    );
  }
}
