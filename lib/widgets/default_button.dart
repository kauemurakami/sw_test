import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.callback,
    required this.text,
    this.width,
    this.height,
    this.margin,
  });
  final VoidCallback callback;
  final String text;
  final double? width, height;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        minWidth: width,
        height: height ?? 42.0,
        color: Colors.deepPurple,
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
