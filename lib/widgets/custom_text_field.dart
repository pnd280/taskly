import 'package:flutter/material.dart';
import 'package:taskly/globals.dart';

class InputField extends StatefulWidget {
  dynamic updateCallBack;
  final String? initialValue;
  final bool enabled;

  InputField({
    super.key,
    required this.updateCallBack,
    this.initialValue,
    this.enabled = true,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      enabled: widget.enabled,
      controller: _controller,
      onChanged: (text) {
        widget.updateCallBack(text);
      },
      maxLines: 1,
      decoration: const InputDecoration(
        isDense: true,
        border: InputBorder.none,
      ),
    );
  }
}
