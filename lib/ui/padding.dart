import 'package:flutter/material.dart';

const noPadding = EdgeInsets.zero;

EdgeInsets paddingOf({
  double all = 0,
  double? vertical,
  double? horizontal,
  double? top,
  double? bottom,
  double? left,
  double? right,
}) {
  return EdgeInsets.only(
    top: top ?? vertical ?? all,
    bottom: bottom ?? vertical ?? all,
    left: left ?? horizontal ?? all,
    right: right ?? horizontal ?? all,
  );
}
