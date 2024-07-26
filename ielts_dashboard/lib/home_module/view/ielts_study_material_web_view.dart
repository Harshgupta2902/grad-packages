import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class IeltsStudyMaterialWebView extends StatefulWidget {
  const IeltsStudyMaterialWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<IeltsStudyMaterialWebView> createState() => IeltsStudyMaterialWebViewState();
}

class IeltsStudyMaterialWebViewState extends State<IeltsStudyMaterialWebView> {
  late String token = "";
  String? currentUrl;
  String? currentWebUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        currentUrl = widget.url;
      });
    });
    debugPrint("currentWebUrl::::::::::$currentWebUrl");
    debugPrint("widget urkl::::::::::${widget.url}");
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InAppWebView(
            onWebViewCreated: (controller) {},
            initialUrlRequest: URLRequest(url: Uri.parse(currentUrl ?? widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                supportZoom: false,
                allowFileAccessFromFileURLs: false,
              ),
            ),
            onLoadStart: (controller, url) {
              debugPrint("onLoadStart: $url");
            },
            onLoadError: (controller, url, code, message) {
              debugPrint("onLoadError: $url");
            },
            onLoadStop: (controller, url) async {
              debugPrint("onLoadStop: $url");
              setState(() {
                currentUrl = url.toString();
              });

              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
              debugPrint('Viewing the File');
              controller.evaluateJavascript(source: 'window.location.href').then((url) {
                setState(() {
                  currentWebUrl = url;
                });
                debugPrint('Current web URL: $currentWebUrl');
                debugPrint('Token: $token');
                debugPrint('Headers: ${controller.getOptions()}');
              });
            },
            onProgressChanged: (controller, progress) {
              debugPrint("onProgressChanged: $progress");
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 20,
              width: 80,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
