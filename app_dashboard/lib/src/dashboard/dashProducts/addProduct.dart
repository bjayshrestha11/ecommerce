// import 'package:flutter/material.dart';
// import 'package:foodly/components/appbar.dart';
// import 'package:foodly/constants/colors.dart';
// import 'package:foodly/constants/icons.dart';
// import 'package:foodly/models/product.dart';
// import 'package:foodly/services/db_services.dart';
// import 'package:foodly/utilities/utils.dart';

// class AddProduct extends StatefulWidget {
//   final Product product;
//   AddProduct({this.product});
//   @override
//   _AddProductState createState() => _AddProductState();
// }

// class _AddProductState extends State<AddProduct> {
//   TextEditingController _name;
//   TextEditingController _categoryId;
//   TextEditingController _description;
//   TextEditingController _imageUrl;
//   TextEditingController _regularPrice;
//   TextEditingController _salePrice;
//   GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _editMode;
//   bool _processing;

//   @override
//   void initState() {
//     _processing = false;
//     _editMode = widget.product != null;
//     _name = TextEditingController(text: _editMode ? widget.product.name : null);
//     _categoryId = TextEditingController(
//         text: _editMode ? widget.product.categoryId : null);
//     _description = TextEditingController(
//         text: _editMode ? widget.product.description : null);
//     _regularPrice = TextEditingController(
//         text: _editMode ? widget.product.regularPrice.toString() : null);
//     _salePrice = TextEditingController(
//         text: _editMode ? widget.product.salePrice.toString() : null);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _name.dispose();
//     _description.dispose();
//     _imageUrl.dispose();
//     _regularPrice.dispose();
//     _salePrice.dispose();
//     _categoryId.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _key,
//       appBar: CustomAppBar(
//         leading: IconButton(
//             icon: backIcon,
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         title: RichText(
//           text: TextSpan(
//             style: TextStyle(color: black, fontSize: 26.0),
//             children: <TextSpan>[
//               TextSpan(text: "Add "),
//               TextSpan(text: "Product", style: TextStyle(color: mainCol)),
//             ],
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(30.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 //name
//                 TextFormField(
//                   validator: (val) {
//                     if (val.isEmpty) return "*Title can't be empty.";
//                     return null;
//                   },
//                   controller: _name,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.title),
//                     labelText: "Title",
//                     labelStyle: TextStyle(color: Colors.black),
//                     hintText: _name == null ? "Enter Title" : _name.text,
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 //image
//                 //description
//                 TextFormField(
//                   validator: (val) {
//                     if (val.isEmpty) return "*Description can't be empty.";
//                     return null;
//                   },
//                   controller: _description,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 5,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     // prefixIcon: Icon(Icons.description),
//                     labelText: "Description",
//                     labelStyle: TextStyle(color: Colors.black),
//                     hintText: _description == null
//                         ? "Enter Description"
//                         : _description.text,
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 //regular Price
//                 TextFormField(
//                   validator: (val) {
//                     // if (val.isEmpty) return "*Regular Price can't be empty.";
//                     return null;
//                   },
//                   controller: _regularPrice,
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.money_off),
//                     labelText: "Regular Price",
//                     labelStyle: TextStyle(color: Colors.black),
//                     hintText: _regularPrice == null
//                         ? "Enter Regular Price"
//                         : _regularPrice.text,
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 //sale Price
//                 TextFormField(
//                   validator: (val) {
//                     // if (val.isEmpty) return "*Regular Price can't be empty.";
//                     return null;
//                   },
//                   controller: _salePrice,
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.attach_money),
//                     labelText: "Sale Price",
//                     labelStyle: TextStyle(color: Colors.black),
//                     hintText: _salePrice == null
//                         ? "Enter Sale Price"
//                         : _salePrice.text,
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 //category Id

//                 //save Button
//                 RaisedButton(
//                   color: mainCol,
//                   child:
//                       _processing ? CircularProgressIndicator() : Text("Save",style: TextStyle(color: bgCol),),
//                   onPressed: _processing
//                     ? null
//                     : ()async {
//                       setState(() {
//                           _processing = true;
//                         });
//                         Product product = Product(
//                           name: _name.text,
//                           description: _description.text,
//                           categoryId: _categoryId.text,
//                           imageUrl: _imageUrl.text,
//                           regularPrice: Utils.strToInt(_regularPrice.text),
//                           salePrice: Utils.strToInt(_salePrice.text),
//                         );
//                         if(_formKey.currentState.validate()){
//                           try{
//                             if (_editMode) {
//                               await productItemDb.updateItem(product);
//                             } else {
//                               await productItemDb.createItem(product);
//                             }
//                             setState(() {
//                               _processing = false;
//                             });
//                             Navigator.pop(context);
//                           }catch(e){
//                             setState(() {
//                               _processing = false;
//                             });
//                             Utils.showToast("Something Went Wrong");
//                           }
//                         }
//                     },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
