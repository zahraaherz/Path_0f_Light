import 'package:flutter/material.dart';

/// Responsive utility for adaptive layouts across devices
class Responsive {
  final BuildContext context;

  Responsive(this.context);

  /// Get screen width
  double get width => MediaQuery.of(context).size.width;

  /// Get screen height
  double get height => MediaQuery.of(context).size.height;

  /// Check if mobile (< 600)
  bool get isMobile => width < 600;

  /// Check if tablet (600-900)
  bool get isTablet => width >= 600 && width < 900;

  /// Check if desktop (> 900)
  bool get isDesktop => width >= 900;

  /// Check if small mobile (< 360)
  bool get isSmallMobile => width < 360;

  /// Check if landscape
  bool get isLandscape => width > height;

  /// Responsive padding
  double get paddingSmall => isMobile ? 12.0 : 16.0;
  double get paddingMedium => isMobile ? 16.0 : 24.0;
  double get paddingLarge => isMobile ? 20.0 : 32.0;

  /// Responsive font sizes
  double get fontSmall => isMobile ? 12.0 : 14.0;
  double get fontMedium => isMobile ? 14.0 : 16.0;
  double get fontLarge => isMobile ? 16.0 : 18.0;
  double get fontXLarge => isMobile ? 20.0 : 24.0;
  double get fontTitle => isMobile ? 24.0 : 32.0;

  /// Responsive icon sizes
  double get iconSmall => isMobile ? 20.0 : 24.0;
  double get iconMedium => isMobile ? 24.0 : 32.0;
  double get iconLarge => isMobile ? 48.0 : 64.0;
  double get iconXLarge => isMobile ? 64.0 : 80.0;

  /// Responsive spacing
  double get spaceSmall => isMobile ? 8.0 : 12.0;
  double get spaceMedium => isMobile ? 16.0 : 20.0;
  double get spaceLarge => isMobile ? 24.0 : 32.0;

  /// Responsive border radius
  double get radiusSmall => isMobile ? 8.0 : 12.0;
  double get radiusMedium => isMobile ? 12.0 : 16.0;
  double get radiusLarge => isMobile ? 16.0 : 20.0;

  /// Max content width for large screens
  double get maxContentWidth => isDesktop ? 800 : double.infinity;

  /// Responsive column count for grids
  int get gridColumns {
    if (isSmallMobile) return 1;
    if (isMobile) return 2;
    if (isTablet) return 3;
    return 4;
  }

  /// Responsive button height
  double get buttonHeight => isMobile ? 48.0 : 56.0;

  /// Responsive card elevation
  double get cardElevation => isMobile ? 2.0 : 4.0;

  /// Get value based on screen size
  T valueWhen<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  /// Wrap content with max width constraint for large screens
  Widget constrainWidth({required Widget child}) {
    if (!isDesktop) return child;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: child,
      ),
    );
  }

  /// Responsive spacing widget
  Widget get verticalSpaceSmall => SizedBox(height: spaceSmall);
  Widget get verticalSpaceMedium => SizedBox(height: spaceMedium);
  Widget get verticalSpaceLarge => SizedBox(height: spaceLarge);

  Widget get horizontalSpaceSmall => SizedBox(width: spaceSmall);
  Widget get horizontalSpaceMedium => SizedBox(width: spaceMedium);
  Widget get horizontalSpaceLarge => SizedBox(width: spaceLarge);

  /// Static method to access from anywhere
  static Responsive of(BuildContext context) => Responsive(context);
}

/// Extension on BuildContext for easy access
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}

/// Responsive breakpoints constants
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

/// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Responsive responsive) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive(context));
  }
}

/// Responsive padding widget
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? mobile;
  final EdgeInsetsGeometry? tablet;
  final EdgeInsetsGeometry? desktop;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    EdgeInsetsGeometry padding;

    if (responsive.isDesktop && desktop != null) {
      padding = desktop!;
    } else if (responsive.isTablet && tablet != null) {
      padding = tablet!;
    } else {
      padding = mobile ?? const EdgeInsets.all(16);
    }

    return Padding(
      padding: padding,
      child: child,
    );
  }
}

/// Responsive card widget
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Card(
      elevation: responsive.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.radiusMedium),
      ),
      color: color,
      child: Padding(
        padding: padding ??
            EdgeInsets.all(responsive.paddingMedium),
        child: child,
      ),
    );
  }
}
