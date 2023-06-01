import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userId) : super(const ProfileState());

  final ProfileRepository _profileRepository = ProfileRepository();
  final String _userId;

  Future<void> getProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final profile = await _profileRepository.findOne(_userId);
      emit(
        state.copyWith(
          email: profile.email,
          avatar: profile.avatar,
          username: profile.username,
          firstname: profile.firstname,
          lastname: profile.lastname,
          birthday: profile.birthday,
          isSetup: profile.isSetup,
          status: ProfileStatus.success,
        ),
      );
    } on Exception catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  Future<void> updateProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      var profile = Profile(
        id: _userId,
        email: state.email,
        avatar: state.avatar,
        username: state.username,
        firstname: state.firstname,
        lastname: state.lastname,
        birthday: state.birthday,
        isSetup: true,
      );

      if (File(profile.avatar!).isAbsolute) {
        try {
          final avatar = await _profileRepository.uploadAvatar(File(profile.avatar!));
          profile = profile.copyWith(avatar: avatar);

        } catch (e) {
          throw Exception('Failed to upload avatar');
        }
      }

      await _profileRepository.updateProfile(profile);
      emit(state.copyWith(status: ProfileStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  void firstnameChanged(String firstname) {
    emit(state.copyWith(firstname: firstname));
  }

  void lastnameChanged(String lastname) {
    emit(state.copyWith(lastname: lastname));
  }

  void birthdayChanged(DateTime birthday) {
    emit(state.copyWith(birthday: birthday));
  }

  void avatarChanged(String avatar) {
    emit(state.copyWith(avatar: avatar));
  }

  void usernameChanged(String username) {
    emit(state.copyWith(username: username));
  }
}
