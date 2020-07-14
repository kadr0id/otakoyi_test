
import 'package:bloc/bloc.dart';
import 'package:otakoyi_test/bloc/feeds_bloc/feeds_event.dart';
import 'package:otakoyi_test/bloc/feeds_bloc/feeds_state.dart';
import 'package:meta/meta.dart';
import 'package:otakoyi_test/models/feed.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final http.Client httpClient;

  FeedBloc({@required this.httpClient});

  @override
  Stream<FeedState> transformEvents(
      Stream<FeedEvent> events,
      Stream<FeedState> next(FeedFetched fetched),
      ) {
    return events.asyncExpand(next);
  }

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    final currentState = initialState;
    if (event is FeedFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is FeedInitial) {
          final feeds = await _fetchFeeds(0, 20);
          yield FeedSuccess(feeds: feeds, hasReachedMax: false);
          return;
        }
        if (currentState is FeedSuccess) {
          final feeds = await _fetchFeeds(currentState.feeds.length, 20);
          yield feeds.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : FeedSuccess(
            feeds: currentState.feeds + feeds,
            hasReachedMax: false,
          );
        }
      } catch (_) {
        yield FeedFailure();
      }
    }
  }

  bool _hasReachedMax(FeedState state) =>
      state is FeedSuccess && state.hasReachedMax;

  Future<List<Feed>> _fetchFeeds(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawFeed) {
        return Feed(
          id: rawFeed['id'],
          title: rawFeed['title'],
          body: rawFeed['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }

  @override
  FeedState get initialState => FeedInitial();
}