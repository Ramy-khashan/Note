import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController? value;
  final TextInputType? keybordtype;
  final String? hint;
  final Size? size;
  final bool? isPassword;
  final bool? isSecure;
  final Function()? onPress;
  final Function(dynamic val)? validtion;
  const TextFieldItem(
      {Key? key,
      this.isPassword = false,
      this.isSecure = false,
      this.onPress,
      this.validtion,
      this.value,
      this.size,
      this.keybordtype,
      this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validtion!(value),
      obscureText: isPassword! ? isSecure! : false,
      controller: value,
      keyboardType: keybordtype,
      decoration: InputDecoration(
        suffixIcon: isPassword!
            ? IconButton(
                onPressed: onPress,
                icon: Icon(isSecure! ? Icons.visibility_off : Icons.visibility))
            : null,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
    );
  }
}
