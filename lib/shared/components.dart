import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({
    super.key,
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.textEditingController,
    this.validator,
    this.focusNode,
  });
  final dynamic focusNode;
  final dynamic validator;
  final dynamic prefixIcon;
  final dynamic hint;
  final dynamic keyboardType;
  final dynamic textEditingController;
  final dynamic obscureText;

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool showPassword = false;

  String _validator(value) {
    if (widget.obscureText) {
      if (value == null || value.isEmpty) {
        return 'type a ${widget.hint}';
      }
      return "";
    } else {
      if (value == null || value.isEmpty) {
        return 'type a ${widget.hint}';
      }
      return "";
    }
  }

  handleShowPass() {
    return IconButton(
      icon: showPassword
          ? const Icon(Icons.remove_red_eye, color: Colors.white, size: 20)
          : const Icon(Icons.visibility_off, color: Colors.white, size: 20),
      color: ColorsCustom.loginScreenDown,
      onPressed: () {
        setState(() => showPassword = !showPassword);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: DecorationsLogin.borderInput,
      height: (size.height) * 0.056,
      // /width: (size.width) * 0.74,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Icon(widget.prefixIcon, color: Colors.white),
            Flexible(
              child: TextFormField(
                focusNode: widget.focusNode,
                validator: widget.validator ?? _validator,
                controller: widget.textEditingController,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  errorStyle: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black38,
                    height: -1,
                  ),
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle:
                      const TextStyle(fontSize: 16.0, color: Colors.white38),
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
  const ButtonLogin({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.borderColor = ColorsCustom.loginScreenMiddle,
    this.label = 'OK',
    this.labelColor = ColorsCustom.loginScreenUp,
    this.isLoading = false,
    required super.onPressed,
  });
  final bool isLoading;
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonTheme(
      minWidth: minWidth ?? size.width * 0.316,
      height: height ?? size.height * 0.053,
      child: RaisedButton(
        mElevation: 0.0,
        mShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: borderColor)),
        onPressed: onPressed,
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
                    const SpinKitCircle(color: ColorsCustom.loginScreenUp),
                  ],
                ),
              )
            : Text(label,
                style: TextStyle(
                    fontSize: 20.0,
                    color: labelColor,
                    fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Alert extends AlertDialog {
  final String titleText;
  final String contentText;

  const Alert({super.key, required this.titleText, required this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: Text(titleText),
      content: Text(contentText),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        )
      ],
    );
  }
}

class RaisedButton extends MaterialButton {
  final RoundedRectangleBorder? mShape;
  final double? mElevation;

  const RaisedButton({
    super.key,
    this.mElevation,
    this.mShape,
    required super.onPressed,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ColorsCustom.loginScreenMiddle),
        elevation: MaterialStateProperty.all(mElevation ?? 1),
        shape: MaterialStateProperty.all(mShape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            )),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: child,
      ),
    );
  }
}
