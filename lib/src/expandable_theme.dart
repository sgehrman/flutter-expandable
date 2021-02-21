import 'dart:math' as math;
import 'package:expandable_x/src/expandable_theme_notifier.dart';
import 'package:flutter/material.dart';

enum ExpandablePanelIconPlacement {
  left,
  right,
}

enum ExpandablePanelHeaderAlignment {
  top,
  center,
  bottom,
}

enum ExpandablePanelBodyAlignment {
  left,
  center,
  right,
}

class ExpandableThemeData {
  static const ExpandableThemeData defaults = ExpandableThemeData(
    iconColor: Colors.black54,
    useInkWell: true,
    inkWellBorderRadius: BorderRadius.zero,
    animationDuration: Duration(milliseconds: 300),
    scrollAnimationDuration: Duration(milliseconds: 300),
    crossFadePoint: 0.5,
    fadeCurve: Curves.linear,
    sizeCurve: Curves.fastOutSlowIn,
    alignment: Alignment.topLeft,
    headerAlignment: ExpandablePanelHeaderAlignment.top,
    bodyAlignment: ExpandablePanelBodyAlignment.left,
    iconPlacement: ExpandablePanelIconPlacement.right,
    tapHeaderToExpand: true,
    tapBodyToExpand: false,
    tapBodyToCollapse: false,
    hasIcon: true,
    iconSize: 24.0,
    iconPadding: EdgeInsets.all(8.0),
    iconRotationAngle: -math.pi,
    expandIcon: Icons.expand_more,
    collapseIcon: Icons.expand_more,
    headerBackgroundColor: Colors.transparent,
  );

  static const ExpandableThemeData empty = ExpandableThemeData();

  final Color iconColor;
  final bool useInkWell;
  final Duration animationDuration;
  final Duration scrollAnimationDuration;
  final double crossFadePoint;
  final AlignmentGeometry alignment;
  final Curve fadeCurve;
  final Curve sizeCurve;
  final ExpandablePanelHeaderAlignment headerAlignment;
  final ExpandablePanelBodyAlignment bodyAlignment;
  final ExpandablePanelIconPlacement iconPlacement;
  final bool tapHeaderToExpand;
  final bool tapBodyToExpand;
  final bool tapBodyToCollapse;
  final Color headerBackgroundColor;
  final bool hasIcon;
  final double iconSize;
  final EdgeInsets iconPadding;
  final double iconRotationAngle;
  final IconData expandIcon;
  final IconData collapseIcon;
  final BorderRadius inkWellBorderRadius;

  const ExpandableThemeData({
    this.iconColor,
    this.useInkWell,
    this.animationDuration,
    this.scrollAnimationDuration,
    this.crossFadePoint,
    this.fadeCurve,
    this.sizeCurve,
    this.alignment,
    this.headerAlignment,
    this.bodyAlignment,
    this.iconPlacement,
    this.tapHeaderToExpand,
    this.tapBodyToExpand,
    this.tapBodyToCollapse,
    this.hasIcon,
    this.iconSize,
    this.iconPadding,
    this.iconRotationAngle,
    this.expandIcon,
    this.collapseIcon,
    this.inkWellBorderRadius,
    this.headerBackgroundColor,
  });

  factory ExpandableThemeData.combine(
    ExpandableThemeData theme,
    ExpandableThemeData defaults,
  ) {
    if (defaults == null || defaults.isEmpty()) {
      return theme ?? empty;
    } else if (theme == null || theme.isEmpty()) {
      return defaults ?? empty;
    } else if (theme.isFull()) {
      return theme;
    } else {
      return ExpandableThemeData(
        iconColor: theme.iconColor ?? defaults.iconColor,
        useInkWell: theme.useInkWell ?? defaults.useInkWell,
        inkWellBorderRadius:
            theme.inkWellBorderRadius ?? defaults.inkWellBorderRadius,
        animationDuration:
            theme.animationDuration ?? defaults.animationDuration,
        scrollAnimationDuration:
            theme.scrollAnimationDuration ?? defaults.scrollAnimationDuration,
        crossFadePoint: theme.crossFadePoint ?? defaults.crossFadePoint,
        fadeCurve: theme.fadeCurve ?? defaults.fadeCurve,
        sizeCurve: theme.sizeCurve ?? defaults.sizeCurve,
        alignment: theme.alignment ?? defaults.alignment,
        headerAlignment: theme.headerAlignment ?? defaults.headerAlignment,
        bodyAlignment: theme.bodyAlignment ?? defaults.bodyAlignment,
        iconPlacement: theme.iconPlacement ?? defaults.iconPlacement,
        tapHeaderToExpand:
            theme.tapHeaderToExpand ?? defaults.tapHeaderToExpand,
        tapBodyToExpand: theme.tapBodyToExpand ?? defaults.tapBodyToExpand,
        tapBodyToCollapse:
            theme.tapBodyToCollapse ?? defaults.tapBodyToCollapse,
        hasIcon: theme.hasIcon ?? defaults.hasIcon,
        iconSize: theme.iconSize ?? defaults.iconSize,
        iconPadding: theme.iconPadding ?? defaults.iconPadding,
        iconRotationAngle:
            theme.iconRotationAngle ?? defaults.iconRotationAngle,
        expandIcon: theme.expandIcon ?? defaults.expandIcon,
        collapseIcon: theme.collapseIcon ?? defaults.collapseIcon,
        headerBackgroundColor:
            theme.headerBackgroundColor ?? defaults.headerBackgroundColor,
      );
    }
  }

