import 'package:flutter/material.dart';


extension SpaceExtension on num {
   height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension NavigationExtensions on BuildContext {
   popPage ({Object?result}){
    Navigator.of(this).pop(result);
   }

  void navigateTo(
    Widget screen,
  ) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void navigatepushReplacement(Widget screen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (context) => screen,));
  }
}

extension DynanicSizeExtension on BuildContext {
  double get dynamicHeight => MediaQuery.of(this).size.height;

  double get dynamicWidth => MediaQuery.of(this).size.width;
}

extension HideKeypad on BuildContext {
  void hideKeypad() => FocusScope.of(this).unfocus();
}

extension OmitSymbolText on String {
  getTextAfterSymbol() {
    int atIndex = indexOf('-');
    int lastAtIndex = lastIndexOf('-');

    if (atIndex != -1 && atIndex == lastAtIndex) {
      return substring(atIndex + 1);
    } else {
      return "";
    }
  }
}



// extension HitApi on void{
//   getA(context, { required ValueNotifier<List<TypeFilterModel>> confirmedFilter,String? limitContentPerPage,String? pageNumber, bool? isScroll, bool? isFilter}) async {
//     (() {
//       // isNodData = false;
//       // isFilter == true ? data.clear() : null;
//       // isFilter == true ? pageNumber = 1 : null;
//       // isLoadingNotifier = isScroll == true ? false : true;
//     });
//     await VideoListController.getData(
//       context,
//       confirmedFilter: confirmedFilter,
//       limitContentPerPage: limitContentPerPage.toString(),
//       pageNumber: pageNumber.toString(),
//     ).then((value) {
//       if (value != null) {
//         (() {
//           // isLoadMore = false;
//           // data.addAll(value);
//           // isLoadingNotifier = isScroll == true ? false : false;
//         });
//       }
//       if (value?.length == 0) {
//         (() {
//           // nextPage = false;

//           // isLoadingNotifier = isScroll == true ? false : false;
//         });
//       }
//       if (value == null) {
//         (() {
//           // isNodData = true;
//           // isLoadingNotifier = isScroll == true ? false : false;
//         });
//       }
//     });
//   }

// }