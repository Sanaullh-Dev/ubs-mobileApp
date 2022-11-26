import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryColor = Color(0xFFFFBB00);
const Color secondaryColor= Color(0xFFFCD772);
const Color whiteColor = Color(0xFFFFFFFF);
const Color blackColor = Color(0x8B000000);
const Color greyColor = Color(0xFF929292);
const Color lightBlackColor = Color(0xFF5F5F5F);
const Color mainBorderColor = Color(0xFFB0BEC5);
const Color indicatorColor = Color(0xFF78909C);
const Color indicatorLightColor = Color(0xFF7C888E);
const borderColor = Color.fromRGBO(114, 178, 238, 1);
const errorColor = Color.fromRGBO(255, 234, 238, 1);
const fillColor = Color.fromRGBO(222, 231, 240, .57);

// const String API_URL = "http://localhost:8080";

// this link for emulator connect with api
// const String API_URL = "http://10.0.2.2:8080";

// this link for real device connect with api (for check ip command ipconfig)
// const String API_URL = "http://192.168.43.56:8080"; // my laptop
const String API_URL = "http://192.168.1.102:8080"; // my SPC PC

// AWS Host - Online API_URL;
// const String API_URL = "http://44.197.196.6:8080";

Map<int, Color> primarySwatchColor = const {
  50: Color.fromRGBO(255, 187, 0, .1),
  100: Color.fromRGBO(255, 187, 0, .2),
  200: Color.fromRGBO(255, 187, 0, .3),
  300: Color.fromRGBO(255, 187, 0, .4),
  400: Color.fromRGBO(255, 187, 0, .5),
  500: Color.fromRGBO(255, 187, 0, .6),
  600: Color.fromRGBO(255, 187, 0, .7),
  700: Color.fromRGBO(255, 187, 0, .8),
  800: Color.fromRGBO(255, 187, 0, .9),
  900: Color.fromRGBO(255, 187, 0, 1),
};

ThemeData getThemeData(double screenWidth) {
  return ThemeData(
    primarySwatch: MaterialColor(0xFFFFBB00, primarySwatchColor),
    textTheme: screenWidth < 500 ? TEXT_THEME_Small : TEXT_THEME_DEFAULT,
    fontFamily: "Poppins",
    appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: 0.9)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        backgroundColor: const Color(0xFF263238),
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  );
}

TextTheme TEXT_THEME_DEFAULT = TextTheme(
  headline1: const TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 26,
      fontFamily: "Roboto"),
  headline2: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  ),
  headline5: TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w600,
      fontSize: 35.sp,
      fontFamily: "Roboto"),
  headline6: TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w500,
    fontSize: 32.sp,
    letterSpacing: 0.8,
  ),
  bodyText1: const TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      height: 1.5),
  bodyText2: const TextStyle(
      color: greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 15,
      letterSpacing: 0.9,
      height: 1.5),
  subtitle1: const TextStyle(
      color: blackColor, fontWeight: FontWeight.w400, fontSize: 12),
  subtitle2: const TextStyle(
      color: lightBlackColor, fontWeight: FontWeight.w400, fontSize: 16),
  caption: TextStyle(
      color: greyColor, fontWeight: FontWeight.w400, fontSize: 25.sp),
  button: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.9,
  ),
);

TextTheme TEXT_THEME_Small = TextTheme(
  headline1: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 22,
  ),
  headline2: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  ),
  headline3: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  ),
  headline4: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  ),
  headline5: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  ),
  headline6: const TextStyle(
    color: blackColor,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  ),
  titleMedium: const TextStyle(
      color: Colors.red, fontWeight: FontWeight.w500, fontSize: 18),
  titleSmall: TextStyle(
      color: Colors.red, fontWeight: FontWeight.w400, fontSize: 15.sp),
  bodyText1: const TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.5),
  bodyText2: const TextStyle(
      color: greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 22,
      height: 1.5),
  subtitle1: TextStyle(
      color: blackColor, fontWeight: FontWeight.w400, fontSize: 18.sp),
  subtitle2: const TextStyle(
      color: greyColor, fontWeight: FontWeight.w400, fontSize: 10),
);

BoxDecoration favoriteBorder = BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 2, color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(100),
    boxShadow: const [
      BoxShadow(
        offset: Offset(1, 1),
        blurStyle: BlurStyle.normal,
        blurRadius: 5,
        color: Color(0x10000000),
      )
    ]);

BoxDecoration onlyTopBorder = BoxDecoration(
  color: Colors.white,
  border: Border(top: BorderSide(width: 2, color: Colors.grey.shade300)),
);

BoxDecoration onlyBottomBorder = BoxDecoration(
  color: Colors.white,
  border: Border(bottom: BorderSide(width: 2, color: Colors.grey.shade300)),
);

TextStyle snackbarTextStyle = const TextStyle(
  color: primaryColor,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  letterSpacing: 1,
);

//  BoxDecoration(
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//               color: Colors.black.withAlpha(150),
//               blurRadius: 10,
//             ),
//           ],
//         ),
