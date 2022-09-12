import 'package:donforget/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: EdgeInsets.only(left:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: title_style,
            ),
            Container(
                width: SizeConfig.screenWidth,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: controller,
                          autofocus: false,
                          cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                          readOnly: widget!=null?true:false,
                          style: Sub_title_style,
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: Sub_title_style,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:context.theme.backgroundColor,width: 0) ,
                             ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:context.theme.backgroundColor,width: 0) ,
                             ),


                          ),
                        )),
                    widget ?? Container(),
                  ],
                )),
          ],
        ));
  }
}
