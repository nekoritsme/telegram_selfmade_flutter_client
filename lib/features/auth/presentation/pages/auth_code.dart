import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram_selfmade_flutter_client/features/auth/domain/usecases/send_phone_code.dart';

import '../../../../core/providers/talker_provider.dart';
import '../../../../core/providers/tdlib_providers.dart';

class AuthCodeScreen extends ConsumerWidget {
  AuthCodeScreen({super.key});

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final talker = ref.read(talkerProvider);
          final tdService = ref.watch(tdServiceProvider).value!;

          SendPhoneCodeUseCase().call(tdService, talker, _phoneController.text);
        }, // TODO: change loading to circle while waiting for a response
        child: const Icon(Icons.arrow_forward),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Enter your code from SMS"),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              autofocus: true,
            ),
          ],
        ),
      ),
    );
  }
}
