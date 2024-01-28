import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
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

  List<CharacterModel>? searchedCharacters;
  bool _isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Wake up the BLoC
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
      appBar: _buildAppBar(),
      body: OfflineBuilder(
        child: _buildProgressIndicator(),
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            // There is Connection so Build your widgets
            return buildBlocWidget();
          } else {
            // There is no Connection so Build No Connection Widget
            return buildNoConnectionWidget();
          }
        },
      ),
    );
  }

  Widget buildNoConnectionWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Can't  Connect  ..  Check Internet",
              style: TextStyle(
                color: AppColors.appGrey,
                fontSize: 20,
              ),
            ),
            Image.asset("assets/images/no_connection.png"),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.appYellow,
      title: _isSearching
          ? _buildSearchField()
          : const Text("Characters",
              style: TextStyle(color: AppColors.appGrey)),
      actions: buildAppBarActions(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: AppColors.appGrey,
      style: const TextStyle(
        color: AppColors.appGrey,
      ),
      decoration: const InputDecoration(
        hintText: "Find a character",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.appGrey,
          fontSize: 18,
        ),
      ),
      onChanged: (value) {
        addSearchedForItemsToSearchedList(value);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String value) {
    searchedCharacters = allCharacters!
        .where(
          (character) => character.fullName.toLowerCase().contains(value),
        )
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.appGrey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearching();
          },
          icon: const Icon(
            Icons.search,
            color: AppColors.appGrey,
          ),
        )
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch;
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedList();
        } else {
          return _buildProgressIndicator();
        }
      },
    );
  }

  Center _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.appYellow),
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
      itemCount: searchController.text.isEmpty
          ? allCharacters!.length
          : searchedCharacters!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchController.text.isEmpty
              ? allCharacters![index]
              : searchedCharacters![index],
        );
      },
    );
  }
}
