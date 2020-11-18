import 'database_item.dart';

class Brand extends DatabaseItem {
  final String id;
  final String brandName;
  final String imageUrl;
  // final int count;

  Brand({
    this.brandName,
    this.id,
    this.imageUrl,
    // this.count,
  }) : super(id);

  Brand.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        brandName = data['brandName'],
        imageUrl = data['imageUrl'],
        // count = data['count'],
        super(id);

  Map<String, dynamic> toMap() => {
        "brandName": brandName,
        "imageUrl": imageUrl,
        // "count": count,
      };
}
