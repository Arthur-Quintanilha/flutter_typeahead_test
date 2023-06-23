// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_typeahead_test/app/app.bottomsheets.dart';
// import 'package:flutter_typeahead_test/app/app.locator.dart';
// import 'package:flutter_typeahead_test/ui/common/app_strings.dart';
// import 'package:flutter_typeahead_test/ui/views/home/home_viewmodel.dart';
//
// import '../helpers/test_helpers.dart';
//
// void main() {
//
//
//   group('HomeViewmodelTest -', () {
//     setUp(() => registerServices());
//     tearDown(() => locator.reset());
//
//     group('incrementCounter -', () {
//       test('When called once should return  Counter is: 1', () {
//         final model = _getModel();
//       });
//     });
//
//     group('showBottomSheet -', () {
//       test('When called, should show custom bottom sheet using notice variant',
//           () {
//         final bottomSheetService = getAndRegisterBottomSheetService();
//
//         final model = _getModel();
//         verify(bottomSheetService.showCustomSheet(
//           variant: BottomSheetType.notice,
//           title: ksHomeBottomSheetTitle,
//           description: ksHomeBottomSheetDescription,
//         ));
//       });
//     });
//   });
// }
