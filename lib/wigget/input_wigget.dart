import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String) onChanged;
  final Icon? icon;
  final VoidCallback? onIconPressed;

  const InputWidget({
    super.key,
    required this.label,
    required this.obscureText,
    required this.onChanged,
    required this.icon,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: icon != null
              ? GestureDetector(
                  onTap: onIconPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: icon,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
