import 'package:dartz/dartz.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_selfmade_flutter_client/core/services/tdlib_service.dart';
import 'package:telegram_selfmade_flutter_client/features/auth/data/repositories/auth_repository_impl.dart';

class SendPhoneCodeUseCase {
  Future<Either> call(
    TdlibService tdService,
    Talker talker,
    String code,
  ) async {
    return await AuthRepositoryImpl(
      tdService: tdService,
      talker: talker,
    ).sendAuthCode(code);
  }
}
