import 'package:expandable/expandable.dart';
import 'package:expandable/expandable_theme.dart';
import 'package:flutter/material.dart';

class ExpandableIcon extends StatefulWidget {
  final ExpandableThemeData _theme;

  ExpandableIcon({
    ExpandableThemeData theme,
  }) : _theme = theme.nullIfEmpty();

  @override
  _ExpandableIconState createState() => _ExpandableIconState();
}

class _ExpandableIconState extends State<ExpandableIcon>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  ExpandableThemeData theme;
  ExpandableController controller;

  @override
  void initState() {
    super.initState();
    final theme = ExpandableThemeData.withDefaults(widget._theme, context,
        rebuildOnChange: false);
    animationController =
        AnimationController(duration: theme.animationDuration, vsync: this);
    animation = animationController.drive(
      Tween<double>(begin: 0.0, end: 1.0).chain(
        CurveTween(curve: theme.sizeCurve),
      ),
    );
    controller = ExpandableController.of(context, rebuildOnChange: false);
    controller.addListener(_expandedStateChanged);
    if (controller.expanded) {
      animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    controller.removeListener(_expandedStateChanged);
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ExpandableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._theme != oldWidget._theme) {
      theme = null;
    }
  }

  void _expandedStateChanged() {
    if (controller.expanded &&
        const [AnimationStatus.dismissed, AnimationStatus.reverse]
            .contains(animationController.status)) {
      animationController.forward();
    } else if (!controller.expanded &&
        const [AnimationStatus.completed, AnimationStatus.forward]
            .contains(animationController.status)) {
      animationController.reverse();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller2 =
        ExpandableController.of(context, rebuildOnChange: false);
    if (controller2 != controller) {
      controller?.removeListener(_expandedStateChanged);
      controller = controller2;
      controller.addListener(_expandedStateChanged);
      if (controller.expanded) {
        animationController.value = 1.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    theme ??= ExpandableThemeData.withDefaults(widget._theme, context);

    return Padding(
      padding: theme.iconPadding,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final showSecondIcon =
              theme.collapseIcon != theme.expandIcon && animation.value >= 0.5;
          return Transform.rotate(
            angle: theme.iconRotationAngle *
                (showSecondIcon ? -(1.0 - animation.value) : animation.value),
            child: Icon(
              showSecondIcon ? theme.collapseIcon : theme.expandIcon,
              color: theme.iconColor,
              size: theme.iconSize,
            ),
          );
        },
      ),
    );
  }
}
