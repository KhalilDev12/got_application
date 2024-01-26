import 'package:flutter/material.dart';
import 'package:got_application/constants/app_colors.dart';

import '../../data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel character;

  CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.black54,
          alignment: Alignment.center,
          child: Text(
            character.fullName,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.appWhite,
              height: 1.3,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: Container(
          color: AppColors.appGrey,
          child: character.imageUrl.isNotEmpty
              ? FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: "assets/images/loading.gif",
                  image: character.imageUrl,
                  fit: BoxFit.cover,
                )
              : Image.asset("assets/images/placeholder.png"),
        ),
      ),
    );
  }
}
