import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';

class ButtonWidget extends StatefulWidget {
  final VoidCallback onTap;
  final double width;
  final double height;
  final String text;
  final Color textColor_1;
  final Color textColor_2;
  final Color backgroundColor_1;

  final Color backgroundColor_2;
  const ButtonWidget({
    Key? key,
    required this.onTap,
    this.width = 241,
    this.height = 46,
    required this.text,
    required this.textColor_1,
    required this.textColor_2,
    required this.backgroundColor_1,
    required this.backgroundColor_2,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ButtonWidgetState();
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  // Color _color = AppColors.neutralColor1;
  // Color _textColor = AppColors.neutralColor8;

  late Color _color;
  late Color _textColor;

  @override
  void initState() {
    _color = widget.backgroundColor_1;
    _textColor = widget.textColor_1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _color = widget.backgroundColor_2;
          _textColor = widget.textColor_2;
        });
      },
      onTapUp: (details) {
        setState(() {
          _color = widget.backgroundColor_1;
          _textColor = widget.textColor_1;
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
            widget.text,
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
