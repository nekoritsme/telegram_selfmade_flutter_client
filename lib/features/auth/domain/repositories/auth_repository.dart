import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either> sendPhoneNumber(String phoneNumber);
  Future<Either> sendAuthCode(String code);
}
