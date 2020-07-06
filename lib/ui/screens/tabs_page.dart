import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakoyi_test/bloc/tabs_bloc/tabs_bloc.dart';
import 'package:otakoyi_test/bloc/tabs_bloc/tabs_events.dart';
import 'package:otakoyi_test/bloc/tabs_bloc/tabs_states.dart';
import 'package:otakoyi_test/thema.dart';
import 'package:otakoyi_test/ui/screens/feeds_page/feeds_page.dart';
import 'package:otakoyi_test/ui/screens/messages_page/messages_page.dart';
import 'package:otakoyi_test/ui/screens/profile_page/profile_page.dart';
import 'package:otakoyi_test/ui/screens/search_page/search_page.dart';

enum TabScreen{
  profile, chat, menu
}

class MainTabsPage extends StatefulWidget {
  @override
  _MainTabsPageState createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final _block = BlocProvider.of<TabsBloc>(context);
  //  final _menuBloc = BlocProvider.of<MenuBloc>(context);

    return Material(
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: BlocBuilder(
          bloc: _block,
          builder: (BuildContext context, TabsState state) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex(_block),
              selectedItemColor: gold,
              onTap:  (index){
              //  switchScreen(index, _block, _menuBloc);
              },
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/profile.png")),
                  title: Text('Profile',
                    //style: tabText,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/messages.png")),
                  title: Text('Messages',
                    //style: tabText,
                  ),
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/feed.png")),
                    title: Text('Feed',
                     // style: tabText,
                    )
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/search.png")),
                    title: Text('Search',
                      // style: tabText,
                    )
                )
              ],
            ),
            body: content(_block),
          ),
        ),
      ),
    );
  }

  int currentIndex(TabsBloc bloc){
    if(bloc.currentState is ProfileState) return 0;
    else if (bloc.currentState is MessagesState) return 1;
    else if(bloc.currentState is FeedsState) return 2;
    else if(bloc.currentState is SearchState) return 3;
    else return 2;
  }

//  void switchScreen(int index, TabsBloc bloc, MenuBloc menuBloc) {
//    switch (index) {
//      case 0:
//        bloc.dispatch( ProfilePressedEvent());
//        break;
//      case 1:
//        bloc.dispatch(MessagesPressedEvent());
//        break;
//      case 2:
//        menuBloc.dispatch(ShowMenuChooserEvent());
//        bloc.dispatch( MenuPressedEvent());
//        break;
//      default:
//        break;
//    }
//  }

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  Widget content(TabsBloc bloc) {
    if(bloc.currentState is ProfileState) return ProfilePage();
    else if (bloc.currentState is MessagesState) return MessagesPage();
    else if(bloc.currentState is FeedsState) return FeedsPage();
    else if (bloc.currentState is SearchState) return SearchPage();

    else return FeedsPage();
  }

}