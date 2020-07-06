import 'package:bloc/bloc.dart';
import 'package:otakoyi_test/bloc/tabs_bloc/tabs_events.dart';
import 'package:otakoyi_test/bloc/tabs_bloc/tabs_states.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState>{

  @override
  Stream<TabsState> mapEventToState(TabsEvent event) async*{
    if(event is ProfilePressedEvent)
      yield ProfileState();
    else if(event is MessagesPressedEvent)
      yield MessagesState();
    else if (event is FeedPressedEvent)
      yield FeedsState();
    else if (event is SearchPressedEvent)
      yield SearchState();
    else yield FeedsState();

  }

  @override
  TabsState get initialState  => FeedsState();
}