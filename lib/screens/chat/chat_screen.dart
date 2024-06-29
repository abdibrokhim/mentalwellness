import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mentalwellness/agent/search/card.dart';
import 'package:mentalwellness/screens/chat/custom_chat_input.dart';
import 'package:mentalwellness/screens/chat/model/chat.model.dart';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/toast.dart';

class ChatScreen extends StatefulWidget {
  final String? initialMessage;
  final List<String>? conversationStarters;

  const ChatScreen({
    super.key,
    this.initialMessage,
    this.conversationStarters,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isAttachmentUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialMessage != null) {
      print('initial message: ${widget.initialMessage}');
      _controller.text = widget.initialMessage!;
    }
    if (store.state.appState.userState.currentChat == null) {
      print('from if');
      store.dispatch(OnSelectChatAction(store.state.appState.userState.userChats.first));
      print('chat selected ${store.state.appState.userState.currentChat!.title}');
    } else {
      print('from else');
      print('chat selected ${store.state.appState.userState.currentChat!.title}');
      print('chat messages ${store.state.appState.userState.currentChat!.messages.length}');
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    enableFeedback: false,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.photo_outlined, color: Colors.black),
                      SizedBox(height: 8.0),
                      Text(
                        'Photo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                                    style: ButtonStyle(
                    enableFeedback: false,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.file_upload_outlined, color: Colors.black),
                      SizedBox(height: 8.0),
                      Text(
                        'File',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _handleImageSelection() {
    // Implement image selection
    print('Image selected');
    showToast(message: 'This feature is under heavy developmenet', bgColor: getColor(AppColors.info));
  }

  void _handleFileSelection() {
    // Implement file selection
    print('File selected');
    showToast(message: 'This feature is under developmenet', bgColor: getColor(AppColors.info));
  }

  void _handleSendPressed() {
    // Implement message sending
    print('Sending message: ${_controller.text}');

    String id = store.state.appState.userState.currentChat!.uid;

    ChatMessageModel msg = ChatMessageModel(
      role: 'user',
      content: _controller.text,
    );

    store.dispatch(AddMessageToChatAction(id, msg));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, UserState>(
        onInit: (store) async {},
        converter: (appState) => appState.state.appState.userState,
        builder: (context, userState) {
          return
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: userState.isFetchingAgentById 
          ? const Text('Chat')
          :
        AgentBubbleCardSec(
          agent: store.state.appState.userState.currentAgent!,
          onOpenProfile: () {
            // we will not open profile because user already came to the chat screen from the agent profile
            print('Open profile');
          }
        )
      ),
      body: Column(
            children: [
              const SizedBox(height: 8.0),
              if (userState.currentChat?.messages.isEmpty ?? true) ...[
                if (widget.conversationStarters?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.conversationStarters!.map((starter) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              label: Text(
                                starter,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ] else ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Builder(
                      builder: (context) {
                        final filteredMessages = userState.currentChat?.messages.where((message) => message.role != 'system').toList() ?? [];

                        if (filteredMessages.isEmpty) {
                          return Center(child: Text('No messages'));
                        }

                        return ListView.builder(
                          itemCount: filteredMessages.length,
                          itemBuilder: (context, index) {
                            final message = filteredMessages[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !userState.isFetchingAgentById 
                                    ?
                                  CircleAvatar(
                                    backgroundImage: message.role == 'assistant' 
                                      ? NetworkImage(store.state.appState.userState.currentAgent!.imageUrl)
                                      : store.state.appState.userState.user!.photoURL != null
                                        ? NetworkImage(store.state.appState.userState.user!.photoURL!)
                                        : NetworkImage(defaultProfileImage),
                                  ) 
                                    : 
                                  CircleAvatar(
                                    backgroundColor: grayColor,
                                    child: Text(
                                      message.role == 'assistant' ? 'A' : 'U',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        !userState.isFetchingAgentById 
                                          ?
                                        Text(
                                          message.role == 'assistant'
                                            ? store.state.appState.userState.currentAgent!.name
                                            : store.state.appState.userState.user!.email != null
                                              ? store.state.appState.userState.user!.email!
                                              : 'User',
                                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                                        )
                                          :
                                        Text(
                                          message.role == 'assistant'
                                              ? 'Agent'
                                              : 'User',
                                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8.0),
                                        MarkdownBody(
                                          data: message.content.replaceAll('â', '\''),
                                          styleSheet: MarkdownStyleSheet(
                                            p: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 32.0),
                child: Row(
                  children: [
                    Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10000.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_circle_outline_rounded),
                      onPressed: (userState.isAddingMessageToChat) ? null : _handleAttachmentPressed,
                    ),
                  ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: CustomChatInput(
                        initialMessage: _controller.text,
                        disable: userState.isAddingMessageToChat,
                        hintText: "Message...",
                        onChanged: (value) {
                          print('value: $value');
                          setState(() {
                            _controller.text = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10000.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_upward_rounded),
                      onPressed: (_controller.text.isEmpty || userState.isAddingMessageToChat) ? null : _handleSendPressed,
                    ),
                  ),
                  ],
                ),
              ),
            ],
      ),
      );
  },
    );
  }
}
