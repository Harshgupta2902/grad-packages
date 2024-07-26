import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:utilities/side_drawer/default_app_drawer.dart';
import 'package:utilities/side_drawer/default_custom_drawer_model.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class SupportAnimatedContainer extends StatefulWidget {
  final Contact item;

  const SupportAnimatedContainer({super.key, required this.item});

  @override
  State<SupportAnimatedContainer> createState() => _SupportAnimatedContainerState();
}

class _SupportAnimatedContainerState extends State<SupportAnimatedContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  //---------------------  contact us functions  ---------------------

  bool isVisible = false;

  _launchEmail({String? email}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': "", 'body': ''},
    );

    if (await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication)) {
      await canLaunchUrl(
        emailLaunchUri,
      );
    } else {
      debugPrint("Could not launch email");
    }
  }

  launchCall({String? phone}) {
    launchUrlString("tel:$phone");
  }

  _launchWhatsapp({String? mobileNo, String? message}) async {
    String whatsapp = "whatsapp://send?phone=$mobileNo&text=$message";
    final url = Uri.parse(whatsapp);
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
      await canLaunchUrl(url);
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800), // Change the duration as needed
        reverseDuration: const Duration(milliseconds: 400));
    _animation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  turnOnVisibility() {
    setState(() {
      isVisible = true;
    });

    _controller.forward();
  }

  turnOfVisibility() {
    _controller.reverse().then((value) {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isVisible,
          child: SlideTransition(
            transformHitTests: true,
            position: _animation,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.60,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: AppBoxDecoration.getBoxDecoration(
                showShadow: true,
                color: AppColors.white,
                borderRadius: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: AppBoxDecoration.getBoxDecoration(
                      showShadow: true,
                      borderRadius: 35,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        launchCall(phone: widget.item.callNumber);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: dynamicImage(
                              height: 20,
                              image: widget.item.callIcon ?? "",
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Call",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: AppBoxDecoration.getBoxDecoration(
                      showShadow: true,
                      borderRadius: 35,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _launchWhatsapp(
                          mobileNo: widget.item.whatsappNumber,
                          message: "hey there testing here ",
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: dynamicImage(image: widget.item.whatsappIcon ?? ""),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Whatsapp",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: AppBoxDecoration.getBoxDecoration(
                      showShadow: true,
                      borderRadius: 35,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _launchEmail(email: widget.item.mail);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: dynamicImage(
                              image: widget.item.mailIcon ?? "",
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Mail",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteSmoke,
                backgroundColor: AppColors.stormDust.withOpacity(0.1),
                elevation: 0),
            onPressed: () async {
              if (isVisible == true) {
                turnOfVisibility();
              } else {
                turnOnVisibility();
              }
              return;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset("packages/utilities/assets/headphone.svg"),
                const SizedBox(width: 20),
                Text(
                  "Contact Support",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        letterSpacing: 0.15,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
