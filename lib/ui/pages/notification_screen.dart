import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  final String payload;

  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new,color: Get.isDarkMode?Colors.white:Colors.black,),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _payload.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                //      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello , Wael',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Get.isDarkMode ? Colors.white : darkGreyClr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You have a new reminder',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: primaryClr),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: const [
                              Icon(Icons.text_format_outlined, size: 35,),

                              SizedBox(width: 10,),
                              Text(
                                'Title',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),

                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text(_payload.toString().split('|')[0],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.description, size: 35,),
                              const SizedBox(width: 10,),
                              Text(
                                _payload.toString().split('|')[1],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.justify,
                              ),

                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text(_payload.toString().split('|')[1],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.date_range_outlined, size: 35,),
                              SizedBox(width: 10,),
                              Text(
                                'Date',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),

                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text(_payload.toString().split('|')[2],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
