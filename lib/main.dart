import 'package:cps_patient/domain/login_domain/login_repostry_impl.dart';
import 'package:cps_patient/presentation/login/cubit/login_cubit.dart';
import 'package:cps_patient/presentation/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cps_patient/presentation/styles/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginCubit(LoginRepositoryImpl());
      },
      child: MaterialApp(
        title: 'CPS Patient App',
        theme: AppTheme.themeData,
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const LoginScreen(),
      ),
    );
  }
}
