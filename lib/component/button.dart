import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  const ButtonItem({Key? key, this.size, this.name, this.onPress})
      : super(key: key);
  final Size? size;
  final String? name;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ElevatedButton(
        child: Text(
          name!,
          style: TextStyle(fontSize: size!.shortestSide * .055),
        ),
        onPressed: onPress,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: size!.shortestSide * .04),
        )),
      ),
    );
  }
}
