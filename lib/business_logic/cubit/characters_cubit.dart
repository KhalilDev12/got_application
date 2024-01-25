import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/character_model.dart';
import 'package:got_application/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel>? characters;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  // get All Characters from Repository
  List<CharacterModel>? getAllCharacters() {
    charactersRepository.getAllCharacters().then(
      (characters) {
        emit(CharactersLoaded(characters)); // Wake Up Characters Loaded State
        this.characters = characters; //
      },
    );
    return characters;
  }
}
