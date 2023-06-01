
import '../emuns/apptheme.dart';
import '../emuns/apptypes.dart';


const String APPNAME = "Fool Nour";
const AppType APPTYPE = AppType.Wooflux;
const AppTheme AppThem = AppTheme.food;


final int TabBarCount=(APPTYPE == AppType.WCFM || APPTYPE == AppType.Dokan)?5:4;

const String WOOCOMM_AUTH_USER="ck_c32d424f9b0835981d016c2a90952589222408d2";
final String WOOCOMM_AUTH_PASS="cs_69c2d7080c83f92a5de70049074c92eb6532ad1b";
final String WOOCOMM_URL="https://nourrestaurant.com/";
final String JWT_AUTH="${WOOCOMM_URL}wp-json/jwt-auth/v1/";
final String WP_JSON_WC="${WOOCOMM_URL}wp-json/wc/v3/";
final String WP_JSON_WP_V2="${WOOCOMM_URL}wp-json/wp/v2/";
final String WC_API="${WOOCOMM_URL}wc-api/v3/";
final String DOKAN_API="${WOOCOMM_URL}wp-json/dokan/v1/";
final String WCFMMP_API="${WOOCOMM_URL}wp-json/wcfmmp/v1/";
final String WOOCOMM_JWT_USERNAME="adminver_temp";
final String WOOCOMM_JWT_USERPASS="adminver_temp";
final String HEROKUTOKEN_SERVER="https://frozen-shelf-98661.herokuapp.com/";

final String PAYPAL_SERVER="https://api.sandbox.paypal.com/v1/";
final String PAYPAL_AUTH_USER="ASUprWf4OvEmdk7A-popKTMPPR8ydLScQ4l6iMH8RjgdnoadF5IfejQOXvek5YbXLwgevpp1RlnBBini";
final String PAYPAL_AUTH_PASS="EJK_zjIdQaLc0hWhHdCdN0oIU2HpPscMJb6KhNoZ4802MxpfFavRqeU4Z9tc8ygfCYBxIIJFwijVrWuK";

final String TAP_SERVER="https://api.tap.company/v2/";
final String TAP_KEY="sk_test_EZAcdDz9HOK5btlQfGUmVCxY";

final String RAZORPAY_AUTH_KEY="rzp_test_ObGkZmgnOpNvGj";
final String RAZORPAY_AUTH_SECRET="XGfK8CgeGFhqjvU7JnGZVU3k";

final String STRIPE_AUTH_KEY="pk_test_kq0hzGi8SzZ8EWApGh1rsWIM00OhpDxCeI";
final String STRIPE_AUTH_SECRET="sk_test_y1g6whrQvDcmalQDYNIahG0g00UN2r1etT";

//final String WOOCOMM_SERVER="https://perfectlypressed.co/wp-json/wc/v3/";
//final String WOOCOMM_AUTH_USER="ck_c978a112d514d93af20cea6f5cde9876ce91a076";
//final String WOOCOMM_AUTH_PASS="cs_27526f5931adafb9bd330a1f097ee4af99ef60df";



//-------------------------Shared Preferences----------------------//
final String ISFIRSTOPEN="isfirstopen";
final String ISLOGIN="islogin";
final String ISGRID="isGrid";
final String CARTPRODUCTS="cardProducts";
final String RECENTSVIEWED="recents";
final String WISHLIST="Wishlist";
final String CUSTOMERDETAILS="customerDetails";
final String USERID="userid";
final String LANGUAGE="Language";
final String DARKTHEME="darkTheme";


//-------------------------MULTI LANGUAGE SUPPORT----------------------//

const String PRICE = "Price";
const String POPULARPRODUCTS = "Popular Products";
const String SEARCHFORPRODUCTS = "Search Products";
const String TOTALSALES = "Total Sales";
const String COST = "Cost";
const String PROCESSINGORDERREQUEST = "Processing Order Request";
const String PAYMENTDESCRIPTION = "Make order easy for your selected products with a straightforward, Click on submit order to continue payment and order delivery to your personal addresds .";
const String TOTAL = "Total";
const String SHIPPINGNOTAVAILABLE = "shipping not availble for now";
const String GOTOPAYMENT = "Go To Payment";
const String PRODUCTSCART = "Products Cart";
const String SUBTOTAL = "SubTotal";
const String CHECKOUTPRICE = "Checkout Price";
const String CHECKOUT = "CheckOut";
const String SETTING = "Setting";
const String PROFILESETTING = "Profile Setting";
const String GENERALSETTING = "General Setting";
const String ABOUTUS = "About Us";
const String DashBord = "DashBord";
const String ABOUTUSSHORTDESCRIPTION = "A collaborative community for anyone interested in developing apps using Flutter and Dart.";
const String CONTACTUS = "Connect Us";
const String DETAILEDPRODUCT= "Detailed Product";
const String DESCRIPTION = "Description";
const String SHORTDESCRIPTION = "Short Description";
const String DETAILS = "Details";
const String ADDTOCART = "Add to cart";
const String ORDERHISTORY = "Order History";
const String ORDERDELIVERYTO = "Order delivery to";
const String CHARGES = "Charges";
const String UPDATEPROFILE = "Update profile";
const String REMOVE = "Remove";
const String SEARCHFILTERS = "Search Filters";
const String SELECTREVIEWRATING = "Select Review Rating";
const String SUBMITFILTER = "Submit Filter";
const String FIRSTNAME = "FirstName";
const String LASTNAME = "LastName";
const String EMAIL = "Email";
const String COMPANY = "Company";
const String ADDRESS = "Address";
const String CITY = "City";
const String STATE = "State";
const String POSTALCODE = "PostalCode";
const String COUNTRY = "Country";
const String PHONE = "Phone";
const String SAVE = "Save";
const String PROFILEUPDATE = "Profile Update";
const String WHISHLIST = "Wishlist";
const String ORDERS = "Orders";
const String RATEAPP = "Rate App";
const String SHARE = "Share";
const String LOGOUT = "LogOut";
const String LOGIN = "LogIn";
const String THEMEOPTIONS = "Theme Options";

const String CLEAR = "Clear";
const String NOTAVAILABLEFORNOW = "Not available for now";
const String BYCATEGORY = "By Category";
const String HOME = "Home";
const String ENTERCOUPON = "Enter Coupon";
const String APPLY = "Apply";
const String COUPONNOTFOUND = "Coupon not found";
const String REENTERCOUPON = "Re Enter Coupon";
const String COUPONAPPLIED = "Coupon Applied";
const String FREE = "Free";
const String REMOVEFROMCART = "Remove from cart";
const String CATEGORIES = "Categories";
const String TAGS = "Tags";
const String TOPSELLING = "Top Selling";
const String FEATURED = "Featured";
const String ALLPRODUCTS = "All Products";
const String TRENDING = "Trending";
const String RECENTS = "Recents";
const String ADDFROMWISHLIST = "Add from wishlist";
