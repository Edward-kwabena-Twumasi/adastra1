// import 'package:flutter/material.dart';
// import 'package:flutter_routes/screens/main_screen.dart';
// import 'package:flutter_routes/screens/register_shop_screen.dart';
//
// class RouteManager{
//   static const String home='/';
//   static const String menu='/menu';
//   static const String login='/login';
//
//   static Route<dynamic> generateRoute(RouteSettings routeSettings){
//     switch(routeSettings.name){
//       case home:
//         return MaterialPageRoute(builder: (context)=>MainPage());
//       case menu:
//         return MaterialPageRoute(builder: (context)=>ShopRegistrationScreen());
//
//       default:
//         throw FormatException("Page not Found");
//     }
//   }
// }