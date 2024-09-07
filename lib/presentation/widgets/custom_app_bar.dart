import 'package:flutter/material.dart';

import '../utils/responsive/screen_sizes.dart';

class CustomAppBarWidget extends StatelessWidget {
  final double padding;
  final String title;
  final Widget? elevatedButtonWidget;
  final Widget? actionWidget;

  const CustomAppBarWidget(
      {super.key,
      required this.padding,
      required this.title,
      this.actionWidget,
      this.elevatedButtonWidget});

  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(left: padding),
            child: elevatedButtonWidget == null
                ? Container()
                : elevatedButtonWidget!),
        Expanded(
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: screenHeight * 0.023,
                      fontWeight: FontWeight.w600),
                ))),
        actionWidget == null ? Container() : actionWidget!
      ],
    );
  }
}
