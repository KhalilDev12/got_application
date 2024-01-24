import 'package:flutter/material.dart';
import 'package:got_application/app_routes.dart';

void main() {
  runApp(GotApplication(
    appRoutes: AppRoutes(),
  ));
}

class GotApplication extends StatelessWidget {
  final AppRoutes appRoutes;

  const GotApplication({Key? key, required this.appRoutes});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.generateRoute,
    );
  }
}
