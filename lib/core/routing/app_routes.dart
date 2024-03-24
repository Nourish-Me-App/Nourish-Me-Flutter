import 'package:flutter/material.dart';
import 'package:nourish_me/core/routing/routes.dart';

import '../../features/setup/view/screens/setup.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.setup:
        return MaterialPageRoute(
          builder: (context) => const Setup(),
        );
    }
    return null;
  }
}
