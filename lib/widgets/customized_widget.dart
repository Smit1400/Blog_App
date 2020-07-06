import 'package:blog_app/widgets/constants/constants.dart';
import 'package:flutter/material.dart';


class CustomizedWidget extends StatelessWidget {
  final Widget child;

  const CustomizedWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9BAFC9),
            offset: Offset(8, 6),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-8, -6),
            blurRadius: 10,
          )
        ],
      ),
      child: child,
    );
  }
}
