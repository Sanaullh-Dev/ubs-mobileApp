// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:ubs/pages/accounts/account_page.dart';
// import 'package:ubs/pages/login/controller/login_controller.dart';
// import 'package:ubs/pages/login/signup_page.dart';
// import 'package:ubs/sharing_widget/widget_fun.dart';
// import 'package:ubs/utils/constants.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LoginHome extends StatelessWidget {
//   const LoginHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//     StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return SingUp();
//           }
//         });
//   }
// }
