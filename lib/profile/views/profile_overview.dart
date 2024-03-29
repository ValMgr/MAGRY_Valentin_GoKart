import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/profile/profile.dart';
import 'package:quickalert/quickalert.dart';

class ProfileOveriew extends StatelessWidget {
  const ProfileOveriew({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.success && !state.isSetup && !EditProfile.isEditModalOpened) {
          QuickAlert.show(
            context: context,
            title: 'Welcome !',
            text: 'Edit your profile to get started',
            type: QuickAlertType.info,
            onConfirmBtnTap: () {
              Navigator.of(context, rootNavigator: true).pop();
              if (!EditProfile.isEditModalOpened) {
                EditProfile.isEditModalOpened = true;
                showModalBottomSheet<void>(
                  context: context,
                  builder: (ctx) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: const EditProfile(),
                  ),
                );
              }
            },
          );
        }
      },
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildEditProfile(context, cubit),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _avatarPreview(context),
                      const SizedBox(height: 8),
                      Text(state.email),
                      const SizedBox(height: 8),
                      Text(state.username),
                      const SizedBox(height: 8),
                      Text('${state.firstname} ${state.lastname}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _avatarPreview(BuildContext context) {
  final avatar = context.select((ProfileCubit cubit) => cubit.state.avatar);
  return CircleAvatar(
    radius: 30,
    backgroundColor: Theme.of(context).colorScheme.primary,
    backgroundImage: AvatarUtils.display(avatar),
    child: avatar == ''
        ? const Icon(
            Icons.person,
            color: Colors.white,
          )
        : null,
  );
}

Widget _buildEditProfile(BuildContext context, ProfileCubit cubit) {
  return IconButton(
    icon: Icon(
      Icons.edit,
      color: Theme.of(context).colorScheme.primary,
    ),
    iconSize: 16,
    tooltip: 'Edit profile',
    onPressed: () => {
      showModalBottomSheet<void>(
        context: context,
        builder: (ctx) => BlocProvider.value(
          value: context.read<ProfileCubit>(),
          child: const EditProfile(),
        ),
      )
    },
  );
}
