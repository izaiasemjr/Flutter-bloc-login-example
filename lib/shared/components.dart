import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InputLogin extends StatefulWidget {
  InputLogin({
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.textEditingController,
    this.validator,
    this.focusNode,
  });
  final focusNode;
  final validator;
  final prefixIcon;
  final hint;
  final keyboardType;
  final textEditingController;
  final obscureText;

  @override
  _InputLoginState createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool showPassword = false;

  String _validator(value) {
    if (widget.obscureText) {
      if (value == null || value.isEmpty) {
        return 'type a ${widget.hint}';
      }
      return null;
    } else {
      if (value == null || value.isEmpty) {
        return 'type a ${widget.hint}';
      }
      return null;
    }
  }

  handleShowPass() {
    return IconButton(
      icon: showPassword
          ? Icon(Icons.remove_red_eye, color: Colors.white, size: 20)
          : Icon(Icons.visibility_off, color: Colors.white, size: 20),
      color: ColorsCustom.loginScreenDown,
      onPressed: () {
        setState(() => showPassword = !showPassword);
      },
    );
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: DecorationsLogin.borderInput,
      height: (size.height) * 0.056,
      // /width: (size.width) * 0.74,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Icon(widget.prefixIcon, color: Colors.white),
            Flexible(
              child: TextFormField(
                focusNode: widget.focusNode,
                validator: widget.validator ?? _validator,
                controller: widget.textEditingController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  errorStyle: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black38,
                    height: -1,
                  ),
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.white38),
                  // labelText: widget.hint,
                  // labelStyle: TextStyle(fontSize: 15.0, color: Colors.white54),
                ),
                obscureText: widget.obscureText ? !showPassword : false,
                keyboardType: widget.keyboardType,
              ),
            ),
            widget.obscureText ? handleShowPass() : Container(),
          ],
        ),
      ),
    );
  }
}

class ButtonLogin extends MaterialButton {
  ButtonLogin({
    this.backgroundColor = Colors.transparent,
    this.borderColor = ColorsCustom.loginScreenMiddle,
    this.label = 'OK',
    this.labelColor = ColorsCustom.loginScreenUp,
    this.mOnPressed,
    this.isLoading = false,
    this.height,
    this.minWidth,
  });
  final minWidth;
  final height;
  final bool isLoading;
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final Color labelColor;
  final VoidCallback mOnPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonTheme(
      minWidth: minWidth ?? size.width * 0.316,
      height: height ?? size.height * 0.053,
      child: RaisedButton(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: this.borderColor)),
        color: backgroundColor,
        child: isLoading
            ? FittedBox(
                fit: BoxFit.cover,
                child: Row(
                  children: <Widget>[
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: labelColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SpinKitCircle(
                      color: ColorsCustom.loginScreenUp,
                    ),
                  ],
                ),
              )
            : Text(
                label,
                style: TextStyle(
                    fontSize: 20.0,
                    color: labelColor,
                    fontWeight: FontWeight.bold),
              ),
        onPressed: mOnPressed,
      ),
    );
  }
}

class Alert extends AlertDialog {
  final String titleText;
  final String contentText;

  Alert({this.titleText, this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: Text(titleText),
      content: Text(contentText),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ok'),
        )
      ],
    );
  }
}
