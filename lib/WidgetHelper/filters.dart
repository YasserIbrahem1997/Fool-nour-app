import '../models/api/dashboard/getDashboardProducts.dart';
import '../models/api/product/getProductsParent.dart';
import 'package:flutter/material.dart';
import '../emuns/ratingType.dart';
import '../utils/appTheme.dart';
import '../utils/languages_local.dart';
import '../screens/splashWidget.dart';
import 'package:collection/collection.dart';

class Filters extends StatefulWidget {

  const Filters({Key? key}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<Filters> {
  RatingType _selRating = RatingType.All;
  String _selTags = "";
  String _selCategory = "";
  String _selAttribute = "";
  String _selAttributeOption = "";

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    List<String> listTags=[];
    if(totalProducts!=null)
      totalProducts!.forEach((element) {
      if(element.tags.length>0) {
        Set<String> _override =listTags.toSet();
        _override.addAll(element.tags.map((e) => e.name ).toSet() );
        listTags=(_override.toList());
      }
    });

    Map<String,List<String>> listAttributes=Map();
    if(totalProducts!=null)
      totalProducts!.forEach((_product) {
      _product.attributes.forEach((attr) {
        if (attr.options.length > 0) {
          if (listAttributes.containsKey(attr.name)) {
            Set<String> _override = listAttributes[attr.name]!.toSet();
            _override.addAll(attr.options.toSet());
            listAttributes[attr.name] = _override.toList();
          } else
            listAttributes[attr.name] = attr.options;
        }
      });
    });

    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 20,left: 20),
          color: BackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16.0),
                child: Text(
                  LocalLanguageString().searchfilters,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MainHighlighter,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Header",
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Divider(height: 2,),
              SizedBox(height: 10.0),

              SizedBox(height: 10.0),
              Text(
                "Tags",
                style: TextStyle(
                  color: MainHighlighter,
                  fontSize: 17.0,
                  fontFamily: "Header",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: (listTags!=null && listTags.length>0)?listTags.map((tag) {
                      return _itemViewTags(tag,(){
                        setState(() {
                          _selTags = tag;
                        });
                      });
                    }).toList():[Container(child: Text("Nothing found"),)],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Category",
                style: TextStyle(
                  color: MainHighlighter,
                  fontSize: 17.0,
                  fontFamily: "Header",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: totalCategories!=null?totalCategories!.map((cat) {
                      return _itemViewCategory(cat.name,(){
                        setState(() {
                          _selCategory = cat.name;
                        });
                      });
                    }).toList():[Container(child: Text("Nothing found"),)],
                  ),
                ),
              ),

              SizedBox(height: 10.0),
              Text(
                "Attributes",
                style: TextStyle(
                  color: MainHighlighter,
                  fontSize: 17.0,
                  fontFamily: "Header",
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: (listAttributes!=null && listAttributes.length>0)?listAttributes.keys.map((attName) {
                      return _itemViewAttribute(attName,(){
                        setState(() {
                          _selAttribute = attName;
                        });
                      });
                    }).toList():[Container(child: Text("Nothing found"),)]
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: listAttributes[_selAttribute]!=null?listAttributes[_selAttribute]!.map((attrOptions) {
                        return _itemViewAttributeOptions(attrOptions,(){
                          setState(() {
                            _selAttributeOption = attrOptions;
                          });
                        });
                      }).toList():
                         [Container( )]
                  ),
                ),
              ),

