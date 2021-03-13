import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// App logo

const String logo = "assets/images/logo.png";

//Currency sign
const String currency = "Rs.";

//Users Role
const String ADMIN = "admin";
const String CUSTOMER = "customer";

//Firebase Collections
const String USERS_COLLECTION = "users";
const String CART_COLLECTION = "carts";
const ORDERS_COLLECTION = "orders";
const PRODUCTS_COLLECTION = "products";
const CATEGORIES_COLLECTION = "categories";
const BRANDS_COLLECTION = "brands";
const CAROSLIDE_COLLECTION = "carouselSlider";
const SALES_COLLECTION = "totalSale";

//Order state
const String PROCESSING = "processing";
const String COMPLETED = "completed";


const String EMAIL_FIELD = "email";
const String BLANK_IMAGE =
    "https://cdn1.dotesports.com/wp-content/uploads/2020/09/16115058/amongus2.jpg";


//Colors
//Main Color - red - appbar, bottombar
const Color mainCol = Color.fromRGBO(238, 58, 35, 1.0);
//Background Color - white
const Color bgCol = Color.fromRGBO(255, 255, 255, 1.0);
//Second Color - yellow - header
const Color secondCol = Color.fromRGBO(253, 180, 21, 1.0);
//Third Color - blackgrey - subtitle
const Color thirdCol = Color.fromRGBO(181, 173, 154, 1.0);
//Button Color - grey
const Color buttonCol = Color.fromRGBO(181, 173, 154, 1.0);
//Label, hint color
const Color textFieldCol = Colors.black54;
//text color
const Color black = Colors.black;
//Toast Color
const Color toastCol = Colors.redAccent;


// Icons
//Google Icon
const IconData googleIcon = FontAwesomeIcons.google;
//Facebook Icon
const IconData facebookIcon = FontAwesomeIcons.facebook;
//Explore
const IconData exploreIcon = Icons.explore;
//Offer
const IconData orderIcon = Icons.restaurant;
//Cart
const IconData cartIcon = Icons.shopping_cart;
//Profile
const IconData profileIcon = Icons.person;
//Leading app Icon
const Icon leadAppIcon = Icon(Icons.more_horiz);
//Add Icon
const Icon addIcon = Icon(Icons.add, color: bgCol, size: 30,);
//Cart Add Icon
const IconData cartaddIcon = Icons.add;
//Cart Subtract Icon
const IconData cartminusIcon = Icons.remove;
//Location
const Icon locationIcon = Icon(Icons.location_on, color: mainCol,);
//Down
const Icon downArrowIcon = Icon(Icons.keyboard_arrow_down, color: mainCol,);
//Search
const Icon searchIcon = Icon(Icons.search, color: buttonCol,);
//Back Arrow
const Icon backIcon = Icon(Icons.arrow_back_ios, color: buttonCol,);
//Clear Icon
const IconData clearIcon = Icons.clear;
//Edit Icon
const IconData EDIT_ICON = Icons.edit;
//Logout Icon
const IconData LOGOUT_ICON = FontAwesomeIcons.signOutAlt;
//Copy To Clipboard
const IconData COPYCLIPBOARD_ICON = Icons.content_copy;
//Dashboard Icon
const Icon dashboardIcon = Icon(Icons.dashboard, color: secondCol,);

//Orders
const IconData ordersIcon = Icons.assignment;
//Products
const IconData productsIcon = Icons.fastfood_outlined;
//Categories
const IconData categoriesIcon = Icons.category_outlined;
//Completed Orders
const IconData completedIcon = Icons.done_all;
//Processing Orders
const IconData processingIcon = Icons.hourglass_empty;
//Brands
const IconData brandsIcon = Icons.branding_watermark_outlined;


//Styles
const TextStyle cartTextStyle = TextStyle(color: bgCol);
const TextStyle tabRecognizerStyle = TextStyle(color: mainCol);
const TextStyle appTitleStyle = TextStyle(color: mainCol);