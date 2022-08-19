import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/search/Search_Screen.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:news_app/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<NewsCubit,NewsStates>(
   listener:(BuildContext context,NewsStates states){},
   builder:(BuildContext context,NewsStates states){
     var cubit=NewsCubit.get(context);

     return  Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            icon:Icon(Icons.search),
            onPressed:(){
//هروح لسكرين السيرش
              navigateTo(context,SearchScreen());
            }, ),
          IconButton(
            icon:Icon(Icons.brightness_4_outlined),
            onPressed:(){
              AppCubit.get(context).changeAppMode();
            }, )
        ],
     ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     DioHelper.getData(
      //       url: 'v2/top-headlines',
      //       query: {
      //         'country':'eg',
      //         'category':'business',
      //         'apikey':'f64a8a67791a4c23a98bb1ebe9c2fcb7',
      //       },
      //     ).then((value)
      //     {
      //
      //       print(value.data['articles'][0]['title']);
      //     }
      //     ).catchError((error){
      //       print(error.toString());
      //     });
      //   },
      //   child: Icon(
      //     Icons.add
      //   ),
      // ),
      body:cubit.screens[cubit.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
       items: cubit.bottomItems,
       currentIndex:cubit.currentIndex,
       onTap: (index){
        cubit.changeBottomNavBar(index);
      },
    ),
  );
      },


    );
  }
}

