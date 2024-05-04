import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourish_me/core/helpers/app_constants.dart';
import 'package:nourish_me/core/imports/app_routes_imports.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/routing/routes.dart';

class FakeHome extends StatefulWidget {
  const FakeHome({super.key});

  @override
  State<FakeHome> createState() => _FakeHomeState();
}

class _FakeHomeState extends State<FakeHome> {
  var res;

  test() async {
    await DioHandler().get('home',
        options: Options(headers: {
          'Authorization':
              'Bearer ${CacheHelper().getData(key: AppConstants.token)}'
        }));
  }

  @override
  void initState() {
    super.initState();
    res = test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              CacheHelper()
                  .removeData(key: AppConstants.rememberMeToken)
                  .then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.signUpScreen, (route) => false);
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Fake Home',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
