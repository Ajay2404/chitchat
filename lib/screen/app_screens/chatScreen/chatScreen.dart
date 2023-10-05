import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/common/assets/apis.dart';
import 'package:chitchat/helper/my_date_util.dart';
import 'package:chitchat/main.dart';
import 'package:chitchat/models/chatUsers.dart';
import 'package:chitchat/models/message.dart';
import 'package:chitchat/widgets/message_card.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> list = [];
  final textController = TextEditingController();
  bool showEmoji = false;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (showEmoji) {
              setState(() {
                showEmoji = !showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
            appBar: AppBar(
              backgroundColor: Color(0xff5c8bff),
              flexibleSpace: _appBar(),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMessages(widget.user),
                    builder: (context, snapshot) {
                      //if data is loading
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();
                        //if all data loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data!.docs;
                          list = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (list.isNotEmpty) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              physics: const BouncingScrollPhysics(),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return MessageCard(
                                  message: list[index],
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: Text(
                              "Say Hi!👋",
                              style: TextStyle(fontSize: 20),
                            ));
                          }
                      }
                    },
                  ),
                ),
                chatInput(),
                if (showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: textController,
                      config: Config(
                        bgColor: Color.fromARGB(255, 234, 248, 255),
                        columns: 7,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: StreamBuilder(
        stream: APIs.getUserInfo(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
          return Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp,
                      color: Colors.white)),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageUrl: list.isNotEmpty ? list[0].image : widget.user.image,
                  // placeholder: (context, url) =>
                  //     CircleAvatar(child: Icon(CupertinoIcons.person)),
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      list.isNotEmpty ? list[0].name : widget.user.name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      list.isNotEmpty
                          ? list[0].isOnline
                              ? 'Online'
                              : MyDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.user.lastActive)
                          : widget.user.lastActive,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    )
                  ]),
            ],
          );
        },
      ),
    );
  }

  Widget chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          showEmoji = !showEmoji;
                        });
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),
                  Expanded(
                      child: TextField(
                    onTap: () {
                      if (showEmoji)
                        setState(() {
                          showEmoji = !showEmoji;
                        });
                    },
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: "Type Something...",
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          setState(() => isUploading = true);
                          await APIs.sendChatImage(widget.user, File(i.path));
                          setState(() => isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          setState(() => isUploading = true);

                          await APIs.sendChatImage(
                              widget.user, File(image.path));
                          setState(() => isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),
                  const SizedBox(width: 6),
                ],
              ),
            ),
          ),
          //msg send button
          MaterialButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  APIs.sendMessage(widget.user, textController.text, Type.text);
                  textController.text = "";
                }
              },
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 10),
              color: Color(0xfff5c8bff),
              minWidth: 0,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 28,
              )),
        ],
      ),
    );
  }
}
