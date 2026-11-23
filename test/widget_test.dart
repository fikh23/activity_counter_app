import 'package:flutter_test/flutter_test.dart';

import 'package:activity_counter_app/data/activity_data.dart';
import 'package:activity_counter_app/repositories/activity_repository.dart';
import 'package:activity_counter_app/viewmodels/activity_viewmodel.dart';
import 'package:activity_counter_app/main.dart';

void main() {
  testWidgets('Activity Counter menampilkan halaman Home',
      (WidgetTester tester) async {
    final data = ActivityData();
    final repository = ActivityRepository(data);
    final viewModel = ActivityViewModel(repository);

    await tester.pumpWidget(
      ActivityCounterApp(viewModel: viewModel),
    );

    expect(find.text('Activity Counter'), findsOneWidget);
    expect(find.text('Belum Ada Aktivitas'), findsOneWidget);
  });
}
