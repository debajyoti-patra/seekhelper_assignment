import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/responsive_helpers.dart';

// A responsive grid widget that adapts to different screen sizes
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(context);

        return GridView.builder(
          padding: padding ?? EdgeInsets.all(16.w),
          physics: physics,
          shrinkWrap: shrinkWrap,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing.w,
            mainAxisSpacing: runSpacing.h,
            childAspectRatio: _getChildAspectRatio(context),
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }

  // Determines the number of columns based on screen width
  int _getCrossAxisCount(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) {
      return 4; // Desktop: 4 columns
    } else if (ResponsiveHelper.isTablet(context)) {
      return 3; // Tablet: 3 columns
    } else {
      return 2;
    }
  }

  // Determines the aspect ratio based on screen width
  double _getChildAspectRatio(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) {
      return 0.8; // Desktop cards are more square
    } else if (ResponsiveHelper.isTablet(context)) {
      return 0.85; // Tablet cards are slightly taller
    } else {
      return 0.9; // Mobile cards are taller
    }
  }
}
