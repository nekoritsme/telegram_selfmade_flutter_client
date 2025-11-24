import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_selfmade_flutter_client/core/services/tdlib_service.dart';
import 'package:telegram_selfmade_flutter_client/features/auth/presentation/pages/auth_phone.dart';

import 'core/providers/talker_provider.dart';
import 'core/providers/tdlib_providers.dart';

void main() async {
  final talker = TalkerFlutter.init(settings: TalkerSettings());

  runTalkerZonedGuarded(
    talker,
    () => runApp(ProviderScope(child: const TelegramClient())),
    (error, stackTrace) {
      talker.error('Uncaught error', error, stackTrace);
    },
  );
}

class TelegramClient extends ConsumerStatefulWidget {
  const TelegramClient({super.key});

  @override
  ConsumerState<TelegramClient> createState() => _TelegramClientState();
}

class _TelegramClientState extends ConsumerState<TelegramClient> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    final tdClient = ref.read(tdClientProvider);
    final _talker = ref.read(talkerProvider);

    TdlibService(tdClient, _talker).initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isInitialized
          ? const AuthPhoneScreen()
          : const CircularProgressIndicator(),
    );
  }
}
