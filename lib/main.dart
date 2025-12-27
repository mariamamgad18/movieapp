import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Ui/Layout_Pages.dart';
import 'package:movieapp/forgetpassword/forgetpassword_screen.dart';
import 'package:movieapp/register/register_screen.dart';
import 'package:movieapp/resetpassword/resetpassword_screen.dart';
import 'package:movieapp/update/profile_screen.dart';

import 'Api/Api_Manager.dart';
import 'Cubit/FavoriteCubit/FavoriteCubit.dart';
import 'Cubit/My_Bloc_Observer.dart';
import 'Data/ProfileData/DataSource/Impl/ProfileRemoteDataSourceImpl.dart';
import 'Data/ProfileData/Repository/Impl/ProfileRepositoryImpl.dart';
import 'Ui/MovieDeatails/MovieDetailsScreen.dart';
import 'Ui/login/LoginPage.dart';
import 'Ui/onboarding_screen.dart';
import 'Utils/AppRouteNames.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoriteCubit(
            ProfileRepositoryImpl(
              profileRemoteDataSource: ProfileRemoteDataSourceImpl(
                apiManager: ApiManager(),
              ),
            ),
            ApiManager(),
          )..loadFavorites(),
        ),
      ],
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: Approutenames.OnBoardingScreen,
      routes: {
        Approutenames.OnBoardingScreen: (context) => OnboardingScreens(),
        Approutenames.Login: (context) => Loginpage(),
        Approutenames.Register: (context) => RegisterScreen(),
        Approutenames.profile: (context) => ProfileScreen(),
        Approutenames.ForgetPassword:(context)=>ForgetPasswordScreen(),
        Approutenames.ResetPassword:(context)=>ResetPasswordScreen(),
        Approutenames.LayoutScreens:(context)=>LayoutScreen(),
        Approutenames.MovieDeatils: (context) {
          final movieId = ModalRoute.of(context)!.settings.arguments as int;
          return Moviedetailsscreen(movieId: movieId);
        },
      },
    );
  }
}



