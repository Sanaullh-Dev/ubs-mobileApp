import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ubs/pages/login/widget/common_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

/// This is the basic usage of Pinput
/// For more examples check out the demo directory
class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  bool showError = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;

    final defaultPinTheme = PinTheme(
      width: 115.sp,
      height: 130.sp,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromARGB(255, 30, 51, 73),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return SafeArea(
      child: Scaffold(
        appBar: appBar("OTP verification"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addVerticalSpace(100.h),
                      Text("Verification", style: heading1InBold),
                      addVerticalSpace(50.h),
                      Text("Enter the code sent to the number", style: heading4),
                      addVerticalSpace(25.h),
                      Text("+91 7499604663", style: heading5),
                      addVerticalSpace(70.h),
                      Directionality(
                        // Specify direction if desired
                        textDirection: TextDirection.ltr,
                        child: SizedBox(
                          height: 68,
                          width: size.width,
                          child: Pinput(
                            length: 4,
                            controller: controller,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            onCompleted: (pin) {
                              setState(() => showError = pin != '5555');
                            },
                            focusedPinTheme: defaultPinTheme.copyWith(
                              height: 68,
                              width: 64,
                              decoration: defaultPinTheme.decoration!.copyWith(
                                border: Border.all(color: borderColor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyWith(
                              decoration: BoxDecoration(
                                color: errorColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(60.h),
                      Text("Didn't received code?", style: heading4),
                      addVerticalSpace(10.h),
                      Text("Resend", style: heading4WithUnderLine),
                      addVerticalSpace(60.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF263238),
                            padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 100.w)
                            ),
                        onPressed: () {},
                        child: Text(
                          "Validate",
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}



// class FilledRoundedPinPut extends StatefulWidget {
//   const FilledRoundedPinPut({Key? key}) : super(key: key);

//   @override
//   _FilledRoundedPinPutState createState() => _FilledRoundedPinPutState();

//   @override
//   String toStringShort() => 'Rounded Filled';
// }

// class _FilledRoundedPinPutState extends State<FilledRoundedPinPut> {
//   final controller = TextEditingController();
//   final focusNode = FocusNode();

//   @override
//   void dispose() {
//     controller.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     const length = 4;
   
   
//     return SizedBox(
//       height: 68,
//       child: Pinput(
//         length: length,
//         controller: controller,
//         focusNode: focusNode,
//         defaultPinTheme: defaultPinTheme,
//         onCompleted: (pin) {
//           setState(() => showError = pin != '5555');
//         },
//         focusedPinTheme: defaultPinTheme.copyWith(
//           height: 68,
//           width: 64,
//           decoration: defaultPinTheme.decoration!.copyWith(
//             border: Border.all(color: borderColor),
//           ),
//         ),
//         errorPinTheme: defaultPinTheme.copyWith(
//           decoration: BoxDecoration(
//             color: errorColor,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }
// }
