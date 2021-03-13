import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';

class ThankYou extends StatelessWidget {
  // final String status;
  // ThankYou({this.status});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              // color: Colors.grey,
              width: double.infinity,
              margin: EdgeInsets.only(left: 35.0, right: 45.0, top: 30),
              height: 200.0,
              child: Stack(
                // overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: -35,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: CircleAvatar(
                        backgroundColor: mainCol,
                        child: Icon(Icons.check,color: Colors.white,),
                        radius: 30,
                      ),
                      radius: 35,
                    ),
                  ),
                  Positioned(
                    top: 50.0,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Thank You",
                          style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold),
                        ),
                        Text("_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",style: TextStyle(fontSize: 20.0,),),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text("Your order is successfully placed",style: TextStyle(fontSize: 14.0,color: Colors.black38),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 65.0, right: 65.0, top: Utils.getHeightByPercentage(context, 40)),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: mainCol,
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    // Navigator.of(context).pushNamed('/home');
                    // Navigator.pop(context);
                  },
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Text("Back To Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
