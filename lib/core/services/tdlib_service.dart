import 'package:path_provider/path_provider.dart';
import 'package:talker/talker.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart';

class TdlibService {
  TdlibService(this.client, this.talker);

  final Client client;
  final Talker talker;
  bool isInitialized = false;

  // states
  td.AuthorizationState? authorizationState;

  Future<void> initialize() async {
    if (isInitialized) {
      talker.warning("TDLib client is already initialized.");
      return;
    }

    talker.info("Initializing TDLib client...");
    try {
      await client.initialize();
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = '${appDir.path}/tdlib';

      client.updates.listen((td.TdObject event) async {
        talker.info("Received TDLib event: ${event.toJson()}");
        if (event is td.UpdateAuthorizationState) {
          if (event.authorizationState
              is td.AuthorizationStateWaitTdlibParameters) {
            await client.send(
              td.SetTdlibParameters(
                useTestDc: false,
                apiId: 1,
                apiHash: "hide",
                systemLanguageCode: "en",
                deviceModel: "Android",
                applicationVersion: "1.0",
                databaseDirectory: dbPath,
                filesDirectory: '$dbPath/files',
                useFileDatabase: true,
                useChatInfoDatabase: true,
                useMessageDatabase: true,
                useSecretChats: false,
                databaseEncryptionKey: '',
                systemVersion: '',
              ),
            );
          } else {
            authorizationState = event.authorizationState;
          }
          talker.info("Updated authorization state: $authorizationState");
        }
      });
    } catch (err) {
      talker.error("Error initializing TDLib client: $err");
      throw Exception();
    } finally {
      isInitialized = true;
      talker.info("TDLib client initialized");
    }
  }
}
