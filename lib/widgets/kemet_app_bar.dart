import 'package:flutter/material.dart';
import 'package:kemet/widgets/kemet_title.dart';

class KemetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const KemetAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 52, 20, 58),
      elevation: 0,
      title: KemetTitle(
        text: title,
        fontSize: 20,
        color: Colors.white,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
