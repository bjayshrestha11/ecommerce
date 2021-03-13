import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/models/order.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final Function(Order) onDelete;
  OrderTile({@required this.order,@required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      enabled: order.orderState != PROCESSING ,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => onDelete(order),
        ),
      ],
      child: ListTile(
        isThreeLine: true,
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: order.orderState != PROCESSING ? Colors.green : secondCol,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          "${Utils.getFirstInitials(order.orderDate.toString())}",
          style: TextStyle(fontSize: 13),
        ),
        subtitle: Text(
          "#${order.id}",
          style: TextStyle(fontSize: 10),
        ),
        trailing: Text(
          "\t\t$currency \n${order.totalAmount}",
          style: TextStyle(
            color: order.orderState != PROCESSING ? Colors.green : secondCol,
          ),
        ),
      ),
    );
  }
}
