import 'package:flutter/material.dart';
import 'package:nourish_me/feature/diets/view/widgets/tab_bar.dart';
import 'package:nourish_me/feature/workout/data/item_model.dart';
import 'package:nourish_me/feature/workout/view/screens/details_screen.dart';
import 'package:nourish_me/feature/workout/view/widgets/item_card.dart';
import 'package:nourish_me/feature/workout/view/widgets/workout_app_bar.dart';

class WorkOutScreen extends StatelessWidget {
  const WorkOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      initialIndex: 0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const MyAppBarWorkOut(title: 'تمرين', bottom: MyTabBar()),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              7,
              (index) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
