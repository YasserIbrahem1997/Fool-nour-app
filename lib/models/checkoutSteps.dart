

import 'api/shippingZone/getShippingZone.dart';

class CheckOutStep{


  StepOne? stepOne;
  StepTwo? stepTwo;
  CheckOutStep(){
    stepOne=StepOne();
    stepTwo=StepTwo();
  }

}

class StepOne{
  GetShippingZone selectedShippingZone=GetShippingZone(0, "");
}
class StepTwo{
  int id=0;
  String title="";
  double shippmentCost=0.0;
}

