import 'package:equatable/equatable.dart';

class Feed extends Equatable {
  final int id;
  final String title;
  final String body;

  Feed({this.id, this.title, this.body});

  @override
  String toString() => 'Post { id: $id }';

  @override
  // TODO: implement props
  List<Object> get props => [id, title, body];


}