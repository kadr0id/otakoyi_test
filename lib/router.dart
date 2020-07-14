
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakoyi_test/bloc/login_bloc/login_bloc.dart';
import 'package:otakoyi_test/bloc/tabs_bloc/tabs_bloc.dart';
import 'package:otakoyi_test/models/empty_model.dart';
import 'package:otakoyi_test/ui/screens/feeds_page/feeds_page.dart';
import 'package:otakoyi_test/ui/screens/login_page/login_page.dart';
import 'package:otakoyi_test/ui/screens/messages_page/messages_page.dart';
import 'package:otakoyi_test/ui/screens/profile_page/profile_page.dart';
import 'package:otakoyi_test/ui/screens/search_page/search_page.dart';
import 'package:otakoyi_test/ui/screens/tabs_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';


class Router extends StatelessWidget{

   final SharedPreferences sharedPreferences;
   Router(this.sharedPreferences);

  @override
  Widget build(BuildContext context) {
   return ScopedModel<EmptyModel>(
      model: EmptyModel(),
     child: MaterialApp(
       initialRoute: '/feeds',
       routes: {
         '/profile' : (context) => ProfilePage(),
         '/login' : (context) => BlocProvider<LoginBloc>(
           builder: (context) => LoginBloc(sharedPreferences),
           child: LoginPage()),
         '/messages' : (context) => MessagesPage(),
         '/feeds' : (context) => FeedsPage(),
         '/search' : (context) => SearchPage(),
         '/tabs' : (context) => MultiBlocProvider(
           providers: [
             BlocProvider<TabsBloc>(
               builder: (context) => TabsBloc(),
             )
           ],
           child: MainTabsPage()),
       },
     ),
   );
  }
 }