import 'package:flutter/material.dart';
import '../../utils/AppColors.dart';

class TextfieldContainer extends StatefulWidget {
  final String text;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;

  const TextfieldContainer({
    Key? key,
    required this.text,
    required this.prefixIcon,
    this.controller,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<TextfieldContainer> createState() => _TextfieldContainerState();
}

class _TextfieldContainerState extends State<TextfieldContainer> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Appcolors.grayColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Appcolors.grayColor,
              width: 2,
            ),
          ),
          hintText: widget.text,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Appcolors.grayColor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Appcolors.grayColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
