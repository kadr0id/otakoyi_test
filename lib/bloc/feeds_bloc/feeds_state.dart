

import 'package:equatable/equatable.dart';
import 'package:otakoyi_test/models/feed.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedFailure extends FeedState {}

class FeedSuccess extends FeedState {
  final List<Feed> feeds;
  final bool hasReachedMax;

  const FeedSuccess({
    this.feeds,
    this.hasReachedMax,
  });

  FeedSuccess copyWith({
    List<Feed> feeds,
    bool hasReachedMax,
  }) {
    return FeedSuccess(
      feeds: feeds ?? this.feeds,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [feeds, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { feeds: ${feeds.length}, hasReachedMax: $hasReachedMax }';
}