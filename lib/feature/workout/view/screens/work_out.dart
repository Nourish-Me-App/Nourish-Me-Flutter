import 'package:nourish_me/core/imports/login_imports.dart';
import 'package:nourish_me/core/imports/questions_screen_imports.dart';
import 'package:nourish_me/core/theme/app_text_styles.dart';
import 'package:nourish_me/feature/workout/data/item_model.dart';
import 'package:nourish_me/feature/workout/view/screens/details_screen.dart';
import 'package:nourish_me/feature/workout/view/widgets/item_card.dart';

import '../../../../core/imports/app_routes_imports.dart';

class WorkOutScreen extends StatelessWidget {
  const WorkOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'كارديو',
            style: AppTextStyles.cairo18BoldBlack,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: item.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        currentIndex: index,
                        item: item,
                      ),
                    ),
                  );
                },
                child: ItemCard(
                    title: item[index].name!,
                    time: item[index].time!,
                    image: item[index].image!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            currentIndex: index,
                            item: item,
                          ),
                        ),
                      );
                    }),
              ),
            );
          },
        ));
  }
}
