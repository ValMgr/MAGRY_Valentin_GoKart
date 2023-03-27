// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_kart/sessions/create_session/cubit/create_session_cubit.dart';
import 'package:session_repository/session_repository.dart';

class AddLap extends StatefulWidget {
  AddLap({
    super.key,
    required this.cubit,
  });

  final CreateSessionCubit cubit;
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;

  @override
  State<AddLap> createState() => _AddLapState();
}

class _AddLapState extends State<AddLap> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                _minutesPicker(),
                const SizedBox(width: 16),
                _secondsPicker(),
                const SizedBox(width: 16),
                _millisecondsPicker(),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 16),
            _validateButton(context)
          ],
        ),
      ),
    );
  }

  Widget _minutesPicker() {
    return Expanded(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
            onChanged: (value) => widget.minutes = int.tryParse(value) ?? 0,
          ),
          const Text('Minutes'),
        ],
      ),
    );
  }

  Widget _secondsPicker() {
    return Expanded(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
            onChanged: (value) => widget.seconds = int.tryParse(value) ?? 0,
          ),
          const Text('Seconds'),
        ],
      ),
    );
  }

  Widget _millisecondsPicker() {
    return Expanded(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
            onChanged: (value) => widget.milliseconds = int.tryParse(value) ?? 0,
          ),
          const Text('Milliseconds'),
        ],
      ),
    );
  }

  Widget _validateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.cubit.addLap(
          Lap(
            duration: Duration(minutes: widget.minutes, seconds: widget.seconds, milliseconds: widget.milliseconds)
                .inMilliseconds,
          ),
        );
        Navigator.pop(context);
      },
      child: const Text('Validate'),
    );
  }
}
