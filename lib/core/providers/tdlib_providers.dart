import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdlib/td_client.dart';

final tdClientProvider = Provider<Client>((ref) {
  final client = Client.create();

  ref.onDispose(() {
    client.destroy();
  });

  return client;
});
