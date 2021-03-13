import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/models/order.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutcommerce/views/admin/widgets/orderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class DashOrderTile extends StatelessWidget {
  final Order order;
  final Function(Order) onDelete;
  final Function(Order) onCompleted;
  final Function(Order) onProcessing;
  DashOrderTile({
    @required this.order,
    @required this.onDelete,
    @required this.onCompleted,
    @required this.onProcessing,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        order.orderState == COMPLETED
            ? IconSlideAction(
                caption: PROCESSING,
                color: secondCol,
                icon: Icons.done,
                onTap: () => onProcessing(order),
              )
            : IconSlideAction(
                caption: COMPLETED,
                color: Colors.blue,
                icon: Icons.done,
                onTap: () => onCompleted(order),
              ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => onDelete(order),
        ),
      ],
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return OrderDetails(
              order: order,
            );
          }));
        },
        isThreeLine: true,
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: order.orderState != PROCESSING ? Colors.green: secondCol,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          "${order.emailAddress}",
          style: TextStyle(fontSize: 13),
        ),
        subtitle: Text(
          "${Utils.getFirstInitials(order.orderDate.toString())}",
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
