import 'package:flutter_test/flutter_test.dart';
import 'package:vitality_ai/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalityAI());
    await tester.pumpAndSettle();
    expect(find.text('VitalityAI'), findsWidgets);
  });
}
