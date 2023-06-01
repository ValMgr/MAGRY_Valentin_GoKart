import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/theme/theme.dart';
import 'package:go_kart/profile/profile.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  static bool isEditModalOpened = false;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

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
              children: const [
                Text('Edit Profile'),
                SizedBox(height: 16),
                AvatarEditField(),
                SizedBox(height: 16),
                UsernameEditField(),
                SizedBox(height: 16),
                FirstnameEditField(),
                SizedBox(height: 16),
                LastnameEditField(),
                SizedBox(height: 16),
                BirthdayEditField(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AvatarEditField extends StatefulWidget {
  const AvatarEditField({
    super.key,
  });

  @override
  State<AvatarEditField> createState() => _AvatarEditFieldState();
}

class _AvatarEditFieldState extends State<AvatarEditField> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return GestureDetector(
      onTap: () => {
        // open dialog to choose image from gallery or camera
        showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Choose image from'),
            content: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await pickImageFromGallery(ImageSource.camera, cubit);
                      // Navigator.of(context).pop();
                    },
                    style: GoKartButtons.elevatedButton,
                    child: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await pickImageFromGallery(ImageSource.gallery, cubit);
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    style: GoKartButtons.elevatedButton,
                    child: const Text('Gallery'),
                  ),
                ),
              ],
            ),
          ),
        ),
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: AvatarUtils.display(state.avatar),
            child: Stack(
              children: const [
                Icon(Icons.add_a_photo, color: Colors.white),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> pickImageFromGallery(ImageSource source, ProfileCubit cubit) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      cubit.avatarChanged(image.path);
      // return File(image.path);
    } on Exception catch (e) {
      throw Exception('Error picking image: $e');
    }
  }
}

class UsernameEditField extends StatelessWidget {
  const UsernameEditField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return TextFormField(
      initialValue: cubit.state.username,
      decoration: const InputDecoration(
        labelText: 'Username',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: cubit.usernameChanged,
    );
  }
}

class FirstnameEditField extends StatelessWidget {
  const FirstnameEditField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return TextFormField(
      initialValue: cubit.state.firstname,
      decoration: const InputDecoration(
        labelText: 'Firstname',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: cubit.firstnameChanged,
    );
  }
}

class LastnameEditField extends StatelessWidget {
  const LastnameEditField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return TextFormField(
      initialValue: cubit.state.lastname,
      decoration: const InputDecoration(
        labelText: 'Lastname',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: cubit.lastnameChanged,
    );
  }
}

class BirthdayEditField extends StatelessWidget {
  const BirthdayEditField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return InputDatePickerFormField(
      fieldLabelText: 'Birthday',
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: cubit.state.birthday ?? DateTime.now(),
      onDateSubmitted: cubit.birthdayChanged,
    );
  }
}
