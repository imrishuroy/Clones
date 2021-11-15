import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'tik_tok_icons.dart';

class ActionsToolbar extends StatelessWidget {
  // Full dimensions of an action
  static const double actionWidgetSize = 60.0;

  static const double navigationIconSize = 20.0;

  static const double actionIconGap = 12.0;
  static const double followActionIconSize = 25.0;
  static const double createButtonWidth = 38.0;

// The size of the icon showen for Social Actions
  static const double actionIconSize = 35.0;

// The size of the share social icon
  static const double shareActionIconSize = 25.0;

// The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
  static const double plusIconSize = 20.0;

  const ActionsToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _getFollowAction(),
        _getSocialAction(icon: TikTokIcons.heart, title: '3.2m'),
        _getSocialAction(icon: TikTokIcons.chatBubble, title: '16.4k'),
        _getSocialAction(
            icon: TikTokIcons.reply, title: 'Share', isShare: true),
        _getMusicPlayerAction()
      ]),
    );
  }

  Widget _getSocialAction({
    required String title,
    required IconData icon,
    bool isShare = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: 60.0,
      height: 60.0,
      child: Column(
        children: [
          Icon(icon, size: isShare ? 25.0 : 35.0, color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.only(top: isShare ? 5.0 : 2.0),
            child:
                Text(title, style: TextStyle(fontSize: isShare ? 10.0 : 12.0)),
          )
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _getFollowAction({String? pictureUrl}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: 60.0,
        height: 60.0,
        child: Stack(children: [_getProfilePicture(), _getPlusIcon()]));
  }

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((actionWidgetSize / 2) - (plusIconSize / 2)),
      child: Container(
        width: plusIconSize, // PlusIconSize = 20.0;
        height: plusIconSize, // PlusIconSize = 20.0;
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 43, 84),
            borderRadius: BorderRadius.circular(15.0)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }

  Widget _getProfilePicture() {
    return Positioned(
      left: (actionWidgetSize / 2) - (profileImageSize / 2),
      child: Container(
        padding:
            const EdgeInsets.all(1.0), // Add 1.0 point padding to create border
        height: profileImageSize, // ProfileImageSize = 50.0;
        width: profileImageSize, // ProfileImageSize = 50.0;
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(profileImageSize / 2)),
        // import 'package:cached_network_image/cached_network_image.dart'; at the top to use CachedNetworkImage
        child: CachedNetworkImage(
          imageUrl:
              'https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  LinearGradient get musicGradient => LinearGradient(colors: [
        Colors.grey.shade800,
        Colors.grey.shade900,
        Colors.grey.shade900,
        Colors.grey.shade800,
      ], stops: const [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  Widget _getMusicPlayerAction() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: actionWidgetSize,
      height: actionWidgetSize,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11.0),
            height: profileImageSize,
            width: profileImageSize,
            decoration: BoxDecoration(
                gradient: musicGradient,
                borderRadius: BorderRadius.circular(profileImageSize / 2)),
            child: CachedNetworkImage(
              imageUrl:
                  "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
