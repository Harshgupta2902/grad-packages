// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:utilities/theme/app_box_decoration.dart';
// import 'package:utilities/theme/app_colors.dart';
//
// final _notificationController = Get.put(NotificationController());
//
// class NotificationTransactionCard extends StatefulWidget {
//   final NotificationItem? notification;
//   final Function onDismissedAction;
//   final bool showAnimation;
//
//   const NotificationTransactionCard({
//     Key? key,
//     required this.notification,
//     required this.onDismissedAction,
//     this.showAnimation = false,
//   }) : super(key: key);
//
//   @override
//   State<NotificationTransactionCard> createState() => _NotificationTransactionCardState();
// }
//
// class _NotificationTransactionCardState extends State<NotificationTransactionCard>
//     with TickerProviderStateMixin {
//   bool dismissed = false;
//
//   late AnimationController _controller;
//   late Animation<double> _widthAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     dismissed = _notificationController.idList.contains('${widget.notification?.id ?? ""}');
//
//     // Initialize the animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     // Create a tween for the width values
//     Tween<double> widthTween = Tween<double>(
//       begin: widget.showAnimation && _notificationController.shownOnceAnimation.value == false
//           ? 100.0
//           : 0,
//       end: 0.0,
//     );
//
//     // Create a curved animation
//     _widthAnimation = widthTween.animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.slowMiddle,
//       ),
//     );
//
//     // Start the animation
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.showAnimation && _notificationController.shownOnceAnimation.value == false) {
//         _notificationController.shownOnceAnimation.value = true;
//         _controller.forward();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 12),
//         child: IntrinsicHeight(
//           child: Stack(
//             children: [
//               Dismissible(
//                 direction: DismissDirection.endToStart,
//                 onDismissed: (direction) {
//                   widget.onDismissedAction();
//                 },
//                 background: Container(
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                   decoration: AppBoxDecoration.getBoxDecoration(
//                     color: AppColors.redBg,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Spacer(),
//                       SvgPicture.asset(
//                         'assets/icon/iconDelete.svg',
//                         height: 23,
//                       ),
//                     ],
//                   ),
//                 ),
//                 key: UniqueKey(),
//                 child: GestureDetector(
//                   onTap: () {
//                     // globalRouteNavigator(screen: widget.notification!.screenSwitch);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 14,
//                     ),
//                     decoration: AppBoxDecoration.getBoxDecoration(
//                       color: AppColors.backgroundColor,
//                       borderRadius: 8,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 widget.notification?.title ?? "",
//                                 style: Theme.of(context).textTheme.titleSmall,
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             Text(
//                               widget.notification?.createdAt ?? "",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall
//                                   ?.copyWith(color: AppColors.textGrey),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           widget.notification?.message ?? "",
//                           style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.6),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               if (widget.showAnimation)
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: AnimatedBuilder(
//                     animation: _widthAnimation,
//                     builder: (context, child) {
//                       return AnimatedContainer(
//                         width: _widthAnimation.value,
//                         margin: const EdgeInsets.symmetric(vertical: 6),
//                         decoration: const BoxDecoration(
//                           color: AppColors.redBg, // Replace with your desired color
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(10),
//                             bottomRight: Radius.circular(10),
//                           ),
//                         ),
//                         duration: const Duration(milliseconds: 400),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               'assets/icon/iconDelete.svg',
//                               height: 23,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 )
//             ],
//           ),
//         ));
//   }
// }
