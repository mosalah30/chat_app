import 'dart:async';


import 'package:base_notifier/base_notifier.dart';
import 'package:chat_app/core/models/api_models.dart';
import 'package:chat_app/core/services/api/firebase_api.dart';
import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class ChatHomeScreenModel extends BaseNotifier {
  var firebase = FirebaseApi();
  bool isChecked = false;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(1);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(1);

  StreamController<List<ChatModel>> chatListController = StreamController.broadcast();

  getLastChats(){
    firebase.getUserChatsIdsSnapshot(userId: firebase.firebaseUser.uid).then((chatIds) => {
          chatIds.forEach((element) {
            firebase.getLastChatSnapshot(cId: element).then((chatListSnapshot) {
              chatListController.add(chatListSnapshot.docs.map((e) => ChatModel.fromDocumentSnapshot(e)).toList());
            });
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
    chatListController.close();
  }
}
