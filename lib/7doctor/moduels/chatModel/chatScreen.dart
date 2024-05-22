import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/models/doctormodel.dart';
import 'package:doctorproject/models/messageModel.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bookingmodel/bookingscreen.dart';
import '../bookingmodel/firemanger.dart';

class ChatScreen extends StatelessWidget{
  userModel ?usermodel;
  DoctorModel ?doctorModel;
  BookScreen ? bookScreen;
  var messageController=TextEditingController();

  ChatScreen({
    this.usermodel,
    this.doctorModel
});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        DoctorCubit.get(context).getMessages(receiverId: usermodel!.uid!);
        return BlocConsumer<DoctorCubit,DoctorState>(
          listener: (context,DoctorState){},
          builder: (context,DoctorState){
            return  Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                  ),
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${usermodel?.image}',
                        ),
                        radius: 30,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        '${usermodel?.name}',
                        style: TextStyle(
                            color: Colors.black,
                          fontSize: 20
                        ),
                      )
                    ],
                  )
              ),
              body: ConditionalBuilder(
                condition: true,
                builder:(context)=>Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     Expanded(
                       child: ListView.separated(
                           itemBuilder: (context,index){
                             var message=DoctorCubit.get(context).messages[index];
                              if(DoctorCubit.get(context).model!.uid==message.senderId)
                                return BuildMyMessage(message);
                              return BuildMessage(message);

                           },
                           separatorBuilder: (context,index)=>SizedBox(
                             height: 15,
                           ),
                           itemCount: DoctorCubit.get(context).messages.length),
                     ),
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 7
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer ,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1

                            ),
                            borderRadius: BorderRadius.circular(15 )
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                DoctorCubit.get(context).openGalaryToSendImage();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.image
                                  ,
                                  color: Colors.grey,),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    hintText: 'type your message here...',
                                    border: InputBorder.none
                                ),
                              ),

                            ),

                            Container(
                              color: Colors.blue[800],
                              height: 60,
                              width: 60,

                              child: IconButton(
                                  onPressed: (){
                                    DoctorCubit.get(context).sendMessage(
                                        receiverId: usermodel!.uid!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                    );
                                    messageController.text='';
                                    print(usermodel!.name!);
                                    Appointment.instance.sendPushNotification(usermodel!.token!);

                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ) ,
                fallback: (context)=>Center(child: CircularProgressIndicator()),
              ),


            );
          },
        );
      },
    );

  }
  Widget BuildMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),



          )
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );
  Widget BuildMyMessage(MessageModel model)=>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5
      ),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),



          )
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );

}