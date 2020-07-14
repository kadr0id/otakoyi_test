import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:otakoyi_test/bloc/feeds_bloc/bloc.dart';
import 'package:otakoyi_test/models/feed.dart';

class FeedsPage extends StatefulWidget{
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
        title: Text('Feeds'),
      ),
      body: BlocProvider(
        builder: (context) => FeedBloc(httpClient: http.Client())..dispatch(FeedFetched()),
        child: HomePage(),
      ),
    );
  }



}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  FeedBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<FeedBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is FeedSuccess) {
          if (state.feeds.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.feeds.length
                  ? BottomLoader()
                  : PostWidget(feed: state.feeds[index]);
            },
            itemCount: state.hasReachedMax
                ? state.feeds.length
                : state.feeds.length + 1,
            controller: _scrollController,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(FeedFetched());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Feed feed;

  const PostWidget({Key key, @required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${feed.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(feed.title),
      isThreeLine: true,
      subtitle: Text(feed.body),
      dense: true,
    );
  }
}