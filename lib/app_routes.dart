import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_application/business_logic/cubit/characters_cubit.dart';
import 'package:got_application/data/repository/characters_repository.dart';
import 'package:got_application/data/web_services/characters_web_service.dart';
import 'package:got_application/presentation/screens/character_details_screen.dart';
import 'package:got_application/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';

class AppRoutes {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  // Constructor
  AppRoutes() {
    charactersRepository = CharactersRepository(CharacterWebService());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(),
        );
    }
  }
}
