import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {super.key,
      this.hintText,
      this.onChange,
      this.obsecureText = false,
      this.passwordIcon = false});

  final String? hintText;
  Function(String)? onChange;
  bool obsecureText;
  final bool passwordIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return "field is required";
        }
      },
      obscureText: widget.obsecureText,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.passwordIcon
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obsecureText = !widget.obsecureText;
                  });
                },
                icon: Icon(widget.obsecureText
                    ? Icons.visibility_off
                    : Icons.visibility))
            : null,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
      ),
    );
  }
}
