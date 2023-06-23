import 'package:bluetouch/auth/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('should contains login button', (widgetTester) async {
    mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: ProviderScope(child: LoginPage()),
      ));

      expect(find.text("Se connecter"), findsOneWidget);
    });
  });
}
