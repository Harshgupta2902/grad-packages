import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:utilities/components/gradding_app_bar.dart';

class ViewYoutubeVideo extends StatefulWidget {
  const ViewYoutubeVideo({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<ViewYoutubeVideo> createState() => ViewYoutubeVideoState();
}

class ViewYoutubeVideoState extends State<ViewYoutubeVideo> {
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
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            "https://www.youtube.com/watch?v=${currentUrl ?? widget.url}",
          ),
        ),
      ),
    );
  }
}
