/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Satoshi-Medium.otf
  String get satoshiMedium => 'assets/fonts/Satoshi-Medium.otf';

  /// List of all assets
  List<String> get values => [satoshiMedium];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.svg
  String get aSvg => 'assets/icons/.svg';

  /// File path: assets/icons/Discovery 1.svg
  String get discovery1 => 'assets/icons/Discovery 1.svg';

  /// File path: assets/icons/Doalipa.svg
  String get doalipaSvg => 'assets/icons/Doalipa.svg';

  /// File path: assets/icons/doalipa.png
  AssetGenImage get doalipaPng =>
      const AssetGenImage('assets/icons/doalipa.png');

  /// File path: assets/icons/Heart 1.svg
  String get heart1 => 'assets/icons/Heart 1.svg';

  /// File path: assets/icons/Heart.svg
  String get heart => 'assets/icons/Heart.svg';

  /// File path: assets/icons/Heart3.svg
  String get heart3 => 'assets/icons/Heart3.svg';

  /// File path: assets/icons/Home 2.svg
  String get home2 => 'assets/icons/Home 2.svg';

  /// File path: assets/icons/Home.svg
  String get home => 'assets/icons/Home.svg';

  /// File path: assets/icons/Left.svg
  String get left => 'assets/icons/Left.svg';

  /// File path: assets/icons/Moon.svg
  String get moon => 'assets/icons/Moon.svg';

  /// File path: assets/icons/Play.svg
  String get play => 'assets/icons/Play.svg';

  /// File path: assets/icons/Profile 1.svg
  String get profile1 => 'assets/icons/Profile 1.svg';

  /// File path: assets/icons/Rectangle 8 (2).png
  AssetGenImage get rectangle82 =>
      const AssetGenImage('assets/icons/Rectangle 8 (2).png');

  /// File path: assets/icons/Rectangle 9 (1).png
  AssetGenImage get rectangle91 =>
      const AssetGenImage('assets/icons/Rectangle 9 (1).png');

  /// File path: assets/icons/Rectangle 9 (2).png
  AssetGenImage get rectangle92 =>
      const AssetGenImage('assets/icons/Rectangle 9 (2).png');

  /// File path: assets/icons/Sun 1.svg
  String get sun1 => 'assets/icons/Sun 1.svg';

  /// File path: assets/icons/Vector (4).svg
  String get vector4 => 'assets/icons/Vector (4).svg';

  /// File path: assets/icons/Vector (6).svg
  String get vector6 => 'assets/icons/Vector (6).svg';

  /// File path: assets/icons/Vector.svg
  String get vector => 'assets/icons/Vector.svg';

  /// File path: assets/icons/apple.svg
  String get apple => 'assets/icons/apple.svg';

  /// File path: assets/icons/ariana.png
  AssetGenImage get arianaPng => const AssetGenImage('assets/icons/ariana.png');

  /// File path: assets/icons/ariana.svg
  String get arianaSvg => 'assets/icons/ariana.svg';

  /// File path: assets/icons/banner.svg
  String get banner => 'assets/icons/banner.svg';

  /// File path: assets/icons/banner2.svg
  String get banner2 => 'assets/icons/banner2.svg';

  /// File path: assets/icons/google.svg
  String get google => 'assets/icons/google.svg';

  /// File path: assets/icons/registerOrSignUp.svg
  String get registerOrSignUp => 'assets/icons/registerOrSignUp.svg';

  /// List of all assets
  List<dynamic> get values => [
    aSvg,
    discovery1,
    doalipaSvg,
    doalipaPng,
    heart1,
    heart,
    heart3,
    home2,
    home,
    left,
    moon,
    play,
    profile1,
    rectangle82,
    rectangle91,
    rectangle92,
    sun1,
    vector4,
    vector6,
    vector,
    apple,
    arianaPng,
    arianaSvg,
    banner,
    banner2,
    google,
    registerOrSignUp,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
