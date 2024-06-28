import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/agent/profile/profile.dart';
import 'package:mentalwellness/agent/search/card.dart';
import 'package:mentalwellness/agent/search/search_bar.dart';
import 'package:mentalwellness/components/custom_search.dart';
import 'package:mentalwellness/rooms.dart';
import 'package:mentalwellness/screens/chat/chat_screen.dart';
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

  void reFetchData()  {
    print('reFetchData');

      StoreProvider.of<GlobalState>(context).dispatch(GetUserChatsAction(store.state.appState.userState.user!.uid));
      print('user chats ${StoreProvider.of<GlobalState>(context).state.appState.userState.userChats.length}');
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    reFetchData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {

    final AgentModel agent = AgentModel(
                uid: '1',
                name: 'John Doe',
                description: 'A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent', 
                imageUrl: 'https://i.pravatar.cc/300?u=brooks.white@armstrong.biz',
                rating: {1: 10, 2: 20, 3: 10, 4: 20, 5: 50},
                createdBy: 'admin',
                category: ['category1'],
                conversationCount: 10,
                systemPrompt: "You are an emotional well-being guide dedicated to supporting individuals in managing their emotions, coping with stress, and developing emotional resilience. Your task is to support users and answer their questions about a holistic approach to emotional well-being, emphasizing practical strategies and daily habits. Use a warm, empathetic, and encouraging tone to make the content relatable and easy to follow. Remember to prioritize the privacy of users, ensuring that any personal data or specific scenarios are anonymized and handled with care.",
                conversationStarters: ['Hello A very good agent', 'Hi A very good agent A very good agent A very good agent', 'A very good agent A very good agent A very good agent'],
                skills: ['skill1', 'skill2'],
                createdAt: DateTime.now(),
              );

    return StoreConnector<GlobalState, UserState>(
              onInit: (store) {
                print('onInit');

                store.dispatch(GetUserChatsAction(store.state.appState.userState.user!.uid));
              },
              converter: (store) => store.state.appState.userState,
              builder: (context, userState) {
                return
    Scaffold(
      appBar: AppBar(
        surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
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
        child:
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0, bottom: 0.0), // Added padding to the main content
          child:
          Refreshable(
            refreshController: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: 
  ListView(
    // physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    children: [
      CustomSearchBar(
        hintText: "Search for ...",
        onChanged: (value) {
          // Perform search
          print('search value ${value}');
        },
      ),
      const SizedBox(height: 32), // Added space before ListTiles

      AgentBubbleCard(
              agent: agent,
              onOpenProfile: (){ 
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgentProfile(
                  agent: agent,
                  onStartConversation: (){ print('Start conversation'); },
                )));
              },
            ),
            const SizedBox(height: 24), // Added space before ListTiles
      AgentBubbleCard(
              agent: agent,
              onOpenProfile: (){ 
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgentProfile(
                  agent: agent,
                  onStartConversation: (){ print('Start conversation'); },
                )));
              },
            ),
      
      const SizedBox(height: 32), // Added space before ListTiles
      Divider(color: const Color.fromARGB(255, 0, 0, 0), thickness: 1, height: 1, indent: 0, endIndent: 0),
      const SizedBox(height: 32), // Added space before ListTiles

      Text('Recent chats', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
      const SizedBox(height: 24), // Added space before ListTiles
      // list recent chats below
      Row(
              children: [
                Expanded(
                  child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: userState.userChats.map((chats) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () {
                          store.dispatch(OnSelectChatAction(chats));
                          // print('chat selected ${userState.currentChat!.title}');
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen()));
                        },
                        child: Text(chats.title, style: const TextStyle(fontSize: 18.0, color: Color.fromARGB(255, 0, 0, 0)),),
                      )
                    )).toList(),
                ),
                ),
              ],
            ),
      const SizedBox(height: 32), // Added space before ListTiles
      Divider(color: const Color.fromARGB(255, 0, 0, 0), thickness: 1, height: 1, indent: 0, endIndent: 0),
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
  ),
  
const SizedBox(height: 32),
  Padding(padding: const EdgeInsets.only(bottom: 20.0), // Added padding to version info
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
    ],),
),

      body: _tabs[_selectedIndex],
    );
  }
);
  }
}
