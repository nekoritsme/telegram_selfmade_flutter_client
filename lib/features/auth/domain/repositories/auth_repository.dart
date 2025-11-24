abstract interface class AuthRepository {
  Future<void> sendPhoneNumber(String phoneNumber);
  Future<void> sendAuthCode(String code);
}
