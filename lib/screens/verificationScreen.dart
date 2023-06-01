import '../screens/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../http/woohttprequest.dart';
import '../main.dart';
import '../models/api/customer/createCustomerResponceModel.dart';
import '../models/api/customer/cupdateCustomerUpdateModel.dart';
import '../models/api/customer/customerCreateModel.dart';
import '../models/api/customer/customerGetModel.dart';
import '../utils/consts.dart';
import '../utils/prefrences.dart';

class VerificationScreen extends StatefulWidget {
  String countrycode;
  String mobile;
  bool? isFreeShipment;
  double? amount;
  String? redirectTo;
  VerificationScreen({required this.mobile, required this.countrycode, this.amount,this.isFreeShipment,this.redirectTo});
  @override
  _VerificationScreenPageState createState() => _VerificationScreenPageState();
}

class _VerificationScreenPageState extends State<VerificationScreen> {
  TextEditingController controller1 = new TextEditingController();
  FocusNode controller1fn = new FocusNode();
  static const double dist = 3.0;
  TextEditingController currController = new TextEditingController();
  String otp = "";
  bool isLoading = false;
  String _verificationId = '';
  bool autovalidate = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    currController = controller1;
    _verifyPhoneNumber();
  }

  void _verifyPhoneNumber() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Fluttertoast.showToast(msg: authException.message!);
      print(authException.code);
      print(authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      print("codeSent");
      print(verificationId);
      Fluttertoast.showToast(
          msg: "Please check your phone for the verification code.");
      _verificationId = verificationId;
    } as PhoneCodeSent;

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("codeAutoRetrievalTimeout");
      _verificationId = verificationId;
    };

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      print("verificationCompleted");
    };

    if (kIsWeb) {
      await _auth
          .signInWithPhoneNumber(
        widget.countrycode + widget.mobile,
      )
          .then((value) {
        _verificationId = value.verificationId;
        print("then");
      }).catchError((onError) {
        print(onError);
      });
    } else {
      await _auth
          .verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: widget.countrycode + widget.mobile,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential){},
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {
        print("then");
      }).catchError((onError) {
        print(onError);
      });
    }

    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  Future _signInWithPhoneNumber(String otp) async {
    print( "_signInWithPhoneNumber");

    _showProgressDialog(true);
    if (await Utility.checkInternet()) {
      try {
        print( "AuthCredential");

        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );
        final User? user = (await _auth.signInWithCredential(credential)).user;
        final User? currentUser = _auth.currentUser;
        assert(user!.uid == currentUser!.uid);
        print( "User");

        _showProgressDialog(false);
        if (user != null) {
          print( "signed in");

          // Once signed in, return the UserCredential
          // UserCredential userCredential =
          // await FirebaseAuth.instance.signInWithCredential(credential);
          addNewUser(_auth.currentUser!.displayName, _auth.currentUser!.email,
              _auth.currentUser!.phoneNumber);

          return _auth.currentUser;
        } else {
          Fluttertoast.showToast(msg: "Sign in failed");
        }
      } catch (e) {
        print(e);

        Fluttertoast.showToast(msg: e.toString());
        _showProgressDialog(false);
      }
    } else {
      _showProgressDialog(false);
      Fluttertoast.showToast(msg: "No internet connection");
    }
  }

  _showProgressDialog(bool isloadingstate) {
    if (mounted)
      setState(() {
        isLoading = isloadingstate;
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
  }

  verifyOtp(String otpText) async {
    _signInWithPhoneNumber(otpText);
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
            ],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            enabled: true,
            controller: controller1,
            autofocus: true,
            focusNode: controller1fn,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: Colors.grey),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            top: false,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "An " +
                                "SMS"
                                    " with the verification code has been sent to your registered " +
                                "mobile number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Visibility(
                          visible: widget.mobile == null ? false : true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.countrycode + " " + widget.mobile,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.grey,
                                iconSize: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Center(
                          child: Text(
                            "Enter 6 digits code",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: GridView.count(
                          crossAxisCount: 1,
                          mainAxisSpacing: 0.0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 3,
                          scrollDirection: Axis.vertical,
                          children: List<Container>.generate(
                            1,
                                (int index) => Container(
                              child: widgetList[index],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Utility.loginButtonsWidget(
                        "",
                        "Continue",
                            () {
                          _onButtonClick();
                        },
                        Colors.black,
                        Colors.black,
                        
                        Colors.white,
                      ),
                      InkWell(
                        onTap: () {
                          _verifyPhoneNumber();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              Text(
                                "Didn't receive " + "SMS? ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Resend",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading ? Utility.progress(context) : Container(),
        ],
      ),
    );
  }

  _onButtonClick() {
    if (currController.text.trim() == "" ||
        controller1.text.trim() == "" ) {
      Fluttertoast.showToast(msg: "Please enter valid verification code.");
    } else {
      verifyOtp(controller1.text.trim());
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }



  addNewUser(String? displayName, String? email, String? phoneNumber) async {
    CreateCustomer customer = getCustomerDetailsPref();
    if (displayName != null) {
      phoneNumber = phoneNumber.toString().replaceFirst('20', '+200');
      customer.billing.first_name =
          customer.first_name = displayName.split(" ")[0];
      customer.billing.last_name = customer.last_name =
      displayName.split(" ").length > 1 ? displayName.split(" ")[1] : "";
    }
    customer.billing.email = customer.email = customer.billing.email = phoneNumber.toString()+'@nourrestaurant.com';

    customer.billing.phone = phoneNumber;
    // customer.username = displayName;
    customer.username = phoneNumber.toString();

    setCustomerDetailsPref(customer);
    setState(() {
      isLoading = true;
    });
    await addToWoocommerce(customer);
    // moveToNext();
  }


  Future<void> addToWoocommerce(CreateCustomer _cCustomer) async {
    GetCustomer? customer =
    await WooHttpRequest().getCustomer(_cCustomer.billing.phone.toString());
    print('customer condition');
    if (customer != null) {
      print('customer not null');

      UpdateCustomer updateCustomer =
      UpdateCustomer.fromJson(_cCustomer.toJson());
      CreateCustomerResponce? createCustomerResponce =
      await WooHttpRequest().updateNewUser(customer.id, updateCustomer);
      if (createCustomerResponce != null) {
        print('createCustomerResponce not null');

        prefs!.setInt(USERID, createCustomerResponce.id);
        moveToNext();
      }
      print('createCustomerResponce null');

      print(createCustomerResponce);
    } else {
      print('customer null');

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
    Navigator.pushReplacementNamed(context, widget.redirectTo!,
        arguments: {'_amount': widget.amount, '_freeShipment': widget.isFreeShipment});
  }

}