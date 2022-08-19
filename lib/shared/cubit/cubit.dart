import 'package:flutter_bloc/flutter_bloc.dart';
import '../cache_helper.dart';
import 'states.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
static AppCubit get(context)=>BlocProvider.of(context);

bool isDark =false;
void changeAppMode({bool fromShared}){
  if(fromShared !=null)
  {
    isDark=fromShared;
    emit(AppChangeModeState());
  }else{

    isDark=!isDark;
    CacheHelper.putbool(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    }
    );
  }


}
}