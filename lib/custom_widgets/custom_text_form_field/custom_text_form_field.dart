import 'package:flutter/material.dart';
import 'package:heros_demo/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final Color fillColor;
  final TextStyle hintStyle;
  final bool hasHorizontalMargin;
  final bool enabled;
  final String initialValue;
  final String hintTxt;
  final TextInputType inputData;
  final bool isPassword;
  final Function validationFunc;
  final Function onChangedFunc;
  final bool suffixIconIsImage;
  final Widget prefix;
  final Widget suffixIcon;
  final String suffixIconImagePath;
  final int maxLength;
  final int maxLines;
  final Widget prefixIcon;
  final bool prefixIconIsImage;
  final String prefixIconImagePath;
  final String labelText;
  final bool expands;
  final bool enableBorder;
  final TextEditingController controller;
  final Function onEditingCompleteFunc;

  CustomTextFormField(
      {this.hintTxt,
      this.hintStyle,
      this.fillColor,
      this.inputData,
      this.hasHorizontalMargin: true,
      this.isPassword: false,
      this.validationFunc,
      this.onChangedFunc,
      this.enableBorder: false,
      this.initialValue,
      this.onEditingCompleteFunc,
      this.expands = false,
      this.suffixIcon,
      this.maxLength,
      this.enabled: true,
      this.maxLines,
      this.prefixIconIsImage: false,
      this.suffixIconIsImage: false,
      this.prefixIcon,
      this.labelText,
      this.controller,
      this.suffixIconImagePath,
      this.prefixIconImagePath,
      this.prefix});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  Widget _buildTextFormField() {
    return TextFormField(
      onEditingComplete: widget.onEditingCompleteFunc,
      expands: widget.expands,
      controller: widget.controller,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor != null ? widget.fillColor : Colors.white,
          labelText: widget.labelText,
          border: widget.enableBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: BorderSide(
                      color: _focusNode.hasFocus ? mainAppColor : Colors.grey),
                )
              : null,
          focusColor: Colors.purple[700],
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          suffixIcon: !widget.suffixIconIsImage
              ? widget.suffixIcon
              : _focusNode.hasFocus
                  ? Image.asset(
                      widget.suffixIconImagePath,
                      color: mainAppColor,
                      height: 25,
                      width: 25,
                    )
                  : Image.asset(
                      widget.suffixIconImagePath,
                      color: Colors.grey,
                      height: 25,
                      width: 25,
                    ),
          prefix: widget.prefix,
          prefixIcon: !widget.prefixIconIsImage
              ? widget.prefixIcon
              : _focusNode.hasFocus
                  ? Image.asset(
                      widget.prefixIconImagePath,
                      color: mainAppColor,
                      height: 25,
                      width: 25,
                    )
                  : Image.asset(
                      widget.prefixIconImagePath,
                      color: hintColor,
                      height: 25,
                      width: 25,
                    ),
          hintText: widget.hintTxt,
          errorStyle: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: widget.hintStyle == null
              ? TextStyle(
                  color: _focusNode.hasFocus ? mainAppColor : hintColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)
              : widget.hintStyle,
          suffix: widget.isPassword
              ? InkWell(
                  onTap: () => setState(() {
                    _obsecureText = !_obsecureText;
                  }),
                  child: Icon(
                    _obsecureText ? Icons.remove_red_eye : Icons.visibility_off,
                    color: _focusNode.hasFocus ? mainAppColor : hintColor,
                    size: 20,
                  ),
                )
              : SizedBox(
                  height: 10,
                )),
      keyboardType: widget.inputData,
      obscureText: widget.isPassword ? _obsecureText : false,
      validator: widget.validationFunc,
      onChanged: widget.onChangedFunc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          margin: EdgeInsets.symmetric(
              horizontal:
                  widget.hasHorizontalMargin ? constraints.maxWidth * 0.07 : 0),
          child: _buildTextFormField());
    });
  }
}
