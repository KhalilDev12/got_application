part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}



// State for Error Loading Characters
class CharactersErrorCase extends CharactersState {}



// State for Loaded Characters
class CharactersLoaded extends CharactersState {
  final List<CharacterModel> characters;

  CharactersLoaded(this.characters);
}
