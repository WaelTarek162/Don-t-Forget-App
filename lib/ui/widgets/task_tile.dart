import '../../models/task.dart';
import 'package:donforget/ui/size_config.dart';
import 'package:donforget/ui/theme.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      width: SizeConfig.orientation == Orientation.landscape
        ? SizeConfig.screenWidth / 2
        : SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _get_color(task.color),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                    style: heading_style.copyWith(color: Colors.white)
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: heading_style.copyWith(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w300)
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.note!,
                    style:  heading_style.copyWith(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400)
                  ),
                ],
              ),
            ),
            ),
            Container(color: Colors.grey,height: 52,width: 1,),

            RotatedBox(
              quarterTurns:3,
              child: Text(
                task.isCompleted == 0 ? 'TO DO' : 'Completed',
                style:  heading_style.copyWith(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),

              ),
            ),

          ],
        ),
      ),
    );
  }

  _get_color(int? color) {
    if(color==0){return bluishClr;}
    else if(color==1){return pinkClr;}
    else if(color==2){return orangeClr;}
    else{return bluishClr;}
  }
}
