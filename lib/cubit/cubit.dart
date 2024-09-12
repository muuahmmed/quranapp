import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/cubit/states.dart';
import '../network/local/cachehelper.dart';

class QuranCubit extends Cubit<QuranStates> {
  QuranCubit() : super(InitialState());

  static QuranCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;
  ThemeMode appMode = ThemeMode.light;

  void changeAppMode() {
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark.toString()).then((value) {
      emit(ChangeAppMode());
    });
    appMode = isDark ? ThemeMode.dark : ThemeMode.light;
    print("App mode changed: $appMode");
    emit(ChangeAppMode());
  }
}
