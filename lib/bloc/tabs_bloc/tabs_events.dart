import 'package:equatable/equatable.dart';

abstract class TabsEvent extends Equatable{
  TabsEvent() : super();
}



class FeedPressedEvent extends TabsEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FeedPressedEvent{}';
  }

}

class ProfilePressedEvent extends TabsEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'ProfilePressedEvent{}';
  }

}



class MessagesPressedEvent extends TabsEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'MessagesPressedEvent{}';
  }
}

class SearchPressedEvent extends TabsEvent{
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SearchPressedEvent{}';
  }
}