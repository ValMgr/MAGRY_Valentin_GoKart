import 'package:flutter/material.dart';
import 'package:go_kart/profile/profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.cubit});

  static bool isEditModalOpened = false;
  final ProfileCubit? cubit;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit!;
    final profile = cubit.state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Positioned(
              top: -12,
              left: 0,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),
            Positioned(
              top: -12,
              right: 0,
              child: TextButton(
                onPressed: () {
                  cubit.updateProfile();
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ),
            Column(
              children: [
                const Text('Edit Profile'),
                const SizedBox(height: 16),
                _avatarEditField(
                  profile.avatar,
                  Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                _usernameEditField(profile.username, cubit.usernameChanged),
                const SizedBox(height: 16),
                _firstnameEditField(profile.firstname, cubit.firstnameChanged),
                const SizedBox(height: 16),
                _lastnameEditField(profile.lastname, cubit.lastnameChanged),
                const SizedBox(height: 16),
                _birthdayEditField(profile.birthday, cubit.birthdayChanged),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _avatarEditField(String avatar, Color defaultBackground) {
  return GestureDetector(
    onTap: () => print('Import image'),
    child: CircleAvatar(
      radius: 30,
      backgroundColor: defaultBackground,
      child: Stack(
        children: [
          if (avatar != '') Image.network(avatar),
          const Icon(Icons.add_a_photo, color: Colors.white)
        ],
      ),
    ),
  );
}

Widget _usernameEditField(String username, Function onChange) {
  return TextFormField(
    initialValue: username,
    decoration: const InputDecoration(
      labelText: 'Username',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
    onChanged: (value) => onChange(value),
  );
}

Widget _firstnameEditField(String? firstname, Function onChange) {
  return TextFormField(
      initialValue: firstname,
      decoration: const InputDecoration(
        labelText: 'Firstname',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: (value) => onChange(value));
}

Widget _lastnameEditField(String? lastname, Function onChange) {
  return TextFormField(
    initialValue: lastname,
    decoration: const InputDecoration(
      labelText: 'Lastname',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
    onChanged: (value) => onChange(value),
  );
}

Widget _birthdayEditField(DateTime? birthday, Function onChange) {
  return InputDatePickerFormField(
    fieldLabelText: 'Birthdayyyy',
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    initialDate: birthday ?? DateTime.now(),
    onDateSubmitted: (value) => onChange(value),
  );
}
