import 'package:equatable/equatable.dart';

abstract class TabsState extends Equatable{
  TabsState([List props = const []]) : super();
}

class ProfileState extends TabsState{
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return 'ProfileState{}';
  }
}

class MessagesState extends TabsState{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'MessagesState{}';
  }
}

class FeedsState extends TabsState{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FeedsState{}';
  }
}


class SearchState extends TabsState{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SearchState{}';
  }
}