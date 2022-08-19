import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/Web_View_Screen.dart';

////
Widget myListItemsWithCondition({list,context, myCondition}){
  ConditionalBuilder(
      condition: myCondition,
      builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder:(context,index)=> buildArticleItem( list[index],context),
      separatorBuilder: mySeparator ,
      itemCount: list.length) ,
  fallback:(context)=> Center(child: CircularProgressIndicator()) ,
  );}
////

Widget buildArticleItem(list,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(list['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),

            image: DecorationImage(

              image: NetworkImage('${list['urlToImage']}'),



              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 10,

        ),



        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child:

                  Text(

                    '${list['title']}',                  maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                  Text('${list['publishedAt']}',

                  style:TextStyle(

                    color: Colors.grey,

                  )

                ),

              ],

            ),

          ),

        ),





      ],

    ),

  ),
);

Widget mySeparator(context,index)=>Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Expanded(child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.grey,
      height: 1,
    ),
  )),
);

Widget defaultFormField({
  @required TextEditingController controller,
  TextInputType type,
  @required Function validate,
  Function onTap,
  Function onChange,

  @required String label,
  @required IconData prefix,
  bool isPassword=false,
  IconData suffix,
  Function suffixPressed,
})=>  TextFormField(
  controller: controller,
  keyboardType: type,
  onTap:onTap,
  onChanged: onChange,
  validator: validate,

  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix !=null? IconButton(
      onPressed:suffixPressed ,
      icon: Icon(
        suffix,
      ),
    ):null,
    border: OutlineInputBorder(),
  ),


  obscureText: isPassword,

);

void navigateTo(context,widget)=> Navigator.push(context,
MaterialPageRoute(builder: (context)=>widget),
);
