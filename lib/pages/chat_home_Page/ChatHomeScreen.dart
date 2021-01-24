import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/models/api_models.dart';
import 'package:chat_app/core/page_models/chat_home_screen_mode.dart';
import 'package:chat_app/pages/chat_home_Page/widgets/chat_home_screen_widgets.dart';
import 'package:chat_app/utils/Generator.dart';
import 'package:chat_app/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../AppTheme.dart';
import '../ChatContactScreen.dart';
import '../ChatCreateGroupScreen.dart';
import '../ChatProfileScreen.dart';

class ChatHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return BaseWidget<ChatHomeScreenModel>(
      model: ChatHomeScreenModel(),
      initState: (m) => m.getLastChats(),
      builder: (context, model, child) {
        ThemeData themeData = model.themeData;
        CustomAppTheme customAppTheme = model.customAppTheme;
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: Container(
                    color: customAppTheme.bgLayer1,
                    child: ListView(
                      padding: Spacing.zero,
                      children: <Widget>[
                        Container(
                          color: themeData.colorScheme.primary,
                          padding: Spacing.fromLTRB(0, 42, 0, 32),
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: <Widget>[
                              Container(
                                margin: Spacing.left(32),
                                child: Text(
                                  "Chats",
                                  style: AppTheme.getTextStyle(themeData.textTheme.headline5, color: themeData.colorScheme.onPrimary, fontWeight: 700),
                                ),
                              ),
                              Container(
                                margin: Spacing.top(16),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: Spacing.left(24),
                                        child: singleOption(
                                            title: "New Chat", navigation: ChatContactScreen(), icon: MdiIcons.plus, context: context, themeData: themeData),
                                      ),
                                      Container(
                                        margin: Spacing.left(24),
                                        child: singleOption(
                                            title: "Groups",
                                            navigation: ChatCreateGroupScreen(),
                                            icon: MdiIcons.accountMultipleOutline,
                                            context: context,
                                            themeData: themeData),
                                      ),
                                      Container(
                                        margin: Spacing.horizontal(24),
                                        child: singleOption(
                                            title: "Account",
                                            navigation: ChatProfileScreen(),
                                            icon: MdiIcons.accountOutline,
                                            context: context,
                                            themeData: themeData),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: themeData.colorScheme.primary,
                          child: Container(
                            decoration: BoxDecoration(
                                color: customAppTheme.bgLayer1,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(MySize.size16), topRight: Radius.circular(MySize.size16))),
                            padding: Spacing.all(24),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration:
                                      BoxDecoration(color: themeData.colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(MySize.size8))),
                                  padding: Spacing.all(6),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: MySize.size16),
                                          child: TextFormField(
                                            style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                                                letterSpacing: 0, color: themeData.colorScheme.onBackground, fontWeight: 500),
                                            decoration: InputDecoration(
                                              hintText: "Search messages",
                                              hintStyle: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                                                  letterSpacing: 0, color: themeData.colorScheme.onBackground, fontWeight: 500),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(MySize.size8),
                                                  ),
                                                  borderSide: BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(MySize.size8),
                                                  ),
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(MySize.size8),
                                                  ),
                                                  borderSide: BorderSide.none),
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(0),
                                            ),
                                            textInputAction: TextInputAction.search,
                                            textCapitalization: TextCapitalization.sentences,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(MySize.size4),
                                        decoration:
                                            BoxDecoration(color: themeData.colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(MySize.size8))),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(MySize.size8),
                                          child: Icon(
                                            MdiIcons.magnify,
                                            color: themeData.colorScheme.onPrimary,
                                            size: MySize.size20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: Spacing.vertical(16),
                                    child: Divider(
                                      height: 0,
                                    )),
                                StreamBuilder(
                                  stream: model.chatListController.stream,
                                  builder: (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.length > 0) {
                                        return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (c, index) {
                                            UserModel user;
                                            if(snapshot.data.elementAt(index).users.elementAt(0).id!= model.firebase.firebaseUser.uid){
                                              user =snapshot.data.elementAt(index).users.elementAt(0);

                                            }else{
                                              user = snapshot.data.elementAt(index).users.elementAt(1);

                                            }
                                            return Column(
                                              children: [
                                                singleChat(
                                                    image: user.image,
                                                    time: snapshot.data.elementAt(index).messages.elementAt(snapshot.data.elementAt(index).messages.length - 1).time.toString(),
                                                    message: snapshot.data.elementAt(index).messages.elementAt(snapshot.data.elementAt(index).messages.length - 1).text ,
                                                    isNew:  snapshot.data.elementAt(index).messages.elementAt(snapshot.data.elementAt(index).messages.length - 1).isNew,
                                                    isActive: true,
                                                    badgeNumber: "4",
                                                    name: user.name,
                                                    context: context,
                                                    themeData: themeData,
                                                    customAppTheme: customAppTheme),
                                                Container(
                                                    margin: Spacing.vertical(16),
                                                    child: Divider(
                                                      height: 0,
                                                    ))
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: Text("noChat"),
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))));
      },
    );
  }
}
