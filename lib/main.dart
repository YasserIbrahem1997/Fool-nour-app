

// WidgetsBinding.instance.window.physicalSize.width;
// SharedPreferences.setMockInitialValues({});
//drawer UI Update ,set all strings in app for multilanguage .
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fool_nour_last_gitlap/screens/homefragments/fragments_wedgit/dashbord_screen.dart';
import '../screens/aboutuswidget.dart';
import '../screens/checkOutTabWidget.dart';
import '../screens/homeProductDetailWidget.dart';
import '../screens/homeWidget.dart';
import '../screens/homefragments/cartWidget.dart';
import '../screens/introWidget.dart';
import '../screens/loginWidget.dart';
import '../screens/orderhistoryWidget.dart';
import '../screens/searchWidget.dart';
import '../screens/splashWidget.dart';
import '../screens/updateWidget.dart';
import '../screens/userProfileWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/get_order_cubit.dart';
SharedPreferences? prefs;
// void main() {
//   return runApp(
//       MaterialApp(
//         initialRoute: '/',
//         routes: {
//           '/': (context) => Directionality(textDirection: TextDirection.rtl,child:SplashWidget()),
//           // '/intro': (context) => Directionality(textDirection: TextDirection.rtl,child:IntroScreen()),
//           // '/update': (context) => Directionality(textDirection: TextDirection.rtl,child:UpdateWidget()),
//           // '/login': (context) => Directionality(textDirection: TextDirection.rtl,child:LoginWidget()),
//           // '/home': (context) => Directionality(textDirection: TextDirection.rtl,child:HomeScreen()),
//           // '/search': (context) => Directionality(textDirection: TextDirection.rtl,child:SearchScreen()),
//           // '/homeproductdetail': (context) => Directionality(textDirection: TextDirection.rtl,child:HomeProdcutDetailScreen()),
//           // '/aboutus': (context) => Directionality(textDirection: TextDirection.rtl,child:AboutusScreen()),
//           // '/orders': (context) => Directionality(textDirection: TextDirection.rtl,child:OrdersScreen()),
//           // '/checkOutTab': (context) => Directionality(textDirection: TextDirection.rtl,child:CheckOutTabScreen()),
//           // // '/wishlist': (context) => Directionality(textDirection: TextDirection.rtl,child:WishListScreen()),
//           // '/cart': (context) => Directionality(textDirection: TextDirection.rtl,child:CartScreen(false)),
//           // '/userprofile': (context) => Directionality(textDirection: TextDirection.rtl,child:UserProfileScreen()),
//           // // '/blogpost': (context) => Directionality(textDirection: TextDirection.rtl,child:BlogPostListScreen()),
//         },
//         debugShowCheckedModeBanner: false,
//       )
//
//   );
//
// }
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Initialized default app $app');
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => GetAllOrderCubit(Reposetry()),
        ),

      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Directionality(textDirection: TextDirection.rtl,child:SplashWidget()),
          '/intro': (context) => Directionality(textDirection: TextDirection.rtl,child:IntroScreen()),
          '/update': (context) => Directionality(textDirection: TextDirection.rtl,child:UpdateWidget()),
          '/login': (context) => Directionality(textDirection: TextDirection.rtl,child:LoginWidget()),
          '/home': (context) => Directionality(textDirection: TextDirection.rtl,child:HomeScreen()),
          '/search': (context) => Directionality(textDirection: TextDirection.rtl,child:SearchScreen()),
          '/homeproductdetail': (context) => Directionality(textDirection: TextDirection.rtl,child:HomeProdcutDetailScreen()),
          '/aboutus': (context) => Directionality(textDirection: TextDirection.rtl,child:AboutusScreen()),
          '/dashbordScreen': (context) => Directionality(textDirection: TextDirection.rtl,child:DashbordScreen()),
          '/orders': (context) => Directionality(textDirection: TextDirection.rtl,child:OrdersScreen()),
          '/checkOutTab': (context) => Directionality(textDirection: TextDirection.rtl,child:CheckOutTabScreen()),
          // '/wishlist': (context) => Directionality(textDirection: TextDirection.rtl,child:WishListScreen()),
          '/cart': (context) => Directionality(textDirection: TextDirection.rtl,child:CartScreen(false)),
          '/userprofile': (context) => Directionality(textDirection: TextDirection.rtl,child:UserProfileScreen()),
          // '/blogpost': (context) => Directionality(textDirection: TextDirection.rtl,child:BlogPostListScreen()),
        },
        debugShowCheckedModeBanner: false,
      )
    );




  }
}
