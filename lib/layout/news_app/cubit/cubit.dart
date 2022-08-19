import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/Business_Screen.dart';
import 'package:news_app/modules/science/Science_Screen.dart';
import 'package:news_app/modules/settings/Settings_Screen.dart';
import 'package:news_app/modules/sports/Sports__Screen.dart';
import 'package:news_app/shared/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());
static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

List<BottomNavigationBarItem> bottomItems =[
  BottomNavigationBarItem(
  icon:Icon(Icons.add_business),
  label: 'Business Screen',
  ),
  BottomNavigationBarItem(
  icon:Icon(Icons.sports),
  label: 'Sports Screen',
  ),
  BottomNavigationBarItem(
  icon:Icon(Icons.science),
  label: 'Science Screen',
  ),
];

List<Widget> screens= [
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
];
void changeBottomNavBar(int index)
{
  currentIndex=index;
  if(index==1)
    getSports();
  if(index==2)
    getScience();
  emit(NewsChangeBottomNavBarState());

}

//for business
List<dynamic> business=[];

void getBusiness()
{
  emit(NewsGetBusinessLodingState());
  DioHelper.getData(
    url: 'v2/top-headlines',
    query: {
      'country':'eg',
      'category':'business',
      'apikey':'f64a8a67791a4c23a98bb1ebe9c2fcb7',
    },
  ).then((value)
  {//value.data['articles'][0]['title']
    business=value.data['articles'];
    print(business[0]['title']);

    emit(NewsGetBusinessScceissState());
  }
  ).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error));
  });
}

//for sports
  List<dynamic> sports=[];

  void getSports()
  {
    emit(NewsGetSportsLodingState());

    if(sports.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey':'f64a8a67791a4c23a98bb1ebe9c2fcb7',
          },
        ).then((value)
        {//value.data['articles'][0]['title']
          sports=value.data['articles'];
          print(sports[0]['title']);

          emit(NewsGetSportsScceissState());
        }
        ).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error));
        });
      }else
      emit(NewsGetSportsScceissState());

  }

  //for Science
  List<dynamic> science=[];

  void getScience()
  {
    emit(NewsGetScienceLodingState());

    if(science.length ==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',

            'apikey':'f64a8a67791a4c23a98bb1ebe9c2fcb7',
          },
        ).then((value)
        {//value.data['articles'][0]['title']
          science=value.data['articles'];
          print(science[0]['title']);

          emit(NewsGetScienceScceissState());
        }
        ).catchError((error){
          print(error.toString());
          emit(NewsGetScienceErrorState(error));
        });
      }else
      emit(NewsGetScienceScceissState());
  }


  //for search screen
  List<dynamic> search=[];

  void getSearch(String value)
  {
    emit(NewsGetSearchLodingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',

        //65f7f556ec76449fa7dc0069f040ca
        'apikey':'f64a8a67791a4c23a98bb1ebe9c2fcb7',
      },
    ).then((value)
    {
      search=value.data['articles'];

    emit(NewsGetSearchScceissState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }

}

