import 'package:expandable_x/expandable.dart';
import 'package:flutter/material.dart';

import 'expandable_theme.dart';

class ScrollOnExpand extends StatefulWidget {
  final Widget child;
  final bool scrollOnExpand;
  final bool scrollOnCollapse;

  final ExpandableThemeData? theme;

  const ScrollOnExpand({
    Key? key,
    required this.child,
    this.scrollOnExpand = true,
    this.scrollOnCollapse = true,
    this.theme,
  }) : super(key: key);

  @override
  _ScrollOnExpandState createState() => _ScrollOnExpandState();
}

class _ScrollOnExpandState extends State<ScrollOnExpand> {
  ExpandableController? _controller;
  int _isAnimating = 0;
  BuildContext? _lastContext;
  ExpandableThemeData? _theme;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController.of(context, rebuildOnChange: false);
    _controller!.addListener(_expandedStateChanged);
  }

  @override
  void didUpdateWidget(ScrollOnExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newController =
        ExpandableController.of(context, rebuildOnChange: false);
    if (newController != _controller) {
      _controller!.removeListener(_expandedStateChanged);
      _controller = newController;
      _controller!.addListener(_expandedStateChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_expandedStateChanged);
  }

  void _animationComplete() {
    _isAnimating--;
    if (_isAnimating == 0 && _lastContext != null && mounted) {
      if ((_controller!.expanded && widget.scrollOnExpand) ||
          (!_controller!.expanded && widget.scrollOnCollapse)) {
        _lastContext
            ?.findRenderObject()
            ?.showOnScreen(duration: _theme!.scrollAnimationDuration!);
      }
    }
  }

  void _expandedStateChanged() {
    if (_theme != null) {
      _isAnimating++;
      Future.delayed(
        _theme!.scrollAnimationDuration! + const Duration(milliseconds: 10),
        _animationComplete,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _lastContext = context;
    _theme = ExpandableThemeData.withDefaults(widget.theme, context);
    return widget.child;
  }
}
