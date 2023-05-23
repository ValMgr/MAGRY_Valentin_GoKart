import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/circuits/circuits.dart';
import 'package:quickalert/quickalert.dart';

class CreateCircuitForm extends StatelessWidget {
  const CreateCircuitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCircuitCubit, CreateCircuitState>(
      listener: (ctx, state) {
        if (state.status == CreateCircuitStatus.failure) {
          QuickAlert.show(
            context: ctx,
            title: 'Oups !',
            text: 'Could not create circuit',
            type: QuickAlertType.error,
            onConfirmBtnTap: () {
              context.read<CreateCircuitCubit>().dismissError();
              Navigator.of(ctx, rootNavigator: true).pop();
            },
          );
        }

        if (state.status == CreateCircuitStatus.success && state.created != null) {
          context.read<CircuitsCubit>().addCircuitToList(state.created!);
          Navigator.of(ctx).pop();
        }
      },
      child: Form(
        child: Column(
          children: [
            const _NameInput(),
            Row(
              children: const [
                Expanded(
                  child: _CornersInput(),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: _LengthInput(),
                ),
              ],
            ),
            const _EmailInput(),
            const _TelephoneInput(),
            const _WebsiteInput(),
            const _LocationInput(),
            const _AddressInput(),
            Row(
              children: const [
                Expanded(
                  child: _CountryInput(),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: _CountryCodeInput(),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: _LatInput(),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: _LngInput(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (context.read<CreateCircuitCubit>().state.status == CreateCircuitStatus.submitting)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => context.read<CreateCircuitCubit>().createCircuit(),
                child: const Text('Create'),
              )
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

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
      onChanged: (value) => context.read<CreateCircuitCubit>().nameChanged(value),
    );
  }
}

class _CornersInput extends StatelessWidget {
  const _CornersInput();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Corners',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number of corners';
        }
        return null;
      },
      onChanged: (value) => context.read<CreateCircuitCubit>().cornersChanged(int.tryParse(value) ?? 0),
    );
  }
}

class _LengthInput extends StatelessWidget {
  const _LengthInput();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Length',
        suffix: Text('m'),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a length';
        }
        return null;
      },
      onChanged: (value) => context.read<CreateCircuitCubit>().lengthChanged(int.tryParse(value) ?? 0),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

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
      onChanged: (value) => context.read<CreateCircuitCubit>().emailChanged(value),
    );
  }
}

class _TelephoneInput extends StatelessWidget {
  const _TelephoneInput();

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
      onChanged: (value) => context.read<CreateCircuitCubit>().telephoneChanged(value),
    );
  }
}

class _WebsiteInput extends StatelessWidget {
  const _WebsiteInput();

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
      onChanged: (value) => context.read<CreateCircuitCubit>().websiteChanged(value),
    );
  }
}

class _LocationInput extends StatelessWidget {
  const _LocationInput();

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
      onChanged: (value) => context.read<CreateCircuitCubit>().locationChanged(value),
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput();

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
      onChanged: (value) => context.read<CreateCircuitCubit>().addressChanged(value),
    );
  }
}

class _LatInput extends StatelessWidget {
  const _LatInput();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Lat',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a lat';
        }
        return null;
      },
      onChanged: (value) => context.read<CreateCircuitCubit>().latChanged(double.tryParse(value) ?? 0.0),
    );
  }
}

class _LngInput extends StatelessWidget {
  const _LngInput();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Lng',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a lng';
        }
        return null;
      },
      onChanged: (value) => context.read<CreateCircuitCubit>().lngChanged(double.tryParse(value) ?? 0.0),
    );
  }
}

class _CountryCodeInput extends StatelessWidget {
  const _CountryCodeInput();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Country code',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a country code';
        }
        return null;
      },
      onChanged: (value) => context.read<CreateCircuitCubit>().countryCodeChanged(value),
    );
  }
}

class _CountryInput extends StatelessWidget {
  const _CountryInput();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Country',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a country';
        }
        return null;
      },
      onChanged: (value) => context.read<CreateCircuitCubit>().countryChanged(value),
    );
  }
}
