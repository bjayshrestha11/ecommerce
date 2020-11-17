import 'database_item.dart';

class Product extends DatabaseItem{
  final String id;
  final String name;
  final String imageUrl;
  final int regularPrice;
  final int salePrice;
  final String categoryId;
  final String description;

  Product({this.name, this.id, this.imageUrl, this.regularPrice, this.categoryId,this.salePrice, this.description}):super(id);
 
  Product.fromDS(String id, Map<String,dynamic> data):
    id=id,
    name=data['name'],
    imageUrl=data['imageUrl'],
    regularPrice=data['regularPrice'],
    salePrice = data['salePrice'],
    categoryId = data['categoryId'],
    description = data['description'],
    super(id);

  Map<String,dynamic> toMap() => {
    "name":name,
    "imageUrl": imageUrl,
    "regularPrice" : regularPrice,
    "salePrice" : salePrice,
    "categoryId" : categoryId,
    "description" : description,
  };
}