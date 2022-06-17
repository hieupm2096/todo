import 'package:flutter/material.dart';
import 'package:todo/gen/colors.gen.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  const BasePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      extendBodyBehindAppBar: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}
