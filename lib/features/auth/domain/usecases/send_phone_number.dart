import 'package:dartz/dartz.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_selfmade_flutter_client/core/services/tdlib_service.dart';
import 'package:telegram_selfmade_flutter_client/features/auth/data/repositories/auth_repository_impl.dart';

class SendPhoneNumberUseCase {
  Future<Either> call(
    String phoneNumber,
    TdlibService tdService,
    Talker talker,
  ) async {
    return await AuthRepositoryImpl(
      talker: talker,
      tdService: tdService,
    ).sendPhoneNumber(phoneNumber);
  }
}
