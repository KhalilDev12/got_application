import 'package:got_application/data/web_services/characters_web_service.dart';

import '../models/character_model.dart';

class CharactersRepository {
  final CharacterWebService characterWebService;

  CharactersRepository(this.characterWebService);


  // Get All Characters from Characters Web Service
  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await characterWebService.getAllCharacters();
    return characters.map((character) => CharacterModel.fromJson(character)).toList();
  }
}
