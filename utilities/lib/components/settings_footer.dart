import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:utilities/theme/app_colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final prefs = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await prefs.erase();
          Future.delayed(
            Duration.zero,
            () => context.goNamed("/login"),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            'Logout',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textGrey),
          ),
        ),
      ),
    );
  }
}
