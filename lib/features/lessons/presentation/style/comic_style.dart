import 'package:flutter/material.dart';

// TODO: This is a temporary file; it should be split into multiple
// TODO: files once the UI/architectural style approach is finalized.
/// Design tokens for the comic look of the lessons feed:
/// colors, outline/shape metrics, halftone params and motion timings.
/// Keep visual literals here, not scattered across widgets.
abstract class ComicStyle {
  // --- Colors ---------------------------------------------------------------

  /// Near-black ink used for every outline and hard shadow.
  static const ink = Color(0xFF141018);

  static const red = Color(0xFFE62429);
  static const blue = Color(0xFF2B4CC8);
  static const yellow = Color(0xFFF2B705);
  static const green = Color(0xFF1D9E75);
  static const purple = Color(0xFF7F77DD);

  /// Bold, saturated comic primaries used for per-topic accents.
  static const palette = <Color>[red, blue, yellow, green, purple];

  /// The app bar / header accent.
  static const header = blue;

  static const _pageLight = Color(0xFFFFF3D6); // newsprint cream
  static const _pageDark = Color(0xFF14121C);

  // --- Shape & outline ------------------------------------------------------

  static const double panelRadius = 18;
  static const double panelBorder = 3;
  static const double panelPadding = 12;
  static const Offset shadowOffset = Offset(5, 5);

  static const double thumbSize = 72;
  static const double thumbRadius = 14;

  static const double tagRadius = 6;
  static const double tagBorder = 2;
  static const double tagTilt = -0.03; // radians

  // --- Halftone -------------------------------------------------------------

  static const double bgDotGap = 22;
  static const double bgDotRadius = 2.6;
  static const double bgDotOpacity = 0.07;

  static const double thumbDotGap = 6;
  static const double thumbDotRadius = 1.1;
  static const double thumbDotOpacity = 0.12;

  /// Comic-print tint strength laid over thumbnails.
  static const double duotoneOpacity = 0.28;

  // --- Typography -----------------------------------------------------------

  /// Comic-print title style.
  static TextStyle? getCardTitleStyle(TextTheme theme) =>
      theme.titleMedium?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 0.3,
      );

  /// Comic-print tag style.
  static TextStyle? getCardTagStyle(TextTheme theme, {required Color accent}) =>
      TextStyle(
        color: onColor(accent),
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.5,
      );

  // --- Motion ---------------------------------------------------------------

  static const Duration appearDuration = Duration(milliseconds: 100);
  static const int appearStaggerMs = 10;
  static const double appearRise = 26; // px the card rises in
  static const double appearScaleFrom = 0.9;

  static const Duration loaderDuration = Duration(milliseconds: 1000);

  // --- Helpers --------------------------------------------------------------

  /// Outline color: black ink on light, white on dark.
  static Color frame(bool isDark) => isDark ? Colors.white : ink;

  /// Newsprint-cream page on light, deep ink on dark.
  static Color background(bool isDark) => isDark ? _pageDark : _pageLight;

  /// Stable per-topic accent.
  static Color topicColor(String topic) =>
      palette[topic.hashCode.abs() % palette.length];

  /// Readable text color for a filled [color].
  static Color onColor(Color color) =>
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
