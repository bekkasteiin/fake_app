import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';

import '../../../core/utils/UI_Helpers.dart';

class PinCode extends StatefulWidget {
  final Text title, subTitle;
  final String error, correctPin;
  final Function onCodeSuccess, onCodeFail;
  final int codeLength;
  TextStyle keyTextStyle = generalFontStyle.copyWith(
          color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
      codeTextStyle =
          generalFontStyle.copyWith(color: Colors.black, fontSize: 25.0),
      errorTextStyle =
          generalFontStyle.copyWith(color: appRedColor, fontSize: 15);
  final bool obscurePin;
  final Color backgroundColor;

  PinCode(
      {this.title,
      this.correctPin = "****", // Default Value, use onCodeFail as onEnteredPin
      this.error = '',
      this.subTitle,
      this.codeLength = 6,
      this.obscurePin = false,
      this.onCodeSuccess,
      this.onCodeFail,
      this.backgroundColor,
      errorTextStyle,
      keyTextStyle,
      codeTextStyle}) {
    this.errorTextStyle = errorTextStyle;
    this.keyTextStyle = keyTextStyle;
    this.codeTextStyle = codeTextStyle;
  }

  PinCodeState createState() => PinCodeState();
}

class PinCodeState extends State<PinCode> {
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Theme.of(context).primaryColor,
      child: Column(children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Expanded(child: Container()),
                CodeView(
                  codeTextStyle: widget.codeTextStyle,
                  code: smsCode,
                  obscurePin: widget.obscurePin,
                  length: widget.codeLength,
                ),
                Expanded(child: Container()),
                widget.subTitle,
                Text(
                  '${widget.error}',
                  style: this.widget.errorTextStyle,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        CustomKeyboard(
          textStyle: widget.keyTextStyle,
          onPressedKey: (key) {
            if (smsCode.length < widget.codeLength) {
              setState(() {
                smsCode = smsCode + key;
              });
            }
            if (smsCode.length == widget.codeLength) {
              if (smsCode == widget.correctPin) {
                widget.onCodeSuccess(smsCode);
              } else {
                widget.onCodeFail(smsCode);
                smsCode = "";
              }
            }
          },
          onBackPressed: () {
            int codeLength = smsCode.length;
            if (codeLength > 0)
              setState(() {
                smsCode = smsCode.substring(0, codeLength - 1);
              });
          },
        ),
      ]),
    );
  }
}

class CustomKeyboard extends StatefulWidget {
  final Function onBackPressed, onPressedKey;
  final TextStyle textStyle;

  CustomKeyboard({
    this.onBackPressed,
    this.onPressedKey,
    this.textStyle,
  });

  CustomKeyboardState createState() => CustomKeyboardState();
}

class CustomKeyboardState extends State<CustomKeyboard> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    var color2 = Color.fromRGBO(243, 242, 240, 1);
    var buttonStyle =
        generalFontStyle.copyWith(fontSize: 35, fontWeight: FontWeight.w400);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("1"),
                    icon: Text(
                      "1",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("2"),
                    icon: Text(
                      "2",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("3"),
                    icon: Text(
                      "3",
                      style: buttonStyle,
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("4"),
                    icon: Text(
                      "4",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("5"),
                    icon: Text(
                      "5",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("6"),
                    icon: Text(
                      "6",
                      style: buttonStyle,
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("7"),
                    icon: Text(
                      "7",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("8"),
                    icon: Text(
                      "8",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("9"),
                    icon: Text(
                      "9",
                      style: buttonStyle,
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 70,
                width: 70,
                child: IconButton(
                  onPressed: () {},
                  icon: Text(
                    "",
                    style: buttonStyle,
                  ),
                ),
              ),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color2,
                  ),
                  child: IconButton(
                    onPressed: () => widget.onPressedKey("0"),
                    icon: Text(
                      "0",
                      style: buttonStyle,
                    ),
                  )),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color2,
                ),
                child: IconButton(
                  onPressed: () => widget.onBackPressed(),
                  icon: Icon(
                    Icons.backspace,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CodeView extends StatefulWidget {
  CodeView({this.code, this.length = 6, this.codeTextStyle, this.obscurePin});

  final String code;
  final int length;
  final bool obscurePin;
  final TextStyle codeTextStyle;

  CodeViewState createState() => CodeViewState();
}

class CodeViewState extends State<CodeView> {
  String getCodeAt(index) {
    if (widget.code == null || widget.code.length < index)
      return "  ";
    else if (widget.obscurePin) {
      return "*";
    } else {
      return widget.code.substring(index - 1, index);
    }
  }

  _getCodeViews() {
    List<Widget> widgets = [];
    for (var i = 0; i < widget.length; i++) {
      var codeAt = getCodeAt(i + 1);
      widgets.add(
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(
                    color: codeAt == '  ' ? appBlueColor : Colors.grey)),
          ),
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          child: Text(
            codeAt,
            textAlign: TextAlign.center,
            style: widget.codeTextStyle,
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _getCodeViews(),
    );
  }
}
