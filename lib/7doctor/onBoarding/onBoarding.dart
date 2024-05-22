import 'package:doctorproject/7doctor/moduels/loginmodel/loginscreen.dart';
import 'package:doctorproject/models/onBoardModel.dart';
import 'package:doctorproject/shared/components/shared/shared.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoard> item=[
    OnBoard(
        image: 'assets/images/doctornewonee.png'
        , title: 'Your Medicine in your hand.\nAnytime - Anywhere'),
    OnBoard(
        image: 'assets/images/doctornewone.png'
        , title: 'One app for all users all over the city'),
    OnBoard(
        image: 'assets/images/doctornewtwo.png'
        , title: 'Communicate with the best doctors in the world...'),



  ];

  bool isLast=false;

  var BoardingController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,

        ),
        actions: [
          TextButton(
              onPressed: (){
                SharedHelper.SaveData(
                    key: 'onBoard',
                    value: true).then((value) {
                      if(value){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                      }

                });

              }
              , child: Text(
            'Skip',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[800]
            ),
          ))
        ],

      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index==item.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }
                  else
                    {
                      setState(() {
                        isLast=false;
                      });

                    }
                },
                controller: BoardingController,
                  itemBuilder: (context,index)=>buildPageViewItem(item[index],context),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 20
              ),
              child: Row(
                children: [
                  SmoothPageIndicator(
                      controller: BoardingController,
                      count: item.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey.shade200,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                      activeDotColor: Colors.blue.shade800

                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.blue[800],
                      onPressed: (){

                        if(isLast){
                          SharedHelper.SaveData(key: 'onBoard', value: true).
                          then((value) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                          });
                        }
                        else {
                          BoardingController.nextPage(
                              duration: Duration(
                                  milliseconds: 750
                              )
                              , curve: Curves.fastEaseInToSlowEaseOut);
                        }
                      },
                    child: Icon(
                      Icons.navigate_next
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}