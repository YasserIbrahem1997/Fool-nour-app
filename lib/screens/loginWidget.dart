import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import '../models/api/customer/customerGetModel.dart';
import '../screens/verificationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../main.dart';
import '../models/api/customer/customerCreateModel.dart';
import '../models/api/customer/cupdateCustomerUpdateModel.dart';
import '../models/api/customer/createCustomerResponceModel.dart';
import '../screens/splashWidget.dart';
import '../utils/appTheme.dart';
import '../utils/consts.dart';
import '../utils/prefrences.dart';
import '../http/woohttprequest.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginWidget extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<LoginWidget> {
//  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool? isFreeShipment;
  double? amount;
  String? redirectTo;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context)!.settings.arguments as Map;
    amount = map['_amount'];
    isFreeShipment = map['_freeShipment'] ?? false;
    redirectTo = map['_nextToGo'];

    TextEditingController phoneController = new TextEditingController();
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                color: BackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.arrow_back,
                            color: MainHighlighter,
                            size: 25,
                          ),
                        )),
                    Text(
                      "تسجيل الدخول ",
                      style: TextStyle(
                        color: MainHighlighter,
                        fontSize: 20.0,
                        fontFamily: "Header",
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                ),
              )),
          Divider(),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  "قم بتسجيل دخول حتي تتمكن من استكمال الطلب",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Normal",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: NormalColor,
                  ),
                ),
              )),
          isLoading
              ? JumpingDotsProgressIndicator(
                  fontSize: 30.0,
                )
              : Container(),
          // Expanded(
          //     flex: 1,
          //     child: Center(
          //       child: Text(
          //         "@Copyright :WooFlux Store.",
          //         style: TextStyle(
          //           fontFamily: "Normal",
          //           fontWeight: FontWeight.w600,
          //           fontSize: 10,
          //           color: NormalColor,
          //         ),
          //       ),
          //     )),

          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 32,
                          right: 32,
                          bottom: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                  left: 6,
                                  right: 6,
                                ),
                                child: Text(
                                  "+20",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                              Container(
                                color: Colors.black,
                                width: 0.5,
                                height: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 6,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.45,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  controller: phoneController,
                                  maxLength: 11,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ], // Only numbers can be entered

                                  decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                    counterText: "",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          continueClick(phoneController.text);
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: NormalColor,
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/phone.png',
                                  width: 30,
                                  height: 30,
                                ),
                                Text(
                                  'تسجيل الدخول برقم الهاتف',
                                  style: TextStyle(
                                    fontFamily: "Normal",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: BackgroundColor,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Divider(),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   child: Platform.isAndroid
                //       ? Container()
                //       : SignInWithAppleButton(
                //           onPressed: () {
                //             signInWithApple();
                //           },
                //           style: isDarkTheme()
                //               ? SignInWithAppleButtonStyle.white
                //               : SignInWithAppleButtonStyle.black,
                //         ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  addNewUser(String? displayName, String? email, String? phoneNumber) async {
    CreateCustomer customer = getCustomerDetailsPref();
    if (displayName != null) {
      customer.billing.first_name =
          customer.first_name = displayName.split(" ")[0];
      customer.billing.last_name = customer.last_name =
          displayName.split(" ").length > 1 ? displayName.split(" ")[1] : "";
    }
    customer.billing.email = customer.email = customer.billing.email = email!;

    customer.billing.phone = phoneNumber;
    // customer.username = displayName;
    customer.username = email;

    setCustomerDetailsPref(customer);
    setState(() {
      isLoading = true;
    });
    await addToWoocommerce(customer);
    // moveToNext();
  }

  Future<void> addToWoocommerce(CreateCustomer _cCustomer) async {
    GetCustomer? customer =
        await WooHttpRequest().getCustomer(_cCustomer.email);
    if (customer != null) {
      UpdateCustomer updateCustomer =
          UpdateCustomer.fromJson(_cCustomer.toJson());
      CreateCustomerResponce? createCustomerResponce =
          await WooHttpRequest().updateNewUser(customer.id, updateCustomer);
      if (createCustomerResponce != null) {
        prefs!.setInt(USERID, createCustomerResponce.id);
        moveToNext();
      }
      print(createCustomerResponce);
    } else {
      CreateCustomer createCustomer =
          CreateCustomer.fromJson(_cCustomer.toJson());
      CreateCustomerResponce? createCustomerResponce =
          await WooHttpRequest().addCustomer(createCustomer);
      if (createCustomerResponce != null) {
        prefs!.setInt(USERID, createCustomerResponce.id);
        moveToNext();
      }
    }
  }

  Future<void> moveToNext() async {
    // orders =await WooHttpRequest().getOrders();
    prefs!.setBool(ISLOGIN, true);
    Navigator.pushReplacementNamed(context, redirectTo!,
        arguments: {'_amount': amount, '_freeShipment': isFreeShipment});
  }

  //-------------------Incase If Developer wants serpate implemenation standalone login independent to firebase -----------//
  //old
  // void initiateFacebookLogin() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //
  //       var graphResponse = await http.get(
  //           'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
  //
  //       var profile = json.decode(graphResponse.body);
  //       print(profile.toString());
  //       addNewUserToWooComm( profile["name"], profile["email"], "");
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print("");
  //       break;
  //     case FacebookLoginStatus.error:
  //       facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
  //       await facebookLogin.logIn(['email']);
  //       break;
  //   }
  // }
  // GoogleSignIn googleauth = new GoogleSignIn();
  // void initiateGoogleLogin() async {
  //   googleauth.signIn().then((result){
  //     result.authentication.then((googleuser){
  //       addNewUserToWooComm(result.displayName, result.email, "");
  //
  //     }).catchError((e){
  //       print(e);
  //     });}).catchError((e){
  //     print(e);
  //   });
  // }
  // Future<void>  appleSignIn()  async {
  //   final credential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     webAuthenticationOptions: WebAuthenticationOptions(
  //       // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
  //       clientId:
  //       'com.abdelrahmanashraf.foolnour',
  //       redirectUri: Uri.parse(
  //         'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
  //       ),
  //     ),
  //     // TODO: Remove these if you have no need for them
  //     nonce: 'example-nonce',
  //     state: 'example-state',
  //   );
  //
  //   print(credential);
  //   addNewUserToWooComm("", "", "");
  // }

  continueClick(String phone) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          mobile: phone,
          countrycode: "+20",
          amount: amount,
          isFreeShipment: isFreeShipment,
          redirectTo: redirectTo,
        ),
      ),
    );
  }

  initiateGoogleLogin() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      addNewUser(userCredential.user!.displayName, userCredential.user!.email,
          userCredential.user!.phoneNumber);

      return userCredential;
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print("apple_appleCredential " + appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken!,
        rawNonce: rawNonce,
      );
      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      print("apple_authResult " + authResult.additionalUserInfo.toString());

      final firebaseUser = authResult.user;
      addNewUser(firebaseUser!.displayName, firebaseUser.email,
          firebaseUser.phoneNumber);
    } catch (exception) {
      print(exception);
    }
  }
}