  double get collapsedFadeStart =>
      crossFadePoint < 0.5 ? 0 : (crossFadePoint * 2 - 1);

  double get collapsedFadeEnd => crossFadePoint < 0.5 ? 2 * crossFadePoint : 1;

  double get expandedFadeStart =>
      crossFadePoint < 0.5 ? 0 : (crossFadePoint * 2 - 1);

  double get expandedFadeEnd => crossFadePoint < 0.5 ? 2 * crossFadePoint : 1;

  ExpandableThemeData nullIfEmpty() {
    return isEmpty() ? null : this;
  }

  bool isEmpty() {
    return this == empty;
  }

  bool isFull() {
    return iconColor != null &&
        useInkWell != null &&
        inkWellBorderRadius != null &&
        animationDuration != null &&
        scrollAnimationDuration != null &&
        crossFadePoint != null &&
        fadeCurve != null &&
        sizeCurve != null &&
        alignment != null &&
        headerAlignment != null &&
        bodyAlignment != null &&
        iconPlacement != null &&
        tapHeaderToExpand != null &&
        tapBodyToExpand != null &&
        tapBodyToCollapse != null &&
        hasIcon != null &&
        iconRotationAngle != null &&
        expandIcon != null &&
        headerBackgroundColor != null &&
        collapseIcon != null;
  }

  @override
  bool operator ==(dynamic o) {
    if (identical(this, o)) {
      return true;
    } else if (o is ExpandableThemeData) {
      return iconColor == o.iconColor &&
          useInkWell == o.useInkWell &&
          inkWellBorderRadius == o.inkWellBorderRadius &&
          animationDuration == o.animationDuration &&
          scrollAnimationDuration == o.scrollAnimationDuration &&
          crossFadePoint == o.crossFadePoint &&
          fadeCurve == o.fadeCurve &&
          sizeCurve == o.sizeCurve &&
          alignment == o.alignment &&
          headerAlignment == o.headerAlignment &&
          bodyAlignment == o.bodyAlignment &&
          iconPlacement == o.iconPlacement &&
          tapHeaderToExpand == o.tapHeaderToExpand &&
          tapBodyToExpand == o.tapBodyToExpand &&
          tapBodyToCollapse == o.tapBodyToCollapse &&
          hasIcon == o.hasIcon &&
          iconRotationAngle == o.iconRotationAngle &&
          expandIcon == o.expandIcon &&
          headerBackgroundColor == o.headerBackgroundColor &&
          collapseIcon == o.collapseIcon;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return 0;
  }

  static ExpandableThemeData of(BuildContext context,
      {bool rebuildOnChange = true}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<ExpandableThemeNotifier>()
        : context.findAncestorWidgetOfExactType<ExpandableThemeNotifier>();
    return notifier?.themeData ?? defaults;
  }

  factory ExpandableThemeData.withDefaults(
      ExpandableThemeData theme, BuildContext context,
      {bool rebuildOnChange = true}) {
    if (theme != null && theme.isFull()) {
      return theme;
    } else {
      return ExpandableThemeData.combine(
        ExpandableThemeData.combine(
          theme,
          of(context, rebuildOnChange: rebuildOnChange),
        ),
        defaults,
      );
    }
  }
}

class ExpandableTheme extends StatelessWidget {
  final ExpandableThemeData data;
  final Widget child;

  const ExpandableTheme({@required this.data, @required this.child});

  @override
  Widget build(BuildContext context) {
    final ExpandableThemeNotifier n =
        context.dependOnInheritedWidgetOfExactType<ExpandableThemeNotifier>();
    return ExpandableThemeNotifier(
      themeData: ExpandableThemeData.combine(data, n?.themeData),
      child: child,
    );
  }
}
