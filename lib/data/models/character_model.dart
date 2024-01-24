class CharacterModel {
  late int charId;
  late String firstName;
  late String lastName;
  late String fullName;
  late String title;
  late String family;
  late String imageTitle;
  late String imageUrl;

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    fullName = json["fullName"];
    title = json["title"];
    family = json["family"];
    imageTitle = json["image"];
    imageUrl = json["imageUrl"];
  }
}
