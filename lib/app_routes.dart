import 'package:flutter/material.dart';
import 'package:got_application/presentation/screens/character_details_screen.dart';
import 'package:got_application/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) => CharactersScreen(),
        );
      case characterDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(),
        );
    }
  }
}
