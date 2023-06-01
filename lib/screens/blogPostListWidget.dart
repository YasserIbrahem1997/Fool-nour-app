import 'package:cached_network_image/cached_network_image.dart';
import '/WidgetHelper/CustomIcons.dart';
import '/bloc/bloc_blogpost.dart';
import '/emuns/screenStatus.dart';
import '/http/woohttprequest.dart';
import '/models/api/blogPosts/getBlogPosts.dart';
import '/screens/blogPostDetailWidget.dart';
import '/utils/paginator.dart';
import 'package:flutter/material.dart';
import '/screens/splashWidget.dart';
import '/utils/appTheme.dart';
import '/utils/languages_local.dart';
import '/utils/prefrences.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

List<GetBlogPosts>? blogPostList;
class BlogPostListScreen extends StatefulWidget {
  BlogPostListScreen({Key? key}) : super(key: key);


  @override
  _BlogPostListScreenState createState() => _BlogPostListScreenState();
}

class _BlogPostListScreenState extends State<BlogPostListScreen> {

  double boxSize = 70;

  @override
  void initState() {
    super.initState();
    loadNewBlogsData().then((value) {
      status=ScreenStatus.active;
      blogPostBloc.refreshBlogPosts(true);
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundColor,
        body: Container(
          color: NormalColor.withAlpha(10),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                  )
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    // color: BackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Icon(Icons.arrow_back,
                                color: MainHighlighter,
                                size: 25,),
                            )
                        ),
                        Text(
                          "Blog Posts",
                          style: TextStyle(color: MainHighlighter,
                            fontSize: 20.0,
                            fontFamily: "Header",
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(),

                      ],
                    ),
                  )
              ),
              Expanded(
                  flex: 13,
                  child: Container(
                    child: NotificationListener(
                      onNotification: _onScrollNotification,
                      child: StreamBuilder(
                        stream: blogPostBloc.getBlogPostsStreamController.stream,
                        initialData: true,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (blogPostList != null) {
                            List<Widget> widgetList = blogPostList!.map((post) {
                              return blogPostItem(post);
                            }).toList()..add(
                                status==ScreenStatus.bussy?Center(child: Container(child: CircularProgressIndicator(),height: 30,width: 30,) ):Container(height: 40,)
                            );
                            return NotificationListener(
                                onNotification: _onScrollNotification,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widgetList.length,
                                  itemBuilder: (context, index) {
                                    return widgetList[index];
                                  },
                                )
                            );
                          }
                          else {
                            return ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,);
                          }
                        },
                      ),
                    )
                  )
              )

            ],
          ),
        )
    );
  }

  Widget blogPostItem(GetBlogPosts blogPosts) {
    if (blogPosts == null)
      return Container(child: Center(child: Text("Some things went wrong"),),);
    return GestureDetector(
      onTap: (){
        navigate(blogPosts.title.rendered,blogPosts.link);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${blogPosts != null ? blogPosts.title.rendered : ""}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(
                            color: MainHighlighter,
                            fontSize: 17,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                        // child: Html(
                        //   onImageTap: (_,_a,_b,_c){
                        //     navigate(blogPosts.title.rendered,blogPosts.link);
                        //   },
                        //   style: {
                        //     "body": Style(
                        //       fontFamily: "Normal",
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: FontSize(16),
                        //       textOverflow: TextOverflow.ellipsis,
                        //       maxLines: 4,
                        //       color: NormalColor,
                        //     ),
                        //   },
                        //   data: blogPosts.content.rendered.toString(),
                        //
                        // )
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                child: Text(
                  "${blogPosts != null ? blogPosts.date.split("T")[0] : ""}".toUpperCase(),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  maxLines: 1,
                  style: TextStyle(
                      color: NormalColor,
                      fontSize: 15,
                      fontFamily: "Normal",
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ScreenStatus status=ScreenStatus.active;
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;
      if (before == max &&  status==ScreenStatus.active) {
        print("scroll_end");
        status=ScreenStatus.bussy;
        blogPostBloc.refreshBlogPosts(true);
        // setState(() {});
        loadNewBlogsData().then((value) {
          status=ScreenStatus.active;
          blogPostBloc.refreshBlogPosts(true);
          // setState(() {});
        });
      }
    }
    return false;
  }

  void navigate(String title,String url) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlogPostDetailScreen(title,url)));
  }
}