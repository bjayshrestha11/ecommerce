
import 'database_item.dart';

class CaroSlide extends DatabaseItem{
  final String id;
  final String imageUrl;
  final String heading;
  final String subHeading;

  CaroSlide({this.imageUrl, this.id, this.heading, this.subHeading}):super(id);
 
  CaroSlide.fromDS(String id, Map<String,dynamic> data):
    id=id,
    heading=data['heading'],
    subHeading=data['subHeading'],
    imageUrl=data['imageUrl'],
    super(id);

  Map<String,dynamic> toMap() => {
    "heading":heading,
    "subHeading": subHeading,
    "imageUrl": imageUrl,
  };
}

