import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '/models/api/customer/customerCreateModel.dart';
import 'package:flutter/material.dart';
import '/dialogs/LanguagePickerDialog.dart';
import '/main.dart';
import '/utils/appTheme.dart';
import '/utils/consts.dart';
import '/utils/languages_local.dart';
import '/utils/prefrences.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatefulWidget {
  Function callback;

  SettingScreen(this.callback);

  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RateMyApp? rateMyApp;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    rateMyApp = RateMyApp(
      preferencesPrefix: 'RateOurApp',
      minDays: 7,
      minLaunches: 10,
      remindDays: 7,
      remindLaunches: 10,
      googlePlayIdentifier: 'com.abdelrahmanashraf.foolnour',
      appStoreIdentifier: '1517507827',
    );
    rateMyApp!.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: BackgroundColor,
                  expandedHeight: MediaQuery.of(context).size.height * 0.1,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    // title: Text(
                    //   LocalLanguageString().setting,
                    //   style: TextStyle(
                    //     fontFamily: "Header",
                    //     letterSpacing: 1.2,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 14,
                    //     color: MainHighlighter,
                    //   ),
                    // ),
                    // background: Stack(
                    //   alignment: Alignment.topCenter,
                    //   children: <Widget>[
                    //     Container(),
                    //     Image.asset(
                    //       "assets/logo_img.png",
                    //       fit: BoxFit.contain,
                    //       width: MediaQuery.of(context).size.width*0.7,
                    //     ),
                    //   ],
                    // )
                  ),
                )
              ];
            },
            body: Container(
              color: BackgroundColor,
              child: ListView(
                children: [
                  Container(
                    color: BackgroundColor,
                    padding: EdgeInsets.only(
                        top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        Text(
                          LocalLanguageString().generalsetting,
                          style: TextStyle(
                            fontFamily: "Header",
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: MainHighlighter,
                          ),
                        ),
                        // getListItem(Icons.supervised_user_circle,
                        //     getCustomerDetailsPref().username==""?"Name":getCustomerDetailsPref().username, "", "",
                        //     null, () {
                        //       print("");
                        //     }),
                        // getListItem(
                        //     Icons.email, getCustomerDetailsPref().email==""?"Email":getCustomerDetailsPref().email, "",
                        //     "", null, () {
                        //   print("");
                        // }),
                        // getListItem(
                        //     Icons.contacts,
                        //     LocalLanguageString().profileupdate,
                        //     "",
                        //     "",
                        //     Icons.arrow_forward_ios, () {
                        //   Navigator.pushNamed(context, '/userprofile');
                        // }),
                        // getListItem(Icons.favorite_border,
                        //     LocalLanguageString().wishlist, "", "",
                        //     Icons.arrow_forward_ios, () {
                        //       Navigator.pushNamed(context, '/wishlist');
                        //     }),
                        getListItem(Icons.history, LocalLanguageString().orders,
                            "", "", Icons.arrow_forward_ios, () {
                          Navigator.pushNamed(context, '/orders');
                        }),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: 16.0, left: 6.0, right: 6.0, bottom: 6.0),
                      color: BackgroundColor,
                      child: Column(
                        children: <Widget>[
                          // Divider(),
                          // Text(
                          //   "App Setting",
                          //   style: TextStyle(
                          //     fontFamily: "header",
                          //     letterSpacing: 1.0,
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 18,
                          //     color: MainHighlighter,
                          //   ),
                          // ),
                          //
                          // getListItem(Icons.language,
                          //     LocalLanguageString().language,
                          //     "", "", Icons.arrow_forward_ios, () {
                          //   showDialog(
                          //       barrierDismissible: true,
                          //       context: context,
                          //       builder: (_) =>
                          //           AlertDialog(
                          //             backgroundColor: BackgroundColor,
                          //             title: Text(
                          //               LocalLanguageString().language,
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                 color: MainHighlighter,
                          //                 fontSize: 20.0,
                          //                 fontFamily: "Header",
                          //                 letterSpacing: 1.2,
                          //               ),
                          //             ),
                          //             content: LanguagePickerDialog(
                          //                     () {
                          //                   setState(() {});
                          //                 }
                          //             ),
                          //           )
                          //   );
                          // }),
                          // getListThemeOption(Icons.brightness_4, LocalLanguageString().themeoptions, "", ""),
                          Visibility(
                            visible: USERID.isNotEmpty,
                            child: getListItem(
                                Icons.dashboard_outlined,
                                LocalLanguageString().dashbord,
                                "",
                                "",
                                Icons.arrow_forward_ios, () {
                              Navigator.pushNamed(context, '/dashbordScreen');
                            }),

                          ),
                          getListItem(Icons.dvr, LocalLanguageString().aboutus,
                              "", "", Icons.arrow_forward_ios, () {
                            Navigator.pushNamed(context, '/aboutus');
                          }),
                          // getListItem(Icons.share, LocalLanguageString().share, "",
                          //     "", Icons.arrow_forward_ios, () {
                          //       Share.share(Platform.isAndroid?'https://play.google.com/store/apps/details?id=com.mea.imports&hl=en&gl=US':"ios app link", subject: APPNAME);
                          // }),

                          prefs?.getBool(ISLOGIN) == true
                              ? getListItem(Icons.group_remove_outlined,
                                  'حذف الحساب', "", "", null, () async {
                                  if (prefs!.getBool(ISLOGIN) ?? false) {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => new AlertDialog(
                                        title: new Text('حذف الحساب'),
                                        content: Text(
                                            'هل انتا متأكد من انك تريد حذف الحساب؟'),
                                        actions: <Widget>[
                                          new TextButton(
                                            onPressed: () {
                                              prefs!.setBool(ISLOGIN, false);
                                              setCustomerDetailsPref(null);
                                              Navigator.of(context).pop();
                                            },
                                            child: new Text('نعم'),
                                          ),
                                        ],
                                      ),
                                    );

                                    setState(() {});
                                  } else {
                                    Navigator.pushNamed(context, '/login',
                                        arguments: {
                                          '_amount': 0.0,
                                          '_nextToGo': "/home"
                                        });
                                  }
                                })
                              : Container(),

                          getListItem(
                              Icons.call_missed_outgoing,
                              (prefs!.getBool(ISLOGIN) ?? false)
                                  ? LocalLanguageString().logout
                                  : LocalLanguageString().login,
                              "",
                              "",
                              null, () {
                            if (prefs!.getBool(ISLOGIN) ?? false) {
                              prefs!.setBool(ISLOGIN, false);
                              setCustomerDetailsPref(null);

                              setState(() {});
                            } else {
                              Navigator.pushNamed(context, '/login',
                                  arguments: {
                                    '_amount': 0.0,
                                    '_nextToGo': "/home"
                                  });
                            }
                          }),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    const url =
                                        'https://www.facebook.com/foolnour2/';
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.facebook,
                                    size: 32.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    const url =
                                        'https://www.instagram.com/foolnour/';
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.instagram,
                                    size: 32.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    const url = 'mailto:Foolnour@outlook.com';
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    Icons.mail_outline,
                                    size: 32.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    const url = 'https://wa.link/0gdr3y';
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 32.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    const url = 'tel:+201104894603';
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.phone,
                                    size: 28.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    const url =
                                        'https://maps.app.goo.gl/CpQCZnsyf3oaFqTV7?g_st=iw';
                                    final uri = Uri.parse(url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 28.0,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            )));
  }

  void rateApp() {
    rateMyApp!.showRateDialog(
      context,
      title: 'Rate this app',
      // The dialog title.
      message:
          'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
      // The dialog message.
      rateButton: 'RATE',
      // The dialog "rate" button text.
      noButton: 'NO THANKS',
      // The dialog "no" button text.
      laterButton: 'MAYBE LATER',
      // The dialog "later" button text.
      listener: (button) {
        // The button click listener (useful if you want to cancel the click event).
        switch (button) {
          case RateMyAppDialogButton.rate:
            print('Clicked on "Rate".');
            break;
          case RateMyAppDialogButton.later:
            print('Clicked on "Later".');
            break;
          case RateMyAppDialogButton.no:
            print('Clicked on "No".');
            break;
        }

        return true; // Return false if you want to cancel the click event.
      },

      // Set to false if you want to show the native Apple app rating dialog on iOS.
      dialogStyle: DialogStyle(), // Custom dialog styles.
    );

    // Or if you prefer to show a star rating bar :

    rateMyApp!.showStarRateDialog(
      context,
      title: 'Rate this app',
      // The dialog title.
      message:
          'You like this app ? Then take a little bit of your time to leave a rating :',
      // The dialog message.
      actionsBuilder: (context, stars) {
        // Triggered when the user updates the star rating.
        return [
          // Return a list of actions (that will be shown at the bottom of the dialog).
          TextButton(
            child: Text('OK'),
            onPressed: () async {
              print('Thanks for the ' +
                  (stars == null ? '0' : stars.round().toString()) +
                  ' star(s) !');
              // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
              await rateMyApp!.callEvent(RateMyAppEventType
                  .rateButtonPressed); // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information.

              Navigator.pop(context);
            },
          ),
        ];
      },

      // Set to false if you want to show the native Apple app rating dialog on iOS.
      dialogStyle: DialogStyle(
        // Custom dialog styles.
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: StarRatingOptions(), // Custom star bar rating options.
    );
  }

  Widget getListItem(IconData icon, String title, String extendedTitle,
      String description, var trailing, Function() callback) {
    if (trailing != null) trailing = trailing as IconData;

    return ListTile(
      onTap: callback,
      leading: Icon(
        icon,
        color: MainHighlighter,
      ),
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontFamily: "Normal",
                color: NormalColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 16.0,
          ),
          Text(
            extendedTitle,
            style: TextStyle(
              fontFamily: "Normal",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: NormalColor,
            ),
          ),
        ],
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          fontFamily: "Normal",
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: NormalColor,
        ),
      ),
      trailing: Icon(
        trailing,
      ),
    );
  }

  getListThemeOption(
      IconData icon, String title, String extendedTitle, String description) {
    return ListTile(
        leading: Icon(
          icon,
          color: MainHighlighter,
        ),
        title: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontFamily: "Normal",
                  color: NormalColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              extendedTitle,
              style: TextStyle(
                fontFamily: "Normal",
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: NormalColor,
              ),
            ),
          ],
        ),
        subtitle: Text(description),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.0),
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //                 <--- border radius here
                ),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() async {
                    await setDarkTheme(true);
                    widget.callback();
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Dark',
                    style: TextStyle(
                        fontFamily: "Normal",
                        color: isDarkTheme() ? MainHighlighter : NormalColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() async {
                    await setDarkTheme(false);
                    widget.callback();
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Light',
                    style: TextStyle(
                        fontFamily: "Normal",
                        color: !isDarkTheme() ? MainHighlighter : NormalColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
