import 'package:flutter/material.dart';

class PreferenceSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const PreferenceSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}
