import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ielts_dashboard/home_module/model/dashboard_data_model.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class IeltsGridTestCard extends StatelessWidget {
  const IeltsGridTestCard({super.key, required this.cards, this.images});

  final List<Cards> cards;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 26,
        mainAxisExtent: 120,
        mainAxisSpacing: 20,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final cardData = cards[index];
        final pngImages = images?[index];
        return GestureDetector(
          onTap: () {
            if (cardData.status == false) {
              context.pushNamed(IeltsGoPaths.noPlansPurchased);
              return;
            }
            context.pushNamed(cardData.path ?? "", extra: {
              "url": cardData.url,
              "conditionKey": cardData.key,
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: AppBoxDecoration.getBoxDecoration(
              showShadow: true,
              shadowColor: AppColors.primaryColor.withOpacity(0.06),
              color: AppColors.white,
              borderRadius: 16,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  pngImages ?? "-",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  cardData.title ?? "-",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.brightGrey,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
