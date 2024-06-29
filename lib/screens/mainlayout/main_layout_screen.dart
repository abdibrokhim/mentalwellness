import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/agent/profile/profile.dart';
import 'package:mentalwellness/agent/search/card.dart';
import 'package:mentalwellness/agent/search/search_bar.dart';
import 'package:mentalwellness/components/custom_search.dart';
import 'package:mentalwellness/screens/chat/chat_screen.dart';
import 'package:mentalwellness/screens/chat/model/chat.model.dart';
import 'package:mentalwellness/screens/chat/new_chat_screen.dart';
import 'package:mentalwellness/screens/explore/explore_search.dart';
import 'package:mentalwellness/screens/user/profile/profile.dart';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/refreshable.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  
  List<ChatModel> filteredData = [];

    // RoomsPage(),
  final List<Widget> _tabs = const [
    ExploreSearchScreen(),
    UserProfileScreen(),
  ];

  final List<String> _tabTitles = const [
    'Explore',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    print('init state');
  }

  void reFetchData() {
    print('reFetchData');

      StoreProvider.of<GlobalState>(context).dispatch(GetUserChatsAction(store.state.appState.userState.user!.uid));
      print('user chats ${StoreProvider.of<GlobalState>(context).state.appState.userState.userChats.length}');

      StoreProvider.of<GlobalState>(context).dispatch(GetMostRatedAgentAction(2));
      print('most rated agents ${StoreProvider.of<GlobalState>(context).state.appState.userState.mostRatedAgents.length}');
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    reFetchData();
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

    void updateFilteredList(String filter) {
    setState(() {
      filteredData = StoreProvider.of<GlobalState>(context)
          .state
          .appState
          .userState
          .userChats
          .where((value) {
        final nameLower = value.title!.toLowerCase();
        final filterLower = filter.toLowerCase();
        return nameLower.contains(filterLower);
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {

    return StoreConnector<GlobalState, UserState>(
              onInit: (store) async {
                print('onInit');

                store.dispatch(GetUserChatsAction(store.state.appState.userState.user!.uid));
                StoreProvider.of<GlobalState>(context).dispatch(GetMostRatedAgentAction(2));
              },
              converter: (store) => store.state.appState.userState,
              builder: (context, userState) {
                return
    Scaffold(
      appBar: AppBar(
        surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        title: Text(_tabTitles[_selectedIndex],
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        clipBehavior: Clip.none,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the main content and the version info
    children: [
      Expanded( // Wraps the main content in an Expanded widget
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0, bottom: 0.0), // Added padding to the main content
        child: Column(
          children: [
            CustomSearchBar(
              hintText: "Search for ...",
              onChanged: updateFilteredList
            ),

const SizedBox(height: 32), // Added space before ListTiles
          Expanded( // Wraps the main content in an Expanded widget
            child:
              Refreshable(
                refreshController: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: 
      ListView(
        padding: EdgeInsets.zero,
        children: [
          ...userState.mostRatedAgents.map((agent) =>

            AgentBubbleCard(
                  agent: agent,
                  onOpenProfile: (){ 
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgentProfile(
                      agent: agent,
                      onConversationStart: (String message) {
                        print('Start conversation with message: $message');
                        ChatMessageModel initMsg = ChatMessageModel(
                          role: 'system',
                          content: agent.systemPrompt,
                        );
                        ChatModel chat = ChatModel(
                          uid: "1",
                          title: "New Chat",
                          agentId: agent.uid,
                          userId: userState.user!.uid,
                          messages: [initMsg],
                        );
                        store.dispatch(CreateNewChatAction(chat));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(
                          initialMessage: message,
                          conversationStarters: agent.conversationStarters,
                        )));
                      },
                      onStartConversation: () { 
                        print('Start conversation');
                        ChatMessageModel initMsg = ChatMessageModel(
                          role: 'system',
                          content: agent.systemPrompt,
                        );
                        ChatModel chat = ChatModel(
                          uid: "1",
                          title: "New Chat",
                          agentId: agent.uid,
                          userId: userState.user!.uid,
                          messages: [initMsg],
                        );
                        store.dispatch(CreateNewChatAction(chat));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(
                          conversationStarters: agent.conversationStarters,
                        )));
                      },
                    )));
                  },
                ),
          ),
          const SizedBox(height: 32), // Added space before ListTiles
          const Divider(color: Color.fromARGB(255, 0, 0, 0), thickness: 1, height: 1, indent: 0, endIndent: 0),
          const SizedBox(height: 32), // Added space before ListTiles

          const Text('Recent chats', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
          const SizedBox(height: 24), // Added space before ListTiles
          // list recent chats below
          Row(
                  children: [
                    Expanded(
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: filteredData.map((chats) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () {
                              store.dispatch(OnSelectChatAction(chats));
                              // print('chat selected ${userState.currentChat!.title}');
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChatScreen()));
                            },
                            child: Text(chats.title, style: const TextStyle(fontSize: 18.0, color: Color.fromARGB(255, 0, 0, 0)),),
                          )
                        )).toList(),
                    ),
                    ),
                  ],
                ),
          const SizedBox(height: 32), // Added space before ListTiles
          const Divider(color: Color.fromARGB(255, 0, 0, 0), thickness: 1, height: 1, indent: 0, endIndent: 0),
          const SizedBox(height: 32), // Added space before ListTiles
          ListTile(
            leading: const Icon(Icons.explore_rounded, color: Color.fromARGB(255, 0, 0, 0), size: 26,),
            title: const Text(
              'Explore',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.pop(context);
            },
            tileColor: _selectedIndex == 0 ? const Color(0xFFDDDDDD) : null,
          ),
          const SizedBox(height: 10), // Added space before ListTiles
          ListTile(
            leading: const Icon(Icons.account_circle_outlined, color: Color.fromARGB(255, 0, 0, 0), size: 26,),
            title: const Text('Profile', 
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), 
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
              Navigator.pop(context);
            },
            tileColor: _selectedIndex == 1 ? const Color(0xFFDDDDDD) : null,
          ),
        ],
      ),
      ),
      ),
      ],
      ),
      ),
  ),
  
const SizedBox(height: 32),
  const Padding(padding: EdgeInsets.only(bottom: 20.0), // Added padding to version info
  child: 
      Text(
          textAlign: TextAlign.center,
          'version: 0.0.0', // Added app version
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        ),
    ],
    ),
),

      body: _tabs[_selectedIndex],
    );
  }
);
  }
}
