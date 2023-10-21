import 'package:flutter/material.dart';

class PageBase extends StatelessWidget {
  final Widget child;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final Widget? extraActionButton;
  final Widget? leadingButton;

  const PageBase(
      {required this.title,
      required this.child,
      this.extraActionButton,
      this.floatingActionButton,
      this.leadingButton,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: leadingButton,
          toolbarHeight: 80,
          title: Text(title),
        ),
        body: child,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
