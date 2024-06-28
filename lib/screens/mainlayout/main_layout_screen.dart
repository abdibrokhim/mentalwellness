import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/agent/profile/profile.dart';
import 'package:mentalwellness/agent/search/card.dart';
import 'package:mentalwellness/agent/search/search_bar.dart';
import 'package:mentalwellness/components/custom_search.dart';
import 'package:mentalwellness/rooms.dart';
import 'package:mentalwellness/screens/explore/explore_search.dart';
import 'package:mentalwellness/screens/user/profile/profile.dart';
import 'package:mentalwellness/utils/constants.dart';

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
                conversationStarters: ['Hello A very good agent', 'Hi A very good agent A very good agent A very good agent', 'A very good agent A very good agent A very good agent'],
                skills: ['skill1', 'skill2'],
                createdAt: DateTime.now(),
              );

    return Scaffold(
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
  ListView(
    physics: const NeverScrollableScrollPhysics(),
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

      Text('Recent chats', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
      const SizedBox(height: 24), // Added space before ListTiles
      // list recent chats below
      Text('no chats', overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 18.0, color: Color.fromARGB(255, 0, 0, 0)),),
      
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
}
