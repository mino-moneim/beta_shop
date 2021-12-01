import 'package:flutter/material.dart';

Widget myTextFromField({
  TextEditingController? controller,
  TextInputType? type,
  dynamic onSubmit,
  bool scurePassword = false,
  String? hint,
  dynamic validator,
  IconData? prefixIcon,
  IconData? suffixIcon,
  dynamic suffixPressed,
  TextInputAction? textInputAction,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: scurePassword,
    onFieldSubmitted: onSubmit,
    validator: validator,
    textInputAction: textInputAction,
    style: const TextStyle(
      color: Colors.purpleAccent,
    ),
    decoration: InputDecoration(
      label: Text(
        hint!,
        style: const TextStyle(
          color: Colors.purpleAccent,
        ),
      ),
      hintStyle: const TextStyle(
        color: Colors.purpleAccent,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purpleAccent,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purpleAccent,
        ),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.purpleAccent,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          suffixIcon,
          color: Colors.purpleAccent,
        ),
        onPressed: suffixPressed,
      ),
    ),
    cursorColor: Colors.purpleAccent,
  );
}
