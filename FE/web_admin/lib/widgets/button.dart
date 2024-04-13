import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback onTap;
  final double width;
  final double height;

  const ButtonWidget(
      {Key? key, required this.onTap, this.width = 241, this.height = 46})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ButtonWidgetState();
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  Color _color = AppColors.neutralColor1;
  Color _textColor = AppColors.neutralColor8;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _color = Colors.grey[200]!;
          _textColor = AppColors.neutralColor1;
        });
      },
      onTapUp: (details) {
        setState(() {
          _color = AppColors.neutralColor1;
          _textColor = AppColors.neutralColor8;
        });
      },
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: ShapeDecoration(
          color: _color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Center(
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 0.07,
            ),
          ),
        ),
      ),
    );
  }
}
