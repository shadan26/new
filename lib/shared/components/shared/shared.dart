import 'package:doctorproject/7doctor/moduels/bookingmodel/bookingscreen.dart';
import 'package:doctorproject/7doctor/moduels/chatModel/chatScreen.dart';
import 'package:doctorproject/models/onBoardModel.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildServiseItem(context,Map map)=> Column(

  children: [


    CircleAvatar(
      backgroundImage: NetworkImage(
          '${map['image']}'
      ),
      radius: 50,
    ),

    Expanded(
      child: Container(
        width:135 ,

        child: Text(

            '${map['name']}',

            maxLines:1,

            textAlign: TextAlign.center,



            style: Theme.of(context).textTheme.titleMedium!.copyWith(

                fontWeight:FontWeight.bold

            )

        ),

      ),
    )

  ],

);
Widget buildOnlineClinicItem(userModel usermodel,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadiusDirectional.circular(20)
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        Image(
            height: 170,
            width: 170,
            fit: BoxFit.cover,
            image:NetworkImage(
                '${usermodel.image}'
            )),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 170,
          padding: EdgeInsetsDirectional.only(
              bottom: 10,
              start: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Name : ${usermodel.name}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 16

                ),
              ),
              Text(
                'Major : ${usermodel.major}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 16

                ),
              ),
              Spacer(),
              Container(


                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadiusDirectional.circular(20)
                ),
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(usermodel: usermodel,)));

                },
                  child: const Text(
                    'Chat',
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold

                    ),
                  ),),
              )
            ],
          ),
        )
      ],
    ),
  ),
);
Widget buildInClinicItem(userModel usermodel,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(20),
      color: Colors.white,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20)

          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            height: 220,
            width: 170,
            image:NetworkImage(
                '${usermodel.image}'
            ),
            fit: BoxFit.cover,),
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 200,

                padding: EdgeInsetsDirectional.only(
                    bottom: 10,
                    start: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name : ${usermodel.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18

                      ),
                    ),
                    Text(
                      'Major : ${usermodel.major}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18

                      ),
                    ),
                    Text(
                      'Experience : 8 Years',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18

                      ),
                    ),
                    Text(
                      'Patients : 2800',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18

                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 170,
                      height: 35,

                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: MaterialButton(
                        onPressed:(){
                          switch(usermodel.id){
                            case 1:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                token: usermodel.token,
                                id: usermodel.id ,
                                statuss: usermodel.status,
                                name: usermodel.name,
                                major: usermodel.major,
                                email: usermodel.email,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                description: usermodel.cv,
                                image: usermodel.image,
                                uid: usermodel.uid,
                                usermodel: usermodel,
                              )));
                              break;
                            case 2:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                token: usermodel.token,
                                id: usermodel.id ,
                                statuss: usermodel.status,
                                name: usermodel.name,
                                major: usermodel.major,
                                email: usermodel.email,
                                usermodel: usermodel,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                description: usermodel.cv,
                                image: usermodel.image,
                                uid: usermodel.uid,
                              )));
                              break;
                            case 3:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                id: usermodel.id,
                                statuss: usermodel.status,
                                token: usermodel.token,
                                name: usermodel.name,
                                major: usermodel.major,
                                usermodel: usermodel,
                                email: usermodel.email,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                description: usermodel.cv,
                                image: usermodel.image ,
                                uid: usermodel.uid,
                              )));
                              break;
                            case 4:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                id: usermodel.id,
                                statuss: usermodel.status,
                                name: usermodel.name,
                                token: usermodel.token,
                                major: usermodel.major,
                                usermodel: usermodel,
                                email: usermodel.email,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                description: usermodel.cv,
                                image: usermodel.image ,
                                uid: usermodel.uid,
                              )));
                              break;
                            case 5:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                id: usermodel.id,
                                statuss: usermodel.status,
                                name: usermodel.name,
                                token: usermodel.token,
                                major: usermodel.major,
                                email: usermodel.email,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                description: usermodel.cv,
                                usermodel: usermodel,
                                image: usermodel.image,
                                uid: usermodel.uid,
                              )));
                              break;
                            case 6:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                id: usermodel.id,
                                statuss: usermodel.status,
                                name: usermodel.name,
                                major: usermodel.major,
                                token: usermodel.token,
                                email: usermodel.email,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                description: usermodel.cv,
                                usermodel: usermodel,
                                image: usermodel.image,
                                uid: usermodel.uid,
                              )));
                              break;
                            case 7:
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                                id: usermodel.id,
                                name: usermodel.name,
                                major: usermodel.major,
                                email: usermodel.email,
                                token: usermodel.token,
                                phone: usermodel.phone,
                                dateOfBirth: usermodel.date,
                                usermodel: usermodel,
                                description: usermodel.cv,
                                image: usermodel.image,
                                uid: usermodel.uid, statuss: usermodel.status,
                              )));
                              break;

                          }
                        },
                        child: Text(
                          'Book',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  ),
);
Widget buildPageViewItem(OnBoard board,context)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
          image: AssetImage(
              '${board.image}'
          )),
    ),
    Text(
        '${board.title}',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black
        )
    ),

  ],
);


