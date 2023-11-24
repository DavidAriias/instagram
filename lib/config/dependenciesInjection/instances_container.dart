import 'package:instagram/app/useCases/auth/register_usecase.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/infraestructure/repositories/remote/post_repository_impl.dart';
import 'package:instagram/infraestructure/services/services.dart';

import '../../infraestructure/datasources/datasources.dart';
import '../../infraestructure/repositories/repositories.dart';

//Definir servicios aqui
final cameraService = CameraServiceImpl();

//Definir datasources aqui
final authDatasource = AuthGraphQlDatasourceImpl();
final localDatasource = LocalDatasourceImpl();
final userDataSource = UserGraphQlDatasourceImpl();
final postDatasource = PostGraphQlDatasourceImpl();
//Definir repositorios aqui
final authRepository = AuthRepositoryImpl(authDatasource);
final localRepository = LocalRepositoryImpl(localDatasource);
final userRepository = UserRepositoryImpl(userDataSource);
final postRepository = PostRepositoryImpl(postDatasource);

// Definir instancias de casos de uso aquí
final loginUseCase = LoginUseCase(authRepository, localRepository);
final registerUseCase = RegisterUseCase(authRepository, cameraService);
final userUseCase = UserUseCase(userRepository);
final authUseCase = AuthUseCase(localRepository);
final postUseCase = PostUseCase(postRepository);
final searchUseCase = SearchUseCase(userRepository, localRepository);
final cameraUseCase = CameraUseCase(cameraService);
