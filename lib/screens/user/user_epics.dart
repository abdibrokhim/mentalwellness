import 'dart:async';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/screens/user/user_service.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';


Stream<dynamic> fetchAgentsListEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is FetchAgentsListAction)
      .asyncMap((action) => UserService.fetchAgentsList())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            FetchAgentsListSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('Error while fetching patients'),
          ]));
}


List<Stream<dynamic> Function(Stream<dynamic>, EpicStore<GlobalState>)> userEffects = [
  fetchAgentsListEpic,
];

