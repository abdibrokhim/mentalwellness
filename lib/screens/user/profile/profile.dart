import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mentalwellness/screens/auth/signin/signin_screen.dart';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/refreshable.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_database/firebase_database.dart';

class UserProfileScreen extends StatefulWidget {
  
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

    String displayName = 'abdibrokhim';

  @override
  Widget build(BuildContext context) {
      
      final User user = FirebaseAuth.instance.currentUser!;
      print('user: $user');

      final state = StoreProvider.of<GlobalState>(context).state;

          String photoUrl = defaultProfileImage;
    String email = user.email!;

      Future<String> getUserName() async {
    // call firestore database to get the user name
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    
    final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference ref = _firebaseDatabase.ref().child('users').child(user.uid);
    DataSnapshot snapshot = (await ref.once()).snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      
      print('data: $data');
      return data['firstName'] + ' ' + data['lastName'];
    }
    
    return 'abdibrokhim';

  }

    void updateValues() {
      setState(() {
        print('Updating values...');
        print('user.photoURL: ${user.photoURL}');
          photoUrl = defaultProfileImage;
      });
    }

    @override
    void initState() {
      super.initState();
    }

    void reFetchData()  {
        updateValues();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    reFetchData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }


    return 
StoreConnector<GlobalState, UserState>(
  onInit: (store) async {
        if (user.displayName != null) {
          setState(() {
            displayName = user.displayName!;
          });
        } else {
          final name = await getUserName();
          setState(() {
            displayName = name;
          });
        }
        setState(() {
          photoUrl = defaultProfileImage;
        });
  },
  onDidChange: (prev, next) {
    if (!next.isLoggedIn) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  },
        converter: (store) => store.state.appState.userState,
        builder: (context, userState) {

    return 
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: 
    Center(
        child: 
        Refreshable(
            refreshController: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: 
            
            userState.isLoading ?

            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF232428)), // Change the progress color
                backgroundColor: Color(0xFFC3C3C3), // Change the background color
              ),
            ) :

            ListView(
              children: [

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
              radius: 50.0, // Size of the profile image
            ),
            SizedBox(height: 16), // Spacing between elements
            Text(
              displayName,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), // Spacing between elements
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 20, 20, 20),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32.0),
        // general note section 
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick info',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ...quickInfo.map((text) {
                return
              Text(
                text,
                maxLines: 2,
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
        }).toList(),
              const SizedBox(height: 32),
              ],
            ),
              ],
            ),
        ),
    ),
    );
        }
    );
  }
}