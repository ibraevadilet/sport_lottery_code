import 'package:flutter/material.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/main.dart';

void showErrorSnackBar(String error) {
  scaffoldKey.currentState?.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFF1100),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          error,
          textAlign: TextAlign.center,
          style: AppTextStyles.s15W400(color: Colors.white),
        ),
      ),
    ),
  );
}

void showSuccessSnackBar(String text) {
  scaffoldKey.currentState?.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF026405),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.s15W400(color: Colors.white),
        ),
      ),
    ),
  );
}

// showPremiumshowDialog(BuildContext context) {
//   showDialog<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Image.asset(AppImages.premiumIcon, height: 50),
//       content: const Text(
//           'Sorry, access to statistics is available only for premium users'),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           onPressed: () => {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PremiumScreen(),
//               ),
//             )
//           },
//           child: const Text('Buy Premium for \$0.99'),
//         ),
//       ],
//     ),
//   );
// }
