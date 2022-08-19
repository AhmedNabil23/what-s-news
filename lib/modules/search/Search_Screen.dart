import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchScreen extends StatelessWidget{
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
          var list=NewsCubit.get(context).search;
         return Scaffold(
           appBar: AppBar(),
           body: Column(
             children: [
               //textFormField for search
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: defaultFormField(
                     controller: searchController,
                     validate: (String value){
                       if(value.isEmpty){
                         return 'search must not be empty';
                       }
                       return null;
                     },
                     label: 'Search',
                     prefix: Icons.search,
//مع كل تشينج هعمل سيرش
                     onChange:(value){
                        NewsCubit.get(context).getSearch(value);
                     }
                 ),
               ),

               //list of the returns from search
               Expanded(

                   child: ConditionalBuilder(
                     condition: state is! NewsGetSearchLodingState,
                     builder: (context)=>ListView.separated(
                         physics: BouncingScrollPhysics(),
                         itemBuilder:(context,index)=> buildArticleItem(list[index],context),
                         separatorBuilder: mySeparator ,
                         itemCount: list.length) ,
                     fallback:(context)=> Center(child: CircularProgressIndicator()) ,
                   ),

               )

             ],
           ),
         );
      }
      );
  }

}