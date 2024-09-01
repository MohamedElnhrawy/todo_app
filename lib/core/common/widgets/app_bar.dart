import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title,this.action1Widget, super.key});

  final String title;
  final Widget? action1Widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      actions: action1Widget != null ? [action1Widget!] : null
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
