import 'package:instagram/app/mappers/mappers.dart';
import 'package:instagram/app/models/models.dart';
import 'package:instagram/domain/repositories/repositories.dart';

import '../../../infraestructure/services/services.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;
  final CameraService _cameraService;

  RegisterUseCase(this._authRepository, this._cameraService);

  Future<String> register(RegisterFormData value) async {
    final registerMapper =
        RegisterMapper.mapRegisterFormDataToSignUpUserInput(value);
    return _authRepository.signUpUser(registerMapper);
  }

  Future<void> selectPhoto() {
    return _cameraService.selectPhoto();
  }
}
