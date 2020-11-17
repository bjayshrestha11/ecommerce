import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: mainCol,
      ),
      width: double.maxFinite,
      height: 45.0,
      margin: EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 37.0, top: 20.0),
        child: RichText(
            text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "Get discounts on your first order",
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: "\nUse coupons on checkout",
              style: GoogleFonts.robotoMono(
                  fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ],
        )),
      ),
    );
  }
}
