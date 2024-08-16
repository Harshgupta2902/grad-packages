import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:utilities/packages/dialogs.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    required this.url,
    required this.leaveUrl,
    required this.errorLink,
  }) : super(key: key);

  final String url;
  final String leaveUrl;
  final String errorLink;

  @override
  State<WebViewScreen> createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.url),
        ),
        onWebViewCreated: (controller) {},
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            builtInZoomControls: false,
            displayZoomControls: false,
            useWideViewPort: true, // Ensures the web content uses viewport
            loadWithOverviewMode: true, // Loads the web content fully zoomed out
          ),
          crossPlatform: InAppWebViewOptions(
            preferredContentMode: UserPreferredContentMode.MOBILE,
            disableContextMenu: true, // Disables zooming via context menu
            allowFileAccessFromFileURLs: false,
            javaScriptEnabled: true,
            userAgent:
                "Mozilla/5.0 (Linux; Android 10; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0", // Force mobile user agent
          ),
        ),
        onLoadStart: (controller, url) async {
          debugPrint("onLoadStart: $url");
          if ((url.toString() == widget.errorLink) == true) {
            debugPrint("  errorLink : ${widget.errorLink}");
            await Dialogs.webViewErrorDialog(
              context,
              showButton: false,
              title: "Try again later!",
            );
            Future.delayed(
              Duration.zero,
              () => Navigator.pop(context),
            );
            return;
          }
        },
        onLoadError: (controller, url, code, message) async {
          debugPrint("onLoadError: $url");
          debugPrint("error ------------- url : $url  -|  code : $code -| message : $message   ");

          await Dialogs.webViewErrorDialog(
            context,
            showButton: false,
          );
          Future.delayed(
            Duration.zero,
            () => Navigator.pop(context),
          );
          return;
        },
        onLoadStop: (controller, url) {
          debugPrint("onLoadStop: $url");
        },
        onProgressChanged: (controller, progress) {
          debugPrint("onProgressChanged: $progress");
        },
      ),
    );
  }
}
