import 'package:expandable_x/expandable.dart';
import 'package:expandable_x/src/expandable_theme.dart';
import 'package:flutter/material.dart';

class ExpandableButton extends StatelessWidget {
  final Widget child;
  final ExpandableThemeData theme;

  const ExpandableButton({
    @required this.child,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    final mergedTheme = ExpandableThemeData.withDefaults(theme, context);

    if (mergedTheme.useInkWell) {
      return InkWell(
        onTap: controller.toggle,
        borderRadius: mergedTheme.inkWellBorderRadius,
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
