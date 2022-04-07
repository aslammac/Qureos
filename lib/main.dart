import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qureos/constants.dart';
import 'package:qureos/providers/auth.dart';
import 'package:qureos/screens/auth/auth_screen.dart';
import 'package:qureos/screens/main_screen.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Qureos',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            canvasColor: secondaryColor,
          ),
          home: auth.isAuth ? const MainScreen() : AuthScreen(),
          // return FutureBuilder(
          //     future: auth.tryAutoLogin(),
          //     builder: (ctx, AsyncSnapshot<bool> snapShot) {
          //       if (snapShot.data == null) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else if (snapShot.data == false)
          //         return AuthScreen();
          //       else
          //         return MainScreen();
          //     });
        ),
      ),
    );
  }
}
