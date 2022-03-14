import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/layout/news_app/cubit/cubit.dart';
import 'package:my_shop/layout/shop_app/cubit/cubit.dart';
import 'package:my_shop/layout/shop_app/shop_layout.dart';
import 'package:my_shop/modules/bmi/bmi_screen.dart';
import 'package:my_shop/modules/messenger/messenger_screen.dart';
import 'package:my_shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_shop/shared/bloc_observer.dart';
import 'package:my_shop/shared/components/constants.dart';
import 'package:my_shop/shared/cubit/cubit.dart';
import 'package:my_shop/shared/cubit/states.dart';
import 'package:my_shop/shared/network/local/cache_helper.dart';
import 'package:my_shop/shared/network/remote/dio_helper.dart';
import 'package:my_shop/shared/styles/themes.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  // SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  late Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  bool? isDark;
  Widget? startWidget;

  MyApp({
    Key? key,
    this.isDark,
    this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
