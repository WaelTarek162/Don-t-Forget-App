import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


const Color bluishClr = Color.fromRGBO(10,210,226,1);//Color(0xFF4e5ae8);
const Color orangeClr = Color.fromRGBO(220,81,38,1);//Color(0xCFFF8746);
const Color pinkClr = Color.fromRGBO(140, 32, 85, 1);//Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {

  static final light_theme=ThemeData(
      primaryColor:primaryClr,
      backgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final dark_theme=ThemeData(
      primaryColor: darkGreyClr,
      backgroundColor: darkGreyClr,
    brightness: Brightness.dark
  );



}


TextStyle get heading_style{
  return TextStyle(

        color:Get.isDarkMode? Colors.white:Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,


  );
}

TextStyle get Sub_Heading_style{
  return  TextStyle(

        color:Get.isDarkMode? Colors.white:Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,


  );
}

TextStyle get title_style{
  return TextStyle(

        color:Get.isDarkMode? Colors.white:Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,


  );
}

TextStyle get Sub_title_style{
  return TextStyle(

        color:Get.isDarkMode? Colors.white:Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,


  );
}

TextStyle get body1_style{
  return TextStyle(

        color:Get.isDarkMode? Colors.white:Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,


  );
}

TextStyle get body2_style{
  return  TextStyle(

        color:Get.isDarkMode? Colors.grey[200]:Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,


  );
}