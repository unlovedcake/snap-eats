import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snap_eats/app/modules/webview/views/menu_options.dart';
import 'package:snap_eats/app/routes/app_pages.dart';

import '../controllers/webview_controller.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewView extends StatefulWidget {
  const WebviewView({Key? key}) : super(key: key);
  @override
  State<WebviewView> createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  late WebViewController controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      },

// Keeping track of navigation uisng NavigationDelegate
          onNavigationRequest: (navigation) {
        final host = Uri.parse(navigation.url).host;
        print('AZS ${host}');
        if (navigation.url
            .contains('https://docs.flutter.dev/get-started/install')) {
          Get.toNamed(AppPages.DASHBOARD);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       'Blocking navigation to $host',
          //     ),
          //   ),
          // );
          // return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            message.message,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )));
        },
      )
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("WebView"), actions: [
        Row(
          children: <Widget>[
            Menu(controller: controller),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                        duration: Duration(milliseconds: 200),
                        content: Text(
                          'Can\'t go back',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                        duration: Duration(milliseconds: 200),
                        content: Text(
                          'No forward history item',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                controller.reload();
              },
            ),
          ],
        )
      ]),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          loadingPercentage < 100
              ? LinearProgressIndicator(
                  color: Colors.red,
                  value: loadingPercentage / 100.0,
                )
              : Container()
        ],
      ),
    );
  }
}
