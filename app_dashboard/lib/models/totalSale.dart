import 'package:foodly_dashboard/models/database_item.dart';

class TotalSale extends DatabaseItem {
  final String id;
  final DateTime updateDate;
  final int sale;

  TotalSale({this.id, this.updateDate, this.sale}) : super(id);
  factory TotalSale.fromDS(String id,Map<String, dynamic> json) => TotalSale(
        id: id,
        updateDate: json["updateDate"]?.toDate(),
        sale: json["sale"],
      );

  Map<String, dynamic> toMap() => {
        "updateDate": updateDate,
        "sale": sale,
      };
}
