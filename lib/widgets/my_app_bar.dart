import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    required Key key,
    required this.title,
    required this.centerTitle,
    required this.actions,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final Widget title;
  final bool centerTitle;
  final List<Widget> actions;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => MyAppBarState(
        title: title,
        centerTitle: centerTitle,
        actions: actions,
      );
}

class MyAppBarState extends State<MyAppBar> {
  final Widget title;
  final bool centerTitle;
  final List<Widget> actions;

  MyAppBarState({
    required this.title,
    required this.centerTitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      automaticallyImplyLeading: true,
    );
  }
}
