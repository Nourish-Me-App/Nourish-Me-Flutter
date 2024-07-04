// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:nourish_me/core/theme/app_colors.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';

class Sits extends StatefulWidget {
  const Sits({
    super.key, required this.item,
  });

  final Exercises item;

  @override
  State<Sits> createState() => _SitsState();
}

class _SitsState extends State<Sits> {
  @override
  Widget build(BuildContext context) {
    String buttonText = 'انهاء';

    return Column(
      children: [
         Text("${widget.item.name}"),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: SizedBox(
            width: double.infinity,
            height: 32,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                elevation: WidgetStateProperty.all(0),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
