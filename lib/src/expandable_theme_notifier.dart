import 'package:expandable_x/expandable.dart';
import 'package:expandable_x/src/expandable_theme.dart';
import 'package:flutter/material.dart';

class ExpandableNotifier extends StatefulWidget {
  final ExpandableController controller;
  final Widget child;

  const ExpandableNotifier({
    Key key,
    @required this.controller,
    @required this.child,
  }) : super(key: key);

  @override
  _ExpandableNotifierState createState() => _ExpandableNotifierState();
}

class _ExpandableNotifierState extends State<ExpandableNotifier> {
  ExpandableThemeData theme;

  @override
  Widget build(BuildContext context) {
    final cn = ExpandableControllerNotifier(
        controller: widget.controller, child: widget.child);
    return theme != null
        ? ExpandableThemeNotifier(themeData: theme, child: cn)
        : cn;
  }
}

class ExpandableControllerNotifier
    extends InheritedNotifier<ExpandableController> {
  const ExpandableControllerNotifier(
      {@required ExpandableController controller, @required Widget child})
      : super(notifier: controller, child: child);
}

class ExpandableThemeNotifier extends InheritedWidget {
  final ExpandableThemeData themeData;

  const ExpandableThemeNotifier(
      {@required this.themeData, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return !(oldWidget is ExpandableThemeNotifier &&
        oldWidget.themeData == themeData);
  }
}
