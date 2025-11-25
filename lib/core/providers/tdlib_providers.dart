import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdlib/td_client.dart';
import 'package:telegram_selfmade_flutter_client/core/providers/talker_provider.dart';
import 'package:telegram_selfmade_flutter_client/core/services/tdlib_service.dart';

final tdServiceProvider = FutureProvider<TdlibService>((ref) async {
  Client tdClient = Client.create();
  tdClient.initialize();

  final tdlibService = TdlibService(tdClient, ref.read(talkerProvider));
  await tdlibService.initialize();

  return tdlibService;
});
