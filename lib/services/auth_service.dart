import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> verifyUser() async {
    try {
      print("Checking biometrics...");

      bool canCheck = await auth.canCheckBiometrics;
      bool isSupported = await auth.isDeviceSupported();

      print("canCheckBiometrics: $canCheck");
      print("isDeviceSupported: $isSupported");

      if (!canCheck || !isSupported) {
        print("Device not supported for biometrics");
        return false;
      }

      bool result = await auth.authenticate(
        localizedReason: 'Verify your identity to continue',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      print("AUTH RESULT: $result");
      return result;
    } catch (e) {
      print("AUTH ERROR: $e");
      return false;
    }
  }
}
