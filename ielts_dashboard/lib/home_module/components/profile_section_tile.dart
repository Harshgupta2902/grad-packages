import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utilities/theme/app_colors.dart';

class ProfileSectionTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String subTitle;
  final String iconAssetPath;
  const ProfileSectionTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.iconAssetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Padding(
            padding: const EdgeInsets.only(left: 6, top: 6),
            child: SvgPicture.asset(
              iconAssetPath,
              height: 20,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),
          ),
          subtitle: Text(
            subTitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
          ),
          trailing: const Padding(
            padding: EdgeInsets.only(right: 6),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        const Divider(color: AppColors.smokeGrey50),
      ],
    );
  }
}
