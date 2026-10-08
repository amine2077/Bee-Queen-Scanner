import 'package:flutter_test/flutter_test.dart';

import 'package:beescanner_yolo_test/main.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const BeeScannerTestApp());
    expect(find.byType(BeeScannerTestApp), findsOneWidget);
  });
}
