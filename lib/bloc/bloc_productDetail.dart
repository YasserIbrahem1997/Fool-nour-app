import 'dart:async';

class ProductDetailBloc{

  //-------------------------------------- SELECTIONS -------------------------------------//
  //Carousel selection
  final selectCarouselStreamController = StreamController<int>.broadcast();
  StreamSink<int> get selectCarouselType_sink => selectCarouselStreamController.sink;
  Stream<int> get selectCarouselType_counter => selectCarouselStreamController.stream;

  selectCarouselIndex(int index){
    selectCarouselType_sink.add(index);
  }

}

final ProductDetailBloc productDetailBloc=new ProductDetailBloc();