              Divider(height: 2,),
              TextButton(
                child: Text(
                    LocalLanguageString().submitfilter
                ),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20.0)
                // ),
                // color: BackgroundColor,
                // textColor: NormalColor,
                onPressed: submit,
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      );
  }


  //------------------------TAGS --------------------------//
  Widget _itemViewTags(String tagsItem,Function callBack) {
    return GestureDetector(
      onTap: () => callBack(),
      child:  Container(
        constraints: BoxConstraints(minWidth: 60),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: NormalColor.withAlpha(30), width: 1),
            color:_selTags == tagsItem ?  NormalColor.withAlpha(20) : transparent
        ),
        child: Text(
          tagsItem,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Normal",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: _selTags == tagsItem
                ? MainHighlighter
                : NormalColor,
          ),
        ),
      ),
    );

  }


  //------------------------CATEGORIES --------------------------//
  Widget _itemViewCategory(String categoryItem,Function callBack) {
    return GestureDetector(
      onTap: () => callBack(),
      child:  Container(
        constraints: BoxConstraints(minWidth: 60),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: NormalColor.withAlpha(30), width: 1),
            color:_selCategory == categoryItem ?  NormalColor.withAlpha(20) : transparent
        ),
        child: Text(
          categoryItem,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Normal",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: _selCategory == categoryItem
                ? MainHighlighter
                : NormalColor,
          ),
        ),
      ),
    );

  }

  //------------------------ATTRIBUTES --------------------------//
  Widget _itemViewAttribute(String attributeItem,Function callBack) {
    return GestureDetector(
      onTap: () => callBack(),
      child:  Container(
        constraints: BoxConstraints(minWidth: 60),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: NormalColor.withAlpha(30), width: 1),
            color:_selAttribute == attributeItem ?  NormalColor.withAlpha(20) : transparent
        ),
        child: Text(
          attributeItem,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Normal",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: _selAttribute == attributeItem
                ? MainHighlighter
                : NormalColor,
          ),
        ),
      ),
    );

  }


  //------------------------ATTRIBUTESOPTIONS --------------------------//
  Widget _itemViewAttributeOptions(String attributeOptionItem,Function callBack) {
    return GestureDetector(
      onTap: () => callBack(),
      child:  Container(
        constraints: BoxConstraints(minWidth: 60),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: NormalColor.withAlpha(30), width: 1),
            color:_selAttributeOption == attributeOptionItem ?  NormalColor.withAlpha(20) : transparent
        ),
        child: Text(
          attributeOptionItem,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Normal",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: _selAttributeOption == attributeOptionItem
                ? MainHighlighter
                : NormalColor,
          ),
        ),
      ),
    );
  }

  //------------------------RATTINGS --------------------------//
  Widget _itemRating(RatingType _rating,Function callBack) {
    return GestureDetector(
      onTap: () => callBack(),
      child:  Container(
        constraints: BoxConstraints(minWidth: 60),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: NormalColor.withAlpha(30), width: 1),
            color:_selRating == _rating ?  NormalColor.withAlpha(20) : transparent
        ),
        child: Text(
          _rating.toString().split(".")[1],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Normal",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: _selRating == _rating
                ? MainHighlighter
                : NormalColor,
          ),
        ),
      ),
    );
  }

  _selectRating(RatingType _rating) {
    setState(() {
      _selRating = _rating;
    });
  }


  void submit() async {
    List<GetDashBoardProducts> _filteredproducts=[];
    List tempRating= _selRating==RatingType.All?[0.0,5.0]:
    _selRating==RatingType.Good?[3.5,5.0]:
    _selRating==RatingType.Average?[2.0,3.5]:
    _selRating==RatingType.Below?[0.0,2.0]:[0.0,5.0];



    totalProducts!.forEach((_product){
      if (double.parse(_product.average_rating)>=tempRating[0] && double.parse(_product.average_rating)<=tempRating[1]
        && (_selTags=="" || (_selTags!="" && _product.tags.contains(_selTags)) )
        && (_selCategory=="" || (_selCategory!="" && _product.categories.contains(_selCategory)) )
          ){

        ProductAttributes? productAttr =_product.attributes.firstWhereOrNull((_attrs) =>
            (_selAttribute=="" || (_selAttribute!="" && _attrs.name==_selAttribute)
            && (_selAttributeOption=="" || (_selAttributeOption!="" && _attrs.options.contains(_selAttributeOption)) )
            ) );
        if(productAttr!=null || _selAttribute=="")
          {
            _filteredproducts.add(_product);

          }
      }
    });

    Navigator.pushNamed(context, '/subproduct', arguments: {'_subProducts': _filteredproducts, '_title': "Filter"});
  }
}