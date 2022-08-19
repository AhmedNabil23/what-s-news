import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/cache_helper.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  //هنا بيشوف في قيمة للisDark  فCache دخلتلة قبل كدا  ومتسيفة
  bool isDark=CacheHelper.getbool(key: 'isDark');

runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //AppCubit
        BlocProvider( create:(BuildContext context)=>AppCubit()..changeAppMode(fromShared: isDark) ,),
        //NewsCubit (for Cunsumer in all screens)
       BlocProvider(create: (context)=>NewsCubit()..getBusiness()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              //light mode(by default)
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,

                scaffoldBackgroundColor: Colors.white,
                appBarTheme:AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme:IconThemeData(
                    color: Colors.black,
                  ) ,
                  titleTextStyle: TextStyle(

                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,

                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.deepOrange,
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor:Colors.white,
                ),
                textTheme: TextTheme(
                  bodyText1:TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),


              ),
              //dark mode
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,

                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme:AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme:IconThemeData(
                    color: Colors.white,
                  ) ,
                  titleTextStyle: TextStyle(

                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                  backgroundColor:HexColor('333739'),
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.deepOrange,
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor:HexColor('333739'),
                ),
                textTheme: TextTheme(
                  bodyText1:TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              //toggle ThemeMode.dark||ThemeMode.light
              themeMode: AppCubit.get(context).isDark?ThemeMode.dark :ThemeMode.light,

              home: NewsLayout(),
            );
          },
        ),
    );
  }
}

