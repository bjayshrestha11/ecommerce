import 'database_item.dart';

class Category extends DatabaseItem {
  final String id;
  final String name;
  final String imageUrl;
  // final int count;

  Category({
    this.name,
    this.id,
    this.imageUrl,
    // this.count,
  }) : super(id);

  Category.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        name = data['name'],
        imageUrl = data['imageUrl'],
        // count = data['count'],
        super(id);

  Map<String, dynamic> toMap() => {
        "name": name,
        "imageUrl": imageUrl,
        // "count": count,
      };
}
