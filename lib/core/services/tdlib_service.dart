import 'package:path_provider/path_provider.dart';
import 'package:talker/talker.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart';

class TdlibService {
  TdlibService(this._client, this.talker);

  final Client _client;
  final Talker talker;
  bool isInitialized = false;

  Future<void> initialize() async {
    if (isInitialized) {
      talker.warning("TDLib client is already initialized.");
      return;
    }

    talker.info("Initializing TDLib client...");
    try {
      await _client.initialize();
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = '${appDir.path}/tdlib';

      _client.updates.listen((td.TdObject event) async {
        if (event is td.AuthorizationStateWaitTdlibParameters) {
          await _client.send(
            td.SetTdlibParameters(
              useTestDc: true,
              apiId: "hide it",
              apiHash: "hide it",
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
