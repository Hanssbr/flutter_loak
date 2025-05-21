// ignore_for_file: provide_deprecation_message

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  const Assets._();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  SvgGenImage get home => SvgGenImage('assets/icons/home-03.svg');
  SvgGenImage get star => SvgGenImage('assets/icons/Icon-1.svg');
  SvgGenImage get flag => SvgGenImage('assets/icons/flag-02.svg');
  SvgGenImage get phone => SvgGenImage('assets/icons/phone.svg');
  SvgGenImage get share => SvgGenImage('assets/icons/Icon-2.svg');
  SvgGenImage get lock => SvgGenImage('assets/icons/Icon-3.svg');
  SvgGenImage get draft => SvgGenImage('assets/icons/Icon-4.svg');
  SvgGenImage get mail => SvgGenImage('assets/icons/Icon-5.svg');
  SvgGenImage get comment => SvgGenImage('assets/icons/Icon-6.svg');
  SvgGenImage get logout => SvgGenImage('assets/icons/Icon-7.svg');
  SvgGenImage get logo => SvgGenImage('assets/icons/GiveBox1.svg');
  SvgGenImage get box => SvgGenImage('assets/icons/proicons_box.svg');
  SvgGenImage get add => SvgGenImage('assets/icons/Vector.svg');
  SvgGenImage get user => SvgGenImage('assets/icons/user-circle.svg');
  SvgGenImage get background => SvgGenImage('assets/icons/Announcement.svg');
  SvgGenImage get favorite => SvgGenImage('assets/icons/favorite.svg');
  SvgGenImage get unfavorite => SvgGenImage('assets/icons/unfavorite.svg');
  SvgGenImage get setting => SvgGenImage('assets/icons/settings-02.svg');
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
