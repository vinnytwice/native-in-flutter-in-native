import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AdatptivePlatformView extends StatelessWidget {
  final String nativeScreen;
  final String viewType;
  final dynamic creationParams;
  final TextDirection? layoutDirection;
  final MessageCodec<dynamic>? creationParamsCodec;
  const AdatptivePlatformView(
      {super.key,
      required this.viewType,
      this.creationParams,
      this.creationParamsCodec,
      this.layoutDirection,
      required this.nativeScreen});

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // return widget on Android.
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        // return widget on iOS.
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  // return Platform.isAndroid
  //     ? AndroidView(
  //         viewType: viewType,
  //         layoutDirection: TextDirection.ltr,
  //         creationParams: creationParams,
  //         creationParamsCodec: const StandardMessageCodec(),
  //       )
  //     : UiKitView(
  //         viewType: viewType,
  //         layoutDirection: TextDirection.ltr,
  //         creationParams: creationParams,
  //         creationParamsCodec: const StandardMessageCodec(),
  //       );
  // }
}
