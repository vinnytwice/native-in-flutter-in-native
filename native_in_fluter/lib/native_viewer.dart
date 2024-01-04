import 'dart:io';
import 'dart:developer' as console;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_in_fluter/adaptive_platform_view.dart';

class NativeViewer extends StatefulWidget {
  final String title;
  final String nativeScreen;
  final Map<String, dynamic> viewParams;
  
  const NativeViewer(
      {super.key,
      required this.title,
      required this.viewParams,
      required this.nativeScreen});

  @override
  State<NativeViewer> createState() => _NativeViewerState();
}

class _NativeViewerState extends State<NativeViewer> {
  late MethodChannel channel; // = const MethodChannel('test_platform_channel');
  @override
  void initState() {
    super.initState();
    channel = const MethodChannel('native_viewer_platform_channel');
    channel.setMethodCallHandler((call) {
      console.log('NativeViewer setMethodCallHandler set');
      switch (call.method) {
        case 'swift_to_flutter':
          console.log(
              'swift_to_flutter received in NativeViewer with args ${call.arguments}');

          break;
        default:
      }
      return call.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic backButton =
        Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back;
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = widget.viewParams;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          // style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(backButton),
            // color: Colors.redAccent,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: AdatptivePlatformView(
        nativeScreen: widget.nativeScreen,
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
