import 'dart:ui';
import '../utils/consts.dart';
import '../utils/prefrences.dart';

class LocalLanguageString {
  String? languageCode;

  LocalLanguageString() {
    languageCode = getLanguageCode();
//    if(window!=null&&window.locales!=null&&!window.locales.isEmpty&&window.locales.length>2&&window.locales[1]!.languageCode!=null)
//      languageCode= window.locales[1]!.languageCode;
    if (languageCode == null || languageCode == "") languageCode = "en";
  }
  String get price =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PRICE]!;
  String get popularproducts =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![POPULARPRODUCTS]!;
  String get searchforproducts =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SEARCHFORPRODUCTS]!;
  String get totalsales =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![TOTALSALES]!;
  String get cost =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![COST]!;
  String get processingorderrequest =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PROCESSINGORDERREQUEST]!;
  String get paymentdescription =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PAYMENTDESCRIPTION]!;
  String get total =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![TOTAL]!;
  String get shippingnotavailable =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SHIPPINGNOTAVAILABLE]!;
  String get gotopayment =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![GOTOPAYMENT]!;
  String get productscart =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PRODUCTSCART]!;
  String get subtotal =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SUBTOTAL]!;
  String get checkoutprice =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![CHECKOUTPRICE]!;
  String get checkout =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode! : "en"]![CHECKOUT]!;
  String get setting =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SETTING]!;
  String get profilesetting =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PROFILESETTING]!;
  String get generalsetting =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![GENERALSETTING]!;
  String get aboutus =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ABOUTUS]!;
  String get dashbord =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![DashBord]!;
  String get aboutusshortdesc =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ABOUTUSSHORTDESCRIPTION]!;
  String get contactus =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![CONTACTUS]!;
  String get detailedproduct =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![DETAILEDPRODUCT]!;
  String get description =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![DESCRIPTION]!;
  String get shortdescription =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SHORTDESCRIPTION]!;
  String get details =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![DETAILS]!;
  String get addtocart =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ADDTOCART]!;
  String get orderhistory =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ORDERHISTORY]!;
  String get orderdeliveryto =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ORDERDELIVERYTO]!;
  String get charges =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![CHARGES]!;
  String get updateprofile =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![UPDATEPROFILE]!;
  String get wishlist =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![WISHLIST]!;
  String get remove =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![REMOVE]!;
  String get searchfilters =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SEARCHFILTERS]!;
  String get selectreviewrating =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SELECTREVIEWRATING]!;
  String get submitfilter =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SUBMITFILTER]!;
  String get firstname =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![FIRSTNAME]!;
  String get lastname =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![LASTNAME]!;
  String get email =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![EMAIL]!;
  String get company =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![COMPANY]!;
  String get address =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ADDRESS]!;
  String get city =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![CITY]!;
  String get state =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![STATE]!;
  String get postalcode =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![POSTALCODE]!;
  String get country =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![COUNTRY]!;
  String get phone =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PHONE]!;
  String get save =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SAVE]!;
  String get language =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![LANGUAGE]!;

  String get profileupdate =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![PROFILEUPDATE]!;
  String get orders =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ORDERS]!;
  String get rateapp =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![RATEAPP]!;
  String get share =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![SHARE]!;
  String get logout =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![LOGOUT]!;
  String get login =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![LOGIN]!;
  String get themeoptions =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![THEMEOPTIONS]!;

  String get clear =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![CLEAR]!;
  String get notavailable =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![NOTAVAILABLEFORNOW]!;
  String get bycategory =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![BYCATEGORY]!;
  String get home =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![HOME]!;
  String get entercoupon =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ENTERCOUPON]!;
  String get apply =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![APPLY]!;
  String get couponnotfound =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![COUPONNOTFOUND]!;
  String get reentercoupon =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![REENTERCOUPON]!;
  String get couponapplied =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![COUPONAPPLIED]!;
  String get free =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![FREE]!;
  String get removefromcart =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![REMOVEFROMCART]!;
  String get categories =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![CATEGORIES]!;
  String get topselling =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![TOPSELLING]!;
  String get featured =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![FEATURED]!;
  String get allproducts =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ALLPRODUCTS]!;
  String get tags =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![TAGS]!;
  String get trending =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![TRENDING]!;
  String get recents =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![RECENTS]!;
  String get addtowishlist =>
      _localizedValues[_localizedValues.containsKey(languageCode!)
          ? languageCode!
          : "en"]![ADDFROMWISHLIST]!;
}

