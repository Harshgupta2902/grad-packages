import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/message_scaffold.dart';

class GuestTestWebView extends StatefulWidget {
  const GuestTestWebView({super.key, required this.url, required this.successUrl});

  final String url;
  final String successUrl;

  @override
  State<GuestTestWebView> createState() => _GuestTestWebViewState();
}

class _GuestTestWebViewState extends State<GuestTestWebView> {
  String? currentUrl;
  bool isLoading = false;
  bool isBackNavigationAllowed = true;
  bool isBackExecuted = false;

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        messageScaffold(
          context: context,
          content: "Do Not Exit While Test is Running",
          messageScaffoldType: MessageScaffoldType.error,

        );
      },
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(currentUrl ?? widget.url)),
          onWebViewCreated: (InAppWebViewController controller) {},
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              supportZoom: false,
              allowFileAccessFromFileURLs: false,
            ),
          ),
          onLoadStart: (controller, url) async {
            debugPrint("onLoadStart:::::::::$url");
            if (url.toString() == "https://beta.gradding.com/dashboard/pre-ielts-test/report" ||
                url.toString() == widget.successUrl) {
              debugPrint('sending to report');
              context.pushReplacementNamed(GuestGoPaths.guestResultScreen);
            }
          },
          onLoadError: (controller, url, code, message) async {
            debugPrint("onLoadError:::::::::$url");
          },
          onLoadStop: (controller, url) async {
            debugPrint("onLoadStop:::::::::$url");
          },
          onProgressChanged: (controller, progress) async {
            debugPrint("onProgressChanged:::::::::$progress");
          },
        ),
      ),
    );
  }
}
