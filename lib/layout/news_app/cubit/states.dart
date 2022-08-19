abstract class NewsStates{}
class NewsInitialState extends NewsStates {}

class NewsChangeBottomNavBarState extends NewsStates{}

//هنعمل لكل سكرين 3 حالات

class NewsGetBusinessLodingState extends NewsStates{}
class NewsGetBusinessScceissState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates
{
  final String error;
  NewsGetBusinessErrorState(this.error);
}

//for sports
class NewsGetSportsLodingState extends NewsStates{}
class NewsGetSportsScceissState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates
{
  final String error;
  NewsGetSportsErrorState(this.error);
}

//for Science
class NewsGetScienceLodingState extends NewsStates{}
class NewsGetScienceScceissState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates
{
  final String error;
  NewsGetScienceErrorState(this.error);
}

//for seaarch
class NewsGetSearchLodingState extends NewsStates{}
class NewsGetSearchScceissState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}