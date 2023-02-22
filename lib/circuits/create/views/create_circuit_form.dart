import 'package:flutter/material.dart';

class CreateCircuitForm extends StatelessWidget {
  const CreateCircuitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            children: [
              const _NameInput(),
              const _CornersInput(),
              const _LengthInput(),
              const _EmailInput(),
              const _TelephoneInput(),
              const _WebsiteInput(),
              const _LocationInput(),
              const _AddressInput(),
              ElevatedButton(
                onPressed: () => print('create circuit'),
                child: const Text('Create circuit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }
}

class _CornersInput extends StatelessWidget {
  const _CornersInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Corners',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number of corners';
        }
        return null;
      },
    );
  }
}

class _LengthInput extends StatelessWidget {
  const _LengthInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Length',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a length';
        }
        return null;
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        }
        return null;
      },
    );
  }
}

class _TelephoneInput extends StatelessWidget {
  const _TelephoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Telephone',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a telephone';
        }
        return null;
      },
    );
  }
}

class _WebsiteInput extends StatelessWidget {
  const _WebsiteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Website',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a website';
        }
        return null;
      },
    );
  }
}

class _LocationInput extends StatelessWidget {
  const _LocationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Location',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a location';
        }
        return null;
      },
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Address',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an address';
        }
        return null;
      },
    );
  }
}
