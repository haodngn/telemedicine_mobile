import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.construction_sharp,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(icon, color: Colors.blue),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
