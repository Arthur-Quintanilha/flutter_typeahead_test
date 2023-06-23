import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_typeahead_test/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ExempleTypeAheadViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
