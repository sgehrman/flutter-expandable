import 'package:expandable/expandable.dart';
import 'package:expandable/expandable_theme.dart';
import 'package:flutter/material.dart';

class ExpandableButton extends StatelessWidget {
  final Widget child;

  const ExpandableButton({@required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    final theme = ExpandableThemeData.withDefaults(null, context);

    if (theme.useInkWell) {
      return InkWell(
        onTap: controller.toggle,
        borderRadius: theme.inkWellBorderRadius,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: controller.toggle,
        child: child,
      );
    }
  }
}
