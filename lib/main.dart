import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
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

    final _talker = ref.read(talkerProvider);
    final tdServiceFuture = ref.read(tdServiceProvider.future);

    tdServiceFuture
        .then((value) {
          setState(() {
            _isInitialized = value.isInitialized;
          });
        })
        .catchError((err, stackTrace) {
          _talker.error(
            "TDLib Service initialization main.dart error",
            err,
            stackTrace,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isInitialized
          ? AuthPhoneScreen()
          : const CircularProgressIndicator(),
    );
  }
}
