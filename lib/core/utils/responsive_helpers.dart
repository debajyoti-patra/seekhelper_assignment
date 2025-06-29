import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seekhelper_assignment/app/constants/app_constants.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return AppConstants.mobileGridColumns;
    if (isTablet(context)) return AppConstants.tabletGridColumns;
    return AppConstants.desktopGridColumns;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Size getDesignSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      // Desktop: Use a larger design size to prevent over-scaling
      return const Size(1200, 800);
    } else if (width >= 768) {
      // Tablet: Use tablet design size
      return const Size(768, 1024);
    } else {
      // Mobile: Use original mobile design size
      return const Size(375, 812);
    }
  }

  // Responsive text sizes
  static double getTitleTextSize() => 18.sp;
  static double getBodyTextSize() => 14.sp;
  static double getSubtitleTextSize() => 12.sp;

  // Responsive spacing
  static double getHorizontalPadding() => 16.w;
  static double getVerticalPadding() => 16.h;
  static double getCardPadding() => 12.w;
}
