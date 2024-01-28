import 'package:flutter/material.dart';
import 'package:got_application/constants/app_colors.dart';

import '../../data/models/character_model.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final CharacterModel selectedCharacter;

  CharacterDetailsScreen({Key? key, required this.selectedCharacter})
      : super(key: key);

  @override
  _CharacterDetailsScreenState createState() {
    return _CharacterDetailsScreenState();
  }
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late double _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.appGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          "First Name", widget.selectedCharacter.firstName),
                      buildDivider(220),
                      characterInfo(
                          "Last Name", widget.selectedCharacter.lastName),
                      buildDivider(220),
                      characterInfo("Title", widget.selectedCharacter.title),
                      buildDivider(272),
                      characterInfo("Family", widget.selectedCharacter.family),
                      buildDivider(255),
                    ],
                  ),
                ),
                // Use this SizedBox so you can scroll the screen to hide the picture
                const SizedBox(height: 800),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: _deviceHeight * 0.8,
      backgroundColor: AppColors.appGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          widget.selectedCharacter.fullName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          //textAlign: TextAlign.start,
          style: const TextStyle(color: AppColors.appWhite),
        ),
        // Use Hero Widget for the animation
        background: Hero(
          tag: widget.selectedCharacter.charId,
          child: Image.network(
            widget.selectedCharacter.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title : ",
            style: const TextStyle(
              color: AppColors.appWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.appWhite,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.appYellow,
      height: 20,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
