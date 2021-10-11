import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:duration/duration.dart';

import 'state.dart';

class CookingTimeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showDurationPicker(context),
      icon: Icon(Icons.hourglass_bottom),
      label: Row(children: [
        Text('Cooking time'),
        Spacer(),
        BlocBuilder<CookingTime$, Option<Duration>>(
          builder: (_, optionalDuration) {
            return optionalDuration.fold(
              () => Container(),
              (duration) => Text(
                prettyDuration(duration, abbreviated: true),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ]),
    );
  }

  Future<void> _showDurationPicker(BuildContext context) async {
    final state = context.read<CookingTime$>();

    optionOf(
      await showDurationPicker(
        context: context,
        initialTime: state.state | Duration(minutes: 30),
      ),
    ).forEach(state.present);
  }
}
