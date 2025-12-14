import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../icon/clickable_icon.dart';

class InputPrimary extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? secondNode;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String labelText;
  String? errorText;
  final String? svgIconRight;
  final GestureTapCallback? svgIconOnTap;
  final String? textRight;
  final GestureTapCallback? textRightOnTap;
  final int maxLength;
  final bool isDigit;
  final bool? enabled;
  final bool? disableBorder;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final double? contentPadding;
  final double height;
  final double fontSize;
  final ValueChanged<String>? onChanged;

  InputPrimary(
      {Key? key,
      this.focusNode,
      this.secondNode,
      required this.keyboardType,
      this.isDigit = false,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.none,
      this.maxLength = 0,
      this.height = 50,
      this.fontSize = 12,
      required this.controller,
      this.errorText,
      this.svgIconRight,
      this.svgIconOnTap,
      this.enabled,
      this.disableBorder,
      this.contentPadding,
      required this.labelText,
      this.textRightOnTap,
      this.textRight,
      this.maxLines,
      this.onChanged})
      : super(key: key);

  @override
  State<InputPrimary> createState() => _InputPrimaryState();
}

class _InputPrimaryState extends State<InputPrimary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            TextField(
                obscureText: widget.obscureText,
                maxLines: widget.maxLines,
                enableSuggestions: false,
                autocorrect: false,
                enabled: widget.enabled,
                textCapitalization: widget.textCapitalization,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                onChanged: (value) {
                  setState(() {
                    widget.errorText = null;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(widget.secondNode);
                },
                inputFormatters: [
                  if (widget.isDigit)
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  if (widget.maxLength != 0)
                    LengthLimitingTextInputFormatter(widget.maxLength),
                ],
                style: TextStyle(
                    fontSize: widget.fontSize,
                    height: 0.8,
                    color: const Color(0xff5b5959),
                    fontFamily: "Poppins-Regular"),
                decoration: InputDecoration(
                    focusedBorder: widget.disableBorder == true
                        ? null
                        : const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffcecccc)),
                          ),
                    border: widget.disableBorder == true
                        ? null
                        : const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffe8e8e8))),
                    errorStyle: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    labelStyle:  TextStyle(
                      fontSize: widget.fontSize,
                      color: Color(0xff202020),
                    ),
                    contentPadding: EdgeInsets.all(widget.contentPadding ?? 10),
                    errorText: widget.errorText,
                    labelText: widget.labelText),
                controller: widget.controller),
            if (widget.svgIconRight != null)
              right(ClickableIcon(
                  svgIcon: widget.svgIconRight!, onTap: widget.svgIconOnTap)),
          ],
        ),
      ),
    );
  }

  right(child) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
          height: 33,
          child: Align(alignment: Alignment.bottomRight, child: child)),
    );
  }
}
