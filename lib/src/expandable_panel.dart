import 'package:expandable_x/expandable.dart';
import 'package:expandable_x/src/expandable_icon.dart';
import 'package:expandable_x/src/expandable_theme.dart';
import 'package:expandable_x/src/expandable_theme_notifier.dart';
import 'package:flutter/material.dart';

import 'expandable_button.dart';

typedef ExpandableBuilder = Widget Function(
  BuildContext context,
  Widget collapsed,
  Widget expanded,
);

class ExpandablePanel extends StatelessWidget {
  final Widget header;
  final Widget collapsed;
  final Widget expanded;
  final ExpandableBuilder builder;
  final Function? onExpand;
  final ExpandableController? controller;
  final ExpandableThemeData? _theme;

  ExpandablePanel({
    required this.header,
    required this.collapsed,
    required this.expanded,
    this.controller,
    required this.builder,
    this.onExpand,
    ExpandableThemeData? theme,
  }) : _theme = ExpandableThemeData.combine(const ExpandableThemeData(), theme)
            .nullIfEmpty();

  @override
  Widget build(BuildContext context) {
    final theme = ExpandableThemeData.withDefaults(_theme, context);

    Widget? buildHeaderRow() {
      CrossAxisAlignment? calculateHeaderCrossAxisAlignment() {
        switch (theme.headerAlignment) {
          case ExpandablePanelHeaderAlignment.top:
            return CrossAxisAlignment.start;
          case ExpandablePanelHeaderAlignment.center:
            return CrossAxisAlignment.center;
          case ExpandablePanelHeaderAlignment.bottom:
            return CrossAxisAlignment.end;
          default:
            return CrossAxisAlignment.center;
        }
      }

      Widget wrapWithExpandableButton(
          {required Widget widget, required bool wrap}) {
        return wrap
            ? ExpandableButton(
                theme: _theme,
                child: widget,
              )
            : widget;
      }

      if (!theme.hasIcon!) {
        return wrapWithExpandableButton(
            widget: header, wrap: theme.tapHeaderToExpand!);
      } else {
        final rowChildren = <Widget>[
          Expanded(
            child: header,
          ),
          wrapWithExpandableButton(
              widget: ExpandableIcon(theme: theme),
              wrap: !theme.tapHeaderToExpand!)
        ];
        return wrapWithExpandableButton(
          widget: Row(
            crossAxisAlignment: calculateHeaderCrossAxisAlignment()!,
            children: theme.iconPlacement == ExpandablePanelIconPlacement.right
                ? rowChildren
                : rowChildren.reversed.toList(),
          ),
          wrap: theme.tapHeaderToExpand!,
        );
      }
    }

    Widget buildBody() {
      Widget wrapBody(Widget? child, {required bool tap}) {
        Alignment? calcAlignment() {
          switch (theme.bodyAlignment) {
            case ExpandablePanelBodyAlignment.left:
              return Alignment.topLeft;
            case ExpandablePanelBodyAlignment.center:
              return Alignment.topCenter;
            case ExpandablePanelBodyAlignment.right:
              return Alignment.topRight;
            default:
              assert(false);
              return null;
          }
        }

        final widget = Align(
          alignment: calcAlignment()!,
          child: child,
        );

        if (!tap) {
          return widget;
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (onExpand != null) {
              onExpand!();
            }

            final controller = ExpandableController.of(context);
            controller?.toggle();
          },
          child: widget,
        );
      }

      return builder(
        context,
        wrapBody(collapsed, tap: theme.tapBodyToExpand!),
        wrapBody(
          expanded,
          tap: theme.tapBodyToCollapse!,
        ),
      );
    }

    Widget buildWithHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: theme.headerBackgroundColor,
            ),
            child: buildHeaderRow(),
          ),
          buildBody(),
        ],
      );
    }

    final panel = buildWithHeader();

    if (controller != null) {
      return ExpandableNotifier(
        controller: controller,
        child: panel,
      );
    } else {
      final controller =
          ExpandableController.of(context, rebuildOnChange: false);
      if (controller == null) {
        return ExpandableNotifier(
          controller: controller,
          child: panel,
        );
      } else {
        return panel;
      }
    }
  }
}
