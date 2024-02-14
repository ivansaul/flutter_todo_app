import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final void Function() onTap;
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Material(
        // color: const Color(0xff00F0FF),
        color: color,
        child: InkWell(
          // onTap: () {},
          onTap: onTap,
          onHover: (value) {},
          child: SizedBox(
            height: 33,
            width: 33,
            child: icon,
          ),
        ),
      ),
    );
  }
}
