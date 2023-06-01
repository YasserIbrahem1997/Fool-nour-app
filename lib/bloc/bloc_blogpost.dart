import 'dart:async';


class BlogPostBloc{
//-------------------------------------- HTTP REQUESTS -------------------------------------//
  //get BlogPosts
  final getBlogPostsStreamController = StreamController<bool>.broadcast();
  StreamSink<bool> get getBlogPosts_sink => getBlogPostsStreamController.sink;
  Stream<bool> get getBlogPosts_counter => getBlogPostsStreamController.stream;

  refreshBlogPosts(bool isFetched){
    getBlogPosts_sink.add(isFetched);
  }
}

final BlogPostBloc blogPostBloc=new BlogPostBloc();