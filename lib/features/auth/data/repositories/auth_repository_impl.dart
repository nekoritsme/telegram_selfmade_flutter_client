import 'package:dartz/dartz.dart';
import 'package:talker/talker.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:telegram_selfmade_flutter_client/core/services/tdlib_service.dart';
import 'package:telegram_selfmade_flutter_client/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.tdService, required this.talker});

  final TdlibService tdService;
  final Talker talker;

  @override
  Future<Either> sendAuthCode(String code) async {
    if (tdService.authorizationState is td.AuthorizationStateWaitCode) {
      try {
        final send = await tdService.client.send(
          td.CheckAuthenticationCode(code: code),
        );

        if (send is td.TdError) {
          return Left("Failed to send auth code: ${send.message}");
        }

        talker.info("Sent auth code: $send");
      } catch (err) {
        talker.error("Error sending auth code: $err");
        return Left("Error sending auth code: $err");
      }
      return Right("Success");
    }
    return Left("Not in the correct authorization state to send code");
  }

  @override
  Future<Either> sendPhoneNumber(String phoneNumber) async {
    if (tdService.authorizationState is td.AuthorizationStateWaitPhoneNumber) {
      try {
        final send = await tdService.client.send(
          td.SetAuthenticationPhoneNumber(phoneNumber: phoneNumber),
        );

        if (send is td.TdError) {
          return Left("Failed to send phone number: ${send.message}");
        }
        talker.info("Sent phone number: $send");

        return Right("Success");
      } catch (err) {
        talker.error("Error sending phone number: $err");
        return Left("Error sending phone number: $err");
      }
    }

    return Left("Not in the correct authorization state to send phone number");
  }
}
