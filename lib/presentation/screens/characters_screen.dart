import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_application/business_logic/cubit/characters_cubit.dart';
import 'package:got_application/constants/app_colors.dart';
import 'package:got_application/presentation/widgets/character_item.dart';

import '../../data/models/character_model.dart';

class CharactersScreen extends StatefulWidget {
  CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() {
    return _CharactersScreenState();
  }
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterModel>? allCharacters;
  late double deviceHeight, deviceWidth;

  @override
  void initState() {
    super.initState();
    // Get All Characters from BLoC
    allCharacters =
        BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appYellow,
        title: const Text(
          "Characters",
          style: TextStyle(color: AppColors.appGrey),
        ),
      ),
      body: buildBlocWidget(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedList();
        } else {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.appYellow),
          );
        }
      },
    );
  }

  Widget buildLoadedList() {
    return Container(
      color: AppColors.appGrey,
      height: deviceHeight,
      width: deviceWidth,
      child: buildCharactersList(),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      itemCount: allCharacters!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return CharacterItem(allCharacters![index]);
      },
    );
  }
}
