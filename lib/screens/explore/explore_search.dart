import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mentalwellness/agent/card/card.dart';
import 'package:mentalwellness/agent/card/card_wrapper.dart';
import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/agent/profile/profile.dart';
import 'package:mentalwellness/agent/search/bubble_wrapper.dart';
import 'package:mentalwellness/agent/search/card.dart';
import 'package:mentalwellness/agent/search/search_bar.dart';
import 'package:mentalwellness/screens/chat/chat_screen.dart';
import 'package:mentalwellness/screens/chat/model/chat.model.dart';
import 'package:mentalwellness/screens/chat/new_chat_screen.dart';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/store/app_logs.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/refreshable.dart';
import 'package:mentalwellness/utils/shared.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreSearchScreen extends StatefulWidget {

  const ExploreSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreSearchScreenState createState() => _ExploreSearchScreenState();
}

class _ExploreSearchScreenState extends State<ExploreSearchScreen> {

List<AgentModel> filteredData = [];

  @override
  void initState() {
    super.initState();
    print('init state');
  }

  void reFetchData()  {
    print('reFetchData');

      StoreProvider.of<GlobalState>(context).dispatch(FetchAgentsListAction());
      filteredData = StoreProvider.of<GlobalState>(context).state.appState.userState.agentsList;
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

  void updateFilteredList(String filter) {
    setState(() {
      filteredData = StoreProvider.of<GlobalState>(context)
          .state
          .appState
          .userState
          .agentsList
          .where((value) {
        final nameLower = value.name!.toLowerCase();
        final filterLower = filter.toLowerCase();
        return nameLower.contains(filterLower);
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {

      var state = StoreProvider.of<GlobalState>(context).state.appState.userState;
    
    return
    StoreConnector<GlobalState, UserState>(
      onInit: (store) async {
        store.dispatch(FetchAgentsListAction());
        filteredData = store.state.appState.userState.agentsList;
      },
      converter: (appState) => appState.state.appState.userState,
      builder: (context, userState) {
        return
        Scaffold(
          backgroundColor: Colors.white,
          body:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

    const SizedBox(height: 16.0,),
Center(
  child:
    CustomSearchBar(
        hintText: "Search for ...",
        onChanged: updateFilteredList,
      ),
      ),
    const SizedBox(height: 32.0,),
    Expanded(child: 
    Refreshable(
            refreshController: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: 
        SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 32.0),
        child: 
        userState.isFetchingAgentsList
                ? const Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 0, 0)),
                    strokeWidth: 2,
                ))
                : 
        CardWrapper(
          title: 'Featured',
          description: "Tope featured agents for today",
          children: [
            for (var agent in filteredData)
              AgentCard(
                agent: agent,
                onOpenProfile: (){ 
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgentProfile(
                    agent: agent,
                    onConversationStart: (String message) {
                      print('Start conversation with message: $message');
                      String system = getSystemPrompt(agent);
                      ChatMessageModel initMsg = ChatMessageModel(
                        role: 'system',
                        content: system
                      );
                      ChatModel chat = ChatModel(
                        uid: "1", // default value, will be updated in services
                        title: agent.category.first,
                        agentId: agent.uid,
                        userId: state.user!.uid,
                        messages: [initMsg],
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      store.dispatch(CreateNewChatAction(chat));
                      store.dispatch(GetAgentByIdAction(agent.uid));
                      store.dispatch(UpdateConversationCountAction(agent.uid));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(
                        initialMessage: message,
                        conversationStarters: agent.conversationStarters,
                      )));
                    },
                    onStartConversation: () { 
                      print('Start conversation');
                      String system = getSystemPrompt(agent);
                      ChatMessageModel initMsg = ChatMessageModel(
                        role: 'system',
                        content: system
                      );
                      ChatModel chat = ChatModel(
                        uid: "1", // default value, will be updated in services
                        title: agent.category.first,
                        agentId: agent.uid,
                        userId: state.user!.uid,
                        messages: [initMsg],
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      store.dispatch(CreateNewChatAction(chat));
                      store.dispatch(GetAgentByIdAction(agent.uid));
                      store.dispatch(UpdateConversationCountAction(agent.uid));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(
                        conversationStarters: agent.conversationStarters,
                      )));
                    },
                  )));
                },
              ),
          ],
        ) 
        ),
      ),
    ),
    ),
          ],
    ),
    );
      }
    );

  }
}