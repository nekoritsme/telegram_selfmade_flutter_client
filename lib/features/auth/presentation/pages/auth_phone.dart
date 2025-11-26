import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:telegram_selfmade_flutter_client/core/services/tdlib_service.dart';
import 'package:telegram_selfmade_flutter_client/features/auth/domain/usecases/send_phone_number.dart';
import 'package:telegram_selfmade_flutter_client/features/client/presentation/pages/client.dart';

import '../../../../core/providers/talker_provider.dart';
import '../../../../core/providers/tdlib_providers.dart';
import 'auth_code.dart';

class AuthPhoneScreen extends ConsumerStatefulWidget {
  const AuthPhoneScreen({super.key});

  @override
  ConsumerState<AuthPhoneScreen> createState() => _AuthPhoneScreenState();
}

class _AuthPhoneScreenState extends ConsumerState<AuthPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _sendPhoneNumber(
    BuildContext context,
    TdlibService tdService,
    Talker talker,
  ) async {
    final phoneNumber = _phoneController.text;
    if (phoneNumber.isEmpty || phoneNumber.length < 5) {
      // TODO: improve validation
      // TODO: show error message to user
      return;
    }

    // TODO: send phone number to backend if not return, dont let navigator push

    final response = await SendPhoneNumberUseCase().call(
      phoneNumber,
      tdService,
      talker,
    );

    if (response is Right) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => AuthCodeScreen()),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tdService = ref.watch(tdServiceProvider);

    if (tdService.value!.authorizationState is td.AuthorizationStateReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => ClientScreen()),
        );
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendPhoneNumber(context, tdService.value!, ref.read(talkerProvider));
        },
        child: const Icon(
          Icons.arrow_forward,
        ), // TODO: change loading to circle while waiting for a response
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Enter your phone number"),
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
