import 'dart:developer' as console;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_in_fluter/native_viewer.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MethodChannel channel; // = const MethodChannel('test_platform_channel');
  // late EventChannel eventChannel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // eventChannel = EventChannel('eventChannelDemo');
    // eventChannel.receiveBroadcastStream().map((event) => event);
    channel = const MethodChannel('native_viewer_platform_channel');
    channel.setMethodCallHandler((call) {
      // console.log('Home setMethodCallHandler set');
      switch (call.method) {
        case 'swift_to_flutter':
          console.log(
              'swift_to_flutter received in Home with args ${call.arguments}');

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

    Map<String, dynamic> params = <String, dynamic>{};
    String nativeViewTitle = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
            icon: Icon(backButton),
            color: Colors.redAccent,
            onPressed: () {
              channel.invokeMethod('close');
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'Screen A';
                params.clear();
                params = {
                  'screen': 'viewController',
                  'param 1': 'vc button A',
                  'param 2': 'vc button B'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
                // callNative();
              },
              child: const Text(
                'Navigate to ios screen A',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'Screen B';
                params.clear();
                params = {
                  'screen': 'viewController2',
                  'param 1': 'vc2 button A',
                  'param 2': 'vc2 button B'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
                // callNative();
              },
              child: const Text(
                'Navigate to ios screen B',
              ),
            )
          ],
        ),
      ),
    );
  }

  void callNative() async {
    await channel.invokeMethod("test", []).catchError((e) {
      console.log('invokeMethod test error: $e');
    });
  }

  void pushNativeView(
      {required BuildContext context,
      required String nativeViewTitle,
      required Map<String, dynamic> params}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NativeViewer(
            nativeScreen: "scegline uno",
            title: nativeViewTitle,
            viewParams: params),
      ),
    );
  }
}
