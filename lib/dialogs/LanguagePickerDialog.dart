import 'package:flutter/material.dart';
import '../utils/appTheme.dart';
import '../utils/prefrences.dart';

class LanguagePickerDialog extends StatefulWidget {
  Function refresh;
  LanguagePickerDialog(this.refresh);
  @override
  _LanguagePickerDialogState createState() => _LanguagePickerDialogState();
}

class _LanguagePickerDialogState extends State<LanguagePickerDialog> {
  Map<String,String> languages = {
    "English":"en",
    "Arabic":"ar",
    "German":"de",
    "French":"fr",
    "Japanese":"ja",
    "Spanish":"es",
  };
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Divider(),
            ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: []..addAll(
                      languages.keys.toList().map((key){
                        return GestureDetector(
                              onTap: (){
                                setLanguageCode(languages[key]!).then((value) {
                                    widget.refresh();
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20,bottom: 5,left: 10,right: 10),
                                child: Text(
                                  key,
                                  style: TextStyle(
                                      fontFamily: "Normal",
                                      color: NormalColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                              ),
                          );

                      }).toList()
                  ),
                )
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}