Map<String, Map<String, String>> _localizedValues = {
  'en': {
    // English
    PRICE: PRICE,
    POPULARPRODUCTS: POPULARPRODUCTS,
    SEARCHFORPRODUCTS: SEARCHFORPRODUCTS,
    TOTALSALES: TOTALSALES,
    COST: COST,
    PROCESSINGORDERREQUEST: PROCESSINGORDERREQUEST,
    PAYMENTDESCRIPTION: PAYMENTDESCRIPTION,
    TOTAL: TOTAL,
    SHIPPINGNOTAVAILABLE: SHIPPINGNOTAVAILABLE,
    GOTOPAYMENT: GOTOPAYMENT,
    PRODUCTSCART: PRODUCTSCART,
    SUBTOTAL: SUBTOTAL,
    CHECKOUTPRICE: CHECKOUTPRICE,
    CHECKOUT: CHECKOUT,
    SETTING: SETTING,
    PROFILESETTING: PROFILESETTING,
    GENERALSETTING: GENERALSETTING,
    ABOUTUS: ABOUTUS,
    DashBord: DashBord,
    ABOUTUSSHORTDESCRIPTION: ABOUTUSSHORTDESCRIPTION,
    CONTACTUS: CONTACTUS,
    DETAILEDPRODUCT: DETAILEDPRODUCT,
    DESCRIPTION: DESCRIPTION,
    SHORTDESCRIPTION: SHORTDESCRIPTION,
    DETAILS: DETAILS,
    ADDTOCART: ADDTOCART,
    ORDERHISTORY: ORDERHISTORY,
    ORDERDELIVERYTO: ORDERDELIVERYTO,
    CHARGES: CHARGES,
    UPDATEPROFILE: UPDATEPROFILE,
    WISHLIST: WISHLIST,
    REMOVE: REMOVE,
    SEARCHFILTERS: SEARCHFILTERS,
    SELECTREVIEWRATING: SELECTREVIEWRATING,
    SUBMITFILTER: SUBMITFILTER,
    FIRSTNAME: FIRSTNAME,
    LASTNAME: LASTNAME,
    EMAIL: EMAIL,
    COMPANY: COMPANY,
    ADDRESS: ADDRESS,
    CITY: CITY,
    STATE: STATE,
    POSTALCODE: POSTALCODE,
    COUNTRY: COUNTRY,
    PHONE: PHONE,
    SAVE: SAVE,
    LANGUAGE: LANGUAGE,
    PROFILEUPDATE: PROFILEUPDATE,
    ORDERS: ORDERS,
    RATEAPP: RATEAPP,
    SHARE: SHARE,
    LOGOUT: LOGOUT,
    LOGIN: LOGIN,
    THEMEOPTIONS: THEMEOPTIONS,

    CLEAR: CLEAR,
    NOTAVAILABLEFORNOW: NOTAVAILABLEFORNOW,
    BYCATEGORY: BYCATEGORY,
    HOME: HOME,
    ENTERCOUPON: ENTERCOUPON,
    APPLY: APPLY,
    COUPONNOTFOUND: COUPONNOTFOUND,
    REENTERCOUPON: REENTERCOUPON,
    COUPONAPPLIED: COUPONAPPLIED,
    FREE: FREE,
    REMOVEFROMCART: REMOVEFROMCART,
    CATEGORIES: CATEGORIES,
    TAGS: TAGS,
    TOPSELLING: TOPSELLING,
    FEATURED: FEATURED,
    ALLPRODUCTS: ALLPRODUCTS,
    TRENDING: TRENDING,
    RECENTS: RECENTS,
    ADDFROMWISHLIST: ADDFROMWISHLIST,
  },
  'ar': {
    // Arabic
    PRICE: 'السعر',
    POPULARPRODUCTS: 'المنتج الشعبية',
    SEARCHFORPRODUCTS: 'البحث عن المنتجات',
    TOTALSALES: "إجمالي المبيعات",
    COST: "",
    PROCESSINGORDERREQUEST: "جاري  إضافة الطلب",
    PAYMENTDESCRIPTION:
        "اجعل الطلب سهلاً لمنتجاتك المحددة بطريقة مباشرة ، انقر فوق إرسال الطلب لمواصلة الدفع وتسليم الطلب إلى إضافاتك الشخصية.",
    TOTAL: "مجموع",
    SHIPPINGNOTAVAILABLE: "الشحن غير متوفر الآن",
    GOTOPAYMENT: "انتقل إلى الدفع",
    PRODUCTSCART: "سلة المنتجات",
    SUBTOTAL: "المجموع الفرعي",

    CHECKOUTPRICE: "المجموع الإجمالي",
    CHECKOUT: "الدفع",
    SETTING: "ضبط",
    PROFILESETTING: "إعداد ملف التعريف",
    GENERALSETTING: "الإعداد العام",
    ABOUTUS: "معلومات عنا",
    DashBord: "لوحة التحكم",
    ABOUTUSSHORTDESCRIPTION:
        "مجتمع تعاوني لأي شخص مهتم بتطوير التطبيقات باستخدام Flutter و Dart.",
    CONTACTUS: "اتصل بنا",
    DETAILEDPRODUCT: "المنتج المفصل",
    DESCRIPTION: "وصف",
    SHORTDESCRIPTION: "وصف قصير",
    DETAILS: "تفاصيل",
    ADDTOCART: "أضف إلى السلة",
    ORDERHISTORY: "تاريخ الطلب",
    ORDERDELIVERYTO: "أجل التسليم إلى",

    CHARGES: "الإجمالي",
    UPDATEPROFILE: "تحديث الملف",
    WISHLIST: "قائمة الرغبات",
    REMOVE: "إزالة",
    SEARCHFILTERS: "مرشحات البحث",
    SELECTREVIEWRATING: "حدد تقييم التقييم",
    SUBMITFILTER: "إرسال عامل التصفية",
    FIRSTNAME: "الاسم الاول",
    LASTNAME: "الاسم الاخير",
    EMAIL: "البريد الإلكتروني",
    COMPANY: "شركة",
    ADDRESS: "عنوان",
    CITY: "مدينة",
    STATE: "حالة",
    POSTALCODE: "الكود البريدى",
    COUNTRY: "بلد",
    PHONE: "هاتف",
    SAVE: "حفظ",
    LANGUAGE: "لغة",
    PROFILEUPDATE: "تحديث الملف الشخصي",
    ORDERS: "الطلبات",
    RATEAPP: "قيم التطبيق",
    SHARE: "شارك",
    LOGOUT: "تسجيل خروج",
    LOGIN: "تسجيل الدخول",
    THEMEOPTIONS: "خيارات الموضوع",

    CLEAR: "حذف الإضافة",
    NOTAVAILABLEFORNOW: "غير متوفر حاليا",
    BYCATEGORY: "بالتصنيف",
    HOME: "الصفحة الرئيسية",
    ENTERCOUPON: "أدخل الكوبون",
    APPLY: "تطبيق",
    COUPONNOTFOUND: "لم يتم العثور على القسيمة",
    REENTERCOUPON: "إعادة إدخال القسيمة",
    COUPONAPPLIED: "تم تطبيق القسيمة",
    FREE: "مجانا",
    REMOVEFROMCART: "إزالة من السلة",
    CATEGORIES: "التصنيفات",
    TAGS: "العلامات",
    TOPSELLING: "الأكثر مبيعا",
    FEATURED: "متميز",
    ALLPRODUCTS: "جميع المنتجات",
    TRENDING: "الشائع",
    RECENTS: "تم عرضها مؤخرا",
    ADDFROMWISHLIST: "أضف من قائمة الرغبات",
  },
  'de': {
    // German
    PRICE: 'Preis',
    POPULARPRODUCTS: 'Beliebtes Produkt',
    SEARCHFORPRODUCTS: 'Produkt suchen',
    TOTALSALES: "Gesamtumsatz",
    COST: "Kosten",
    PROCESSINGORDERREQUEST: "Auftragsanforderung bearbeiten",
    PAYMENTDESCRIPTION:
        "Machen Sie die Bestellung für Ihre ausgewählten Produkte einfach. Klicken Sie auf Bestellung senden, um die Zahlung fortzusetzen und die Lieferung an Ihre persönlichen Adressen zu bestellen.",
    TOTAL: "Gesamt",
    SHIPPINGNOTAVAILABLE: "Versand vorerst nicht möglich",
    GOTOPAYMENT: "Zur Zahlung gehen",
    PRODUCTSCART: "Produkte Warenkorb",
    SUBTOTAL: "Zwischensumme",

    CHECKOUTPRICE: "Kaufabwicklungspreis",
    CHECKOUT: "Auschecken",
    SETTING: "Rahmen",
    PROFILESETTING: "Profileinstellung",
    GENERALSETTING: "Allgemeine Einstellung",
    ABOUTUS: "Über uns",
    DashBord: "ÜDashBords",
    ABOUTUSSHORTDESCRIPTION:
        "Eine kollaborative Community für alle, die Apps mit Flutter und Dart entwickeln möchten.",
    CONTACTUS: "Verbinden Sie uns",
    DETAILEDPRODUCT: "Detailliertes Produkt",
    DESCRIPTION: "Beschreibung",
    SHORTDESCRIPTION: "kurze Beschreibung",
    DETAILS: "Einzelheiten",
    ADDTOCART: "In den Warenkorb legen",
    ORDERHISTORY: "Bestellverlauf",
    ORDERDELIVERYTO: "Bestellung Lieferung an",

    CHARGES: "Gebühren",
    UPDATEPROFILE: "Profil aktualisieren",
    WISHLIST: "Wunschzettel",
    REMOVE: "Entfernen",
    SEARCHFILTERS: "Suchfilter",
    SELECTREVIEWRATING: "Wählen Sie Bewertung bewerten",
    SUBMITFILTER: "Filter senden",
    FIRSTNAME: "Vorname",
    LASTNAME: "Nachname",
    EMAIL: "Email",
    COMPANY: "Unternehmen",
    ADDRESS: "Adresse",
    CITY: "Stadt",
    STATE: "Zustand",
    POSTALCODE: "Postleitzahl",
    COUNTRY: "Land",
    PHONE: "Telefon",
    SAVE: "speichern",
    LANGUAGE: "Sprache",
    PROFILEUPDATE: "Profilaktualisierung",
    ORDERS: "Auftrag",
    RATEAPP: "Bewertungs App",
    SHARE: "Teilen",
    LOGOUT: "Ausloggen",
    LOGIN: "Anmeldung",
    THEMEOPTIONS: "Themenoptionen",

    CLEAR: "klar",
    NOTAVAILABLEFORNOW: "Derzeit nicht verfügbar",
    BYCATEGORY: "Nach Kategorie",
    HOME: "Zuhause",
    ENTERCOUPON: "Gutschein eingeben",
    APPLY: "Anwenden",
    COUPONNOTFOUND: "Gutschein nicht gefunden",
    REENTERCOUPON: "Gutschein erneut eingeben",
    COUPONAPPLIED: "Gutschein angewendet",
    FREE: "Frei",
    REMOVEFROMCART: "Aus dem Wagen nehmen",
    CATEGORIES: "Kategorien",
    TAGS: "Stichworte",
    TOPSELLING: "Meistverkauft",
    FEATURED: "Empfohlen",
    ALLPRODUCTS: "Alle Produkte",
    TRENDING: "Trend",
    RECENTS: "kürzlich",
    ADDFROMWISHLIST: "Von Wunschliste hinzufügen",
  },
  'fr': {
    // French
    PRICE: 'prix',
    POPULARPRODUCTS: 'Produit populaire',
    SEARCHFORPRODUCTS: 'Rechercher un produit',
    TOTALSALES: "Ventes totales",
    COST: "Coût",
    PROCESSINGORDERREQUEST: "Traitement de la demande de commande",
    PAYMENTDESCRIPTION:
        "Rendez la commande facile pour vos produits sélectionnés avec un simple, cliquez sur soumettre la commande pour continuer le paiement et la livraison de la commande à vos adresses personnelles.",
    TOTAL: "Total",
    SHIPPINGNOTAVAILABLE: "expédition non disponible pour l'instant",
    GOTOPAYMENT: "Aller au paiement",
    PRODUCTSCART: "Panier de produits",
    SUBTOTAL: "Total",

    CHECKOUTPRICE: "Prix de départ",
    CHECKOUT: "Check-out",
    SETTING: "Réglage",
    PROFILESETTING: "Réglage du profil",
    GENERALSETTING: "Réglage général",
    ABOUTUS: "À propos de nous",
    DashBord: "À DashBord",
    ABOUTUSSHORTDESCRIPTION:
        "Une communauté collaborative pour tous ceux qui souhaitent développer des applications à l'aide de Flutter et Dart.",
    CONTACTUS: "Connectez-nous",
    DETAILEDPRODUCT: "Produit détaillé",
    DESCRIPTION: "La description",
    SHORTDESCRIPTION: "brève description",
    DETAILS: "Détails",
    ADDTOCART: "Ajouter au chariot",
    ORDERHISTORY: "Historique des commandes",
    ORDERDELIVERYTO: "Livraison de la commande à",

    CHARGES: "Des charges",
    UPDATEPROFILE: "Mettre à jour le profil",
    WISHLIST: "Liste de souhaits",
    REMOVE: "Retirer",
    SEARCHFILTERS: "Filtres de recherche",
    SELECTREVIEWRATING: "Sélectionner la note de l'avis",
    SUBMITFILTER: "Soumettre un filtre",
    FIRSTNAME: "Prénom",
    LASTNAME: "Nom de famille",
    EMAIL: "Email",
    COMPANY: "Compagnie",
    ADDRESS: "Adresse",
    CITY: "Ville",
    POSTALCODE: "Etat",
    STATE: "Code postal",
    COUNTRY: "Pays",
    PHONE: "Téléphone",
    SAVE: "sauver",
    LANGUAGE: "Langue",
    PROFILEUPDATE: "Mise à jour du profil",
    ORDERS: "Ordre",
    RATEAPP: "Application de taux",
    SHARE: "Partager",
    LOGOUT: "Se déconnecter",
    LOGIN: "S'identifier",
    THEMEOPTIONS: "Options du thème",

    CLEAR: "Clair",
    NOTAVAILABLEFORNOW: "Pas disponible pour l'instant",
    BYCATEGORY: "Par catégorie",
    HOME: "Accueil",
    ENTERCOUPON: "Entrez le coupon",
    APPLY: "Appliquer",
    COUPONNOTFOUND: "Coupon non trouvé",
    REENTERCOUPON: "Re Enter Coupon",
    COUPONAPPLIED: "Coupon appliqué",
    FREE: "Libre",
    REMOVEFROMCART: "Retirer du panier",
    CATEGORIES: "catégories",
    TAGS: "Mots clés",
    TOPSELLING: "Meilleures ventes",
    FEATURED: "Mis en exergue",
    ALLPRODUCTS: "Tous les produits",
    TRENDING: "tendance",
    RECENTS: "recents",
    ADDFROMWISHLIST: "De la liste de souhaits",
  },
  'ja': {
    // Japanese
    PRICE: '価格',
    POPULARPRODUCTS: '人気商品',
    SEARCHFORPRODUCTS: '製品を検索',
    TOTALSALES: "総売上高",
    COST: "費用",
    PROCESSINGORDERREQUEST: "注文リクエストの処理",
    PAYMENTDESCRIPTION:
        "選択した製品を簡単に注文できるようにします。[注文を送信]!をクリックして、支払いを続行し、個人の住所に注文を配送します。",
    TOTAL: "合計",
    SHIPPINGNOTAVAILABLE: "現在、配送はご利用いただけません",
    GOTOPAYMENT: "支払いに行く",
    PRODUCTSCART: "製品カート",
    SUBTOTAL: "小計",

    CHECKOUTPRICE: "チェックアウト価格",
    CHECKOUT: "チェックアウト",
    SETTING: "設定",
    PROFILESETTING: "プロファイル設定",
    GENERALSETTING: "一般的な設定",
    ABOUTUS: "私たちに関しては",
    DashBord: "私たちに関しては",
    ABOUTUSSHORTDESCRIPTION: "FlutterとDartを使用してアプリを開発することに関心がある人のための共同コミュニティ。",
    CONTACTUS: "つながる",
    DETAILEDPRODUCT: "詳細な製品",
    DESCRIPTION: "説明",
    SHORTDESCRIPTION: "簡単な説明",
    DETAILS: "細部",
    ADDTOCART: "カートに追加",
    ORDERHISTORY: "注文履歴",
    ORDERDELIVERYTO: "への注文配送",

    CHARGES: "料金",
    UPDATEPROFILE: "プロフィールを更新",
    WISHLIST: "ほしい物リスト",
    REMOVE: "削除する",
    SEARCHFILTERS: "検索フィルター",
    SELECTREVIEWRATING: "レビューの評価を選択",
    SUBMITFILTER: "フィルターを送信",
    FIRSTNAME: "ファーストネーム",
    LASTNAME: "苗字",
    EMAIL: "Eメール",
    COMPANY: "会社",
    ADDRESS: "住所",
    CITY: "市",
    POSTALCODE: "状態",
    STATE: "郵便番号",
    COUNTRY: "国",
    PHONE: "電話",
    SAVE: "セーブ",
    LANGUAGE: "言語",
    PROFILEUPDATE: "プロファイルの更新",
    ORDERS: "注文",
    RATEAPP: "アプリを評価",
    SHARE: "共有",
    LOGOUT: "ログアウト",
    LOGIN: "ログインする",
    THEMEOPTIONS: "テーマオプション",

    CLEAR: "晴れ",
    NOTAVAILABLEFORNOW: "現在利用できません",
    BYCATEGORY: "カテゴリ別",
    HOME: "家",
    ENTERCOUPON: "クーポンを入力",
    APPLY: "申し込む",
    COUPONNOTFOUND: "クーポンが見つかりません",
    REENTERCOUPON: "クーポンを再入力",
    COUPONAPPLIED: "適用されたクーポン",
    FREE: "自由",
    REMOVEFROMCART: "カートから削除",
    CATEGORIES: "カテゴリー",
    TAGS: "タグ",
    TOPSELLING: "トップセラー",
    FEATURED: "特徴",
    ALLPRODUCTS: "すべての製品",
    TRENDING: "急上昇",
    RECENTS: "最近",
    ADDFROMWISHLIST: "ウィッシュリストから追加",
  },
  'es': {
    // Spanish
    PRICE: 'Precio',
    POPULARPRODUCTS: 'productos populares',
    SEARCHFORPRODUCTS: 'Buscar Productos',
    TOTALSALES: "Ventas totales",
    COST: "Costo",
    PROCESSINGORDERREQUEST: "Procesando solicitud de orden",
    PAYMENTDESCRIPTION:
        "Haga que el pedido sea fácil para sus productos seleccionados de forma sencilla. Haga clic en enviar pedido para continuar con el pago y la entrega del pedido a sus direcciones personales.",
    TOTAL: "Total",
    SHIPPINGNOTAVAILABLE: "envío no disponible por ahora",
    GOTOPAYMENT: "Ir al pago",
    PRODUCTSCART: "Carrito de productos",
    SUBTOTAL: "Total parcial",

    CHECKOUTPRICE: "Precio de pago",
    CHECKOUT: "Revisa",
    SETTING: "Ajuste",
    PROFILESETTING: "Ajustes de perfil",
    GENERALSETTING: "Ajustes generales",
    ABOUTUS: "Sobre nosotros",
    DashBord: "Sobre nosotros",
    ABOUTUSSHORTDESCRIPTION:
        "Una comunidad colaborativa para cualquier persona interesada en desarrollar aplicaciones usando Flutter y Dart.",
    CONTACTUS: "Conectanos",
    DETAILEDPRODUCT: "Producto detallado",
    DESCRIPTION: "Descripción",
    SHORTDESCRIPTION: "Breve descripción",
    DETAILS: "Detalles",
    ADDTOCART: "Añadir al carrito",
    ORDERHISTORY: "Historial de pedidos",
    ORDERDELIVERYTO: "Entrega de pedidos a",

    CHARGES: "Cargos",
    UPDATEPROFILE: "Actualización del perfil",
    REMOVE: "Eliminar",
    SEARCHFILTERS: "Filtros de búsqueda",
    SELECTREVIEWRATING: "Seleccionar calificación de revisión",
    SUBMITFILTER: "Enviar filtro",
    FIRSTNAME: "Nombre de pila",
    LASTNAME: "Apellido",
    EMAIL: "Correo electrónico",
    COMPANY: "Empresa",
    ADDRESS: "Habla a",
    CITY: "Ciudad",
    STATE: "Estado",
    POSTALCODE: "Código postal",
    COUNTRY: "País",
    PHONE: "Teléfono",
    SAVE: "Salvar",
    LANGUAGE: "idioma",
    PROFILEUPDATE: "Actualización de perfil",
    WISHLIST: "Lista de deseos",
    ORDERS: "Pedidos",
    RATEAPP: "Calificar aplicacion",
    SHARE: "Compartir",
    LOGOUT: "Cerrar sesión",
    LOGIN: "Iniciar sesión",
    THEMEOPTIONS: "Opciones de tema",

    CLEAR: "Claro",
    NOTAVAILABLEFORNOW: "No disponible por ahora",
    BYCATEGORY: "Por categoria",
    HOME: "Hogar",
    ENTERCOUPON: "Ingresar cupón",
    APPLY: "Aplicar",
    COUPONNOTFOUND: "Cupón no encontrado",
    REENTERCOUPON: "Volver a ingresar el cupón",
    COUPONAPPLIED: "Cupón Aplicado",
    FREE: "Gratis",
    REMOVEFROMCART: "Eliminar del carrito",
    CATEGORIES: "categorías",
    TAGS: "etiquetas",
    TOPSELLING: "Más vendidos",
    FEATURED: "Presentado",
    ALLPRODUCTS: "Todos los productos",
    TRENDING: "tendencias",
    RECENTS: "recientes",
    ADDFROMWISHLIST: "Agregar de la lista de deseos",
  },
};
