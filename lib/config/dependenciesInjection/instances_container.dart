import 'package:instagram/app/useCases/location/location_use_case.dart';
import 'package:instagram/app/useCases/uses_cases.dart';
import 'package:instagram/infraestructure/datasources/remote/mapbox/location_mapbox_datasource_impl.dart';

import 'package:instagram/infraestructure/repositories/remote/post_repository_impl.dart';
import 'package:instagram/infraestructure/services/services.dart';

import '../../infraestructure/datasources/datasources.dart';
import '../../infraestructure/repositories/repositories.dart';

//Definir servicios aqui
final cameraService = CameraServiceImpl();
final locationService = LocationServiceImpl();

//Definir datasources aqui
final authDatasource = AuthGraphQlDatasourceImpl();
final localDatasource = LocalDatasourceImpl();
final userDataSource = UserGraphQlDatasourceImpl();
final postDatasource = PostGraphQlDatasourceImpl();
final musicDatasource = MusicGraphQlDatasourceImpl();
final locationDatasource = LocationMapboxDatasourceImpl();
//Definir repositorios aqui
final authRepository = AuthRepositoryImpl(authDatasource);
final localRepository = LocalRepositoryImpl(localDatasource);
final userRepository = UserRepositoryImpl(userDataSource);
final postRepository = PostRepositoryImpl(postDatasource);
final musicRepository = MusicRepositoryImpl(musicDatasource);
final locationRepository = LocationRepositoryImpl(locationDatasource);
// Definir instancias de casos de uso aquí
final loginUseCase = LoginUseCase(authRepository, localRepository);
final registerUseCase = RegisterUseCase(authRepository, cameraService);
final userUseCase = UserUseCase(userRepository);
final authUseCase = AuthUseCase(localRepository);
final postUseCase = PostUseCase(postRepository);
final searchUseCase = SearchUseCase(userRepository, localRepository);
final cameraUseCase = CameraUseCase(cameraService);
final musicUseCase = MusicUseCase(musicRepository);
final locationUseCase = LocationUseCase(locationService, locationRepository);
