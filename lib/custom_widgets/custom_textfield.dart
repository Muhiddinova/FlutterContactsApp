import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? errorText;
  final bool isPhone;
  const CustomTextField({
    super.key,
    this.hintText = 'Username',
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.errorText,
    this.isPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          height: 55,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,

            inputFormatters: isPhone
                ? [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9+]'),
              ),
            ]
                : [],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,

              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),

              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
            ),
          ),
        ),

        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 6),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
