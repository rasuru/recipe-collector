import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/ui/theme.dart';

class _SuccessMessageState extends State<SuccessMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: boxDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: colors.text),
          SizedBox(width: 10),
          Text(
            widget.message,
            style: TextStyle(color: colors.text),
          ),
        ],
      ),
    );
  }

  UITheme get theme => context.read<UITheme>();
  UISuccessColors get colors => theme.success.colors;
  final padding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 5,
  );
  BoxShadow get boxShadow => BoxShadow(
        color: colors.shadow,
        blurRadius: 4,
        offset: Offset(0, 2),
      );
  BoxDecoration get boxDecoration => BoxDecoration(
        borderRadius: theme.borderRadius,
        color: colors.background,
        border: Border.all(
          color: colors.border,
          width: theme.borderWidth,
        ),
        boxShadow: [boxShadow],
      );
}

class SuccessMessage extends StatefulWidget {
  final String message;

  SuccessMessage({
    required this.message,
  });

  @override
  State<SuccessMessage> createState() => _SuccessMessageState();
}
