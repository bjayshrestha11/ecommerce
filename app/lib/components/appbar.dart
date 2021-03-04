import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;
  final Widget flexibleSpace;

  const CustomAppBar({
    Key key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle,
    this.flexibleSpace
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
        flexibleSpace: flexibleSpace,
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}