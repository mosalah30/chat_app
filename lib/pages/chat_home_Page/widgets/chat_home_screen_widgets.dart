import 'package:chat_app/AppTheme.dart';
import 'package:chat_app/pages/ChatScreen.dart';
import 'package:chat_app/utils/FullImageScreen.dart';
import 'package:chat_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

void _showFullImage(String imagePath, String imageTag, BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => FullImageScreen(
            imagePath: imagePath,
            imageTag: imageTag,
            backgroundOpacity: 200,
          )));
}

Widget singleChat(
    {String image,
    String name,
    String message,
    String time,
    String badgeNumber,
    bool isNew = false,
    bool isActive = false,
    ThemeData themeData,
    BuildContext context,
    CustomAppTheme customAppTheme}) {
  String tag = image + name;

  Widget badgeWidget = badgeNumber == null
      ? Container()
      : Container(
          padding: Spacing.all(6),
          decoration: BoxDecoration(color: themeData.colorScheme.primary, shape: BoxShape.circle),
          child: Text(
            badgeNumber,
            style: AppTheme.getTextStyle(themeData.textTheme.caption, fontSize: 12, color: themeData.colorScheme.onPrimary),
          ),
        );

  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    },
    child: Container(
      child: Row(
        children: <Widget>[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(MySize.size26)),
                child: InkWell(
                  onTap: () {
                    _showFullImage(image, tag, context);
                  },
                  child: Hero(
                    tag: tag,
                    transitionOnUserGestures: true,
                    child: Image(
                      image: AssetImage(image),
                      height: MySize.size52,
                      width: MySize.size52,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              isActive
                  ? Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: customAppTheme.bgLayer1, width: 2), shape: BoxShape.circle),
                        child: Container(
                          width: MySize.size8,
                          height: MySize.size8,
                          decoration: BoxDecoration(color: customAppTheme.colorSuccess, shape: BoxShape.circle),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          Expanded(
            child: Container(
              margin: Spacing.left(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: AppTheme.getTextStyle(themeData.textTheme.bodyText1, color: themeData.colorScheme.onBackground, fontWeight: isNew ? 600 : 500),
                  ),
                  Text(
                    message,
                    style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, color: themeData.colorScheme.onBackground, fontWeight: isNew ? 600 : 500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: Spacing.left(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  time,
                  style: AppTheme.getTextStyle(themeData.textTheme.caption,
                      color: themeData.colorScheme.onBackground, letterSpacing: -0.2, fontWeight: isNew ? 600 : 500),
                ),
                badgeWidget
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget singleOption({IconData icon, String title, Widget navigation, BuildContext context, ThemeData themeData}) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => navigation));
    },
    child: Container(
      width: MySize.size120,
      decoration: BoxDecoration(color: themeData.colorScheme.onPrimary.withAlpha(90), borderRadius: BorderRadius.all(Radius.circular(MySize.size8))),
      padding: Spacing.fromLTRB(16, 16, 0, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MySize.size4)), color: themeData.colorScheme.onPrimary),
            padding: Spacing.all(2),
            child: Icon(
              icon,
              size: MySize.size18,
              color: themeData.colorScheme.primary,
            ),
          ),
          Container(
            margin: Spacing.top(8),
            child: Text(
              title,
              style: AppTheme.getTextStyle(themeData.textTheme.subtitle2, color: themeData.colorScheme.onPrimary),
            ),
          )
        ],
      ),
    ),
  );
}
