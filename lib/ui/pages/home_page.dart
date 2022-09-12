import 'package:donforget/controllers/task_controller.dart';
import 'package:donforget/models/task.dart';
import 'package:donforget/services/notification_services.dart';
import 'package:donforget/services/theme_services.dart';
import 'package:donforget/ui/pages/add_task_page.dart';
import 'package:donforget/ui/pages/notification_screen.dart';
import 'package:donforget/ui/size_config.dart';
import 'package:donforget/ui/widgets/button.dart';
import 'package:donforget/ui/widgets/input_field.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:donforget/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestAndroidPermissions();
    _taskController.get_tasks();
  }

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selected_date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _addTaskBar(),
              _addDatePicker(),
              const SizedBox(
                height: 6,
              ),
              _show_tasks(),
              // _noTaskMessage()
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        leading: IconButton(
          onPressed: () {
            ThemeServices().switch_theme();
            // notifyHelper.displayNotification(
            //   title: 'Theme changed', body: 'lkjadm');
            // notifyHelper.scheduledNotification();
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: [
          IconButton(onPressed: (){
            notifyHelper.cancelAllNotification();
            _taskController.delete_Alltasks();

            print(notifyHelper);
            print(_taskController.taskList);
            print('**************');
          }, icon: Icon(Icons.clear_all_outlined)),
          const CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'), radius: 20),
          const SizedBox(
            width: 20,
          )
        ],
      );

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: heading_style.copyWith(fontSize: 18),
                  ),
                  Text('Sept'),
                  Text(
                    'Today',
                    style: Sub_Heading_style,
                  )
                ],
              ),
              // Expanded(
              // child:
              MyButton(
                  label: '+ Add task',
                  onTab: () async {
                    await Get.to(const AddTaskPage());
                    _taskController.get_tasks();
                  }),
              //),
            ],
          )
        ],
      ),
    );
  }

  _addDatePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 80,
        height: 120,
        dateTextStyle: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
        dayTextStyle:const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
        monthTextStyle:const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
        selectionColor: primaryClr,
        deactivatedColor: Colors.white,
        selectedTextColor: Colors.white,
        onDateChange: (newDate) {
          setState(() {
            _selected_date = newDate;
          });
        },
      ),
    );
  }

  _BottomSeet(
      {required String label,
      required Function() onTab,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? title_style
                : title_style.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  show_bottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.3
                  : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              task.isCompleted == 1
                  ? Container()
                  : _BottomSeet(
                      label: 'Task Completed',
                      onTab: () {
                        notifyHelper.cancelNotification(task);
                        _taskController.mark_completed(task: task);
                        Get.back();
                      },
                      clr: Colors.greenAccent),
              _BottomSeet(
                  label: 'Delete Task',
                  onTab: () {
                    notifyHelper.cancelNotification(task);
                    _taskController.delete_tasks(task: task);
                    Get.back();
                  },
                  clr: Colors.redAccent),
              Divider(
                color: Get.isDarkMode ? Colors.grey : darkGreyClr,
              ),
              _BottomSeet(
                  label: 'Cancel',
                  onTab: () {
                    Get.back();
                  },
                  clr: primaryClr),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _show_tasks() {
    return SingleChildScrollView(
      scrollDirection: SizeConfig.orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMessage(false);
        } else {
          return Wrap(
              alignment: WrapAlignment.start,
              children: _taskController.taskList.map((task) {
                
                print(DateFormat('EEEE').format(_selected_date));
                print(_selected_date);

                if (task.date == DateFormat.yMd().format(_selected_date) ||
                    task.repeat == 'Daily') {
                  String hour = task.startTime.toString().split(':')[0];
                  String minutes = task.startTime.toString().split(':')[1];
                  var date = DateFormat.jm().parse(task.startTime!);
                  var time = DateFormat('HH:mm').format(date);
                  notifyHelper.scheduledNotification(
                      int.parse(time.split(':')[0]),
                      int.parse(time.split(':')[1]),
                      task);
                  return AnimationConfiguration.staggeredList(
                    duration: Duration(milliseconds: 800),
                    position: _taskController.taskList.indexOf(task),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            show_bottomSheet(context, task);
                          }, //,
                          child: TaskTile(task: task),
                        ),
                      ),
                    ),
                  );
                }
                else if(check_week(_selected_date, task.date!)&&task.repeat=='Weekly'){
                  String hour = task.startTime.toString().split(':')[0];
                  String minutes = task.startTime.toString().split(':')[1];
                  var date = DateFormat.jm().parse(task.startTime!);
                  var time = DateFormat('HH:mm').format(date);
                  notifyHelper.scheduledNotification(
                      int.parse(time.split(':')[0]),
                      int.parse(time.split(':')[1]),
                      task);
                  return AnimationConfiguration.staggeredList(
                    duration: Duration(milliseconds: 800),
                    position: _taskController.taskList.indexOf(task),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            show_bottomSheet(context, task);
                          }, //,
                          child: TaskTile(task: task),
                        ),
                      ),
                    ),
                  );

                }
                else if(check_month(_selected_date, task.date!)&&task.repeat=='Monthly'){
                  String hour = task.startTime.toString().split(':')[0];
                  String minutes = task.startTime.toString().split(':')[1];
                  var date = DateFormat.jm().parse(task.startTime!);
                  var time = DateFormat('HH:mm').format(date);
                  notifyHelper.scheduledNotification(
                      int.parse(time.split(':')[0]),
                      int.parse(time.split(':')[1]),
                      task);
                  return AnimationConfiguration.staggeredList(
                    duration: Duration(milliseconds: 800),
                    position: _taskController.taskList.indexOf(task),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            show_bottomSheet(context, task);
                          }, //,
                          child: TaskTile(task: task),
                        ),
                      ),
                    ),
                  );

                }
                else
                  return Container(child: _noTaskMessage(true),);
              }).toList());
        }
      }),
    );
  }

  bool check_week(DateTime selected,String taskDate){

    var date=taskDate.split('/');
    String day=date[1];
    String mon=date[0];
    String year=date[2];
    if(day.length==1){day='0$day';}
    if(mon.length==1){mon='0$mon';}

    String week_name_sel=DateFormat('EEEE').format((selected));
    String week_name_taskd=DateFormat('EEEE').format(DateTime.parse('$year-$mon-$day 00:00:00.000'));


    if(week_name_sel==week_name_taskd)
      return true;

    return false;
  }
  bool check_month(DateTime selected,String taskDate){

    var date=taskDate.split('/');
    String day=date[1];
    String mon=date[0];
    String year=date[2];
    if(day.length==1){day='0$day';}
    if(mon.length==1){mon='0$mon';}

    String mon_sel=DateFormat.d().format((selected));
    String mon_taskd=DateFormat.d().format(DateTime.parse('$year-$mon-$day 00:00:00.000'));

print(mon_taskd);
print(mon_sel);
    if(mon_sel==mon_taskd)
      return true;

    return false;
  }

  _noTaskMessage(bool still_data) {
    
    if(still_data){

      return Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            child: SingleChildScrollView(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  direction: SizeConfig.orientation == Orientation.landscape
                      ? Axis.horizontal
                      : Axis.vertical,
                  children: [
                    SvgPicture.asset(
                      'images/task.svg',
                      height: 90,
                      semanticsLabel: 'Task',
                      color: Colors.greenAccent.withOpacity(0.6),
                    ),
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(
                      height: 5,
                    )
                        : const SizedBox(
                      height: 120,
                    ),
                    Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 0.8, vertical: 10),
                        child: Text(
                          'No Tasks for This Day!',
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Get.isDarkMode?Colors.white:Colors.black),
                          textAlign: TextAlign.center,
                        )),
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(
                      height: 5,
                    )
                        : const SizedBox(
                      height: 120,
                    ),
                  ],
                )),
          ),
        ],
      );
    }
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          child: SingleChildScrollView(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            direction: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            children: [
              SvgPicture.asset(
                'images/task.svg',
                height: 90,
                semanticsLabel: 'Task',
                color: primaryClr.withOpacity(0.6),
              ),
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(
                      height: 120,
                    ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.8, vertical: 10),
                  child: Text(
                    'You don\'t have any tasks yet! \n\n Add new Tasks to make your days productive!',
                    style: Sub_title_style,
                    textAlign: TextAlign.center,
                  )),
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(
                      height: 120,
                    ),
            ],
          )),
        ),
      ],
    );
  }



}
