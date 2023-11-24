import 'package:graphql/client.dart';

import 'package:instagram/domain/entities/auth.dart';

import 'package:instagram/infraestructure/errors/auth_error.dart';

import '../../../domain/datasources/datasource.dart';

import '../../graphql_schemas/graphql.dart';
import '../../graphql_schemas/graphql_client.dart';

import '../../mappers/auth_mapper.dart';
import '../../models/models.dart';

class AuthGraphQlDatasourceImpl extends AuthDataSource {
  @override
  Future<Auth> signInUser(SignInUserInput input) async {
    // Inicializar el cliente GraphQL
    final client = await initializeGraphQLClient();

    // Configurar las opciones para la mutación
    final options = MutationOptions(
      document: gql(AuthMutations.loginMutation),
      variables: {'input': input.toJson()},
    );

    try {
      // Realizar la mutación y obtener el resultado
      final QueryResult result = await client.mutate(options);

      // Verificar si hay excepciones
      if (result.hasException) {
        // En caso de excepción, lanzar una AuthException con el mensaje de error
        throw AuthException(result.exception!.graphqlErrors.first.message);
      }

      // Obtener la respuesta de la mutación y extraer la información necesaria
      final response = SignInResponse.fromJson(result.data!);
      final authResponse = response.signInUser.authTypeOut;

      // Mapear la respuesta a una entidad Auth
      return AuthMapper.mapAuthResponseToMapEntity(authResponse);
    } on AuthException catch (e) {
      // Capturar una excepción específica de Auth y lanzarla de nuevo con el mensaje
      throw AuthException(e.message);
    }
  }

  @override
  Future<Auth> checkAuth(AuthInput input) async {
    final client = await initializeGraphQLClient();

    final options = QueryOptions(
      document: gql(AuthQueries.checkStatusQuery),
      variables: {'authType': input.toJson()},
    );

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw AuthException(result.exception!.graphqlErrors.first.message);
      }

      final response = CheckStatusResponse.fromJson(result.data!);
      final authResponse = response.checkTokenStatus;

      if (authResponse.error != null) {
        throw AuthException(authResponse.error!);
      }
      return AuthMapper.mapAuthResponseToMapEntity(authResponse);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<bool> closeSession(AuthInput auth) async {
    final client = await initializeGraphQLClient(auth.refreshToken);

    final options = MutationOptions(
      document: gql(AuthMutations.closeSession),
      variables: {'input': {'auth':auth.toJson()}},
    );

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw AuthException(result.exception!.graphqlErrors.first.message);
      }

      final response = AuthLogOut.fromJson(result.data!);

      final String message = response.closeSession.responseTypeOfString.message;

      if (message != "Session was closed succesfully.") {
        throw AuthException(message);
      }

      return response.closeSession.responseTypeOfString.statusCode ==
          "NO_CONTENT";
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<String> signUpUser(SignUpUserInput input) async {
    final client = await initializeGraphQLClient();

    final options = MutationOptions(
        document: gql(AuthMutations.signUpMutation),
        variables: {'input': input.toJson()});

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw AuthException(result.exception!.graphqlErrors.first.message);
      }

      final response = SignUpResponse.fromJson(result.data!);
      final signInResponse = response.signUpUser.responseTypeOfString;

      if (signInResponse.statusCode == 'BAD_REQUEST') {
        throw AuthException(signInResponse.message);
      }

      return signInResponse.message;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<String> confirmSMS(String sms) async {
    final client = await initializeGraphQLClient();

    final options = MutationOptions(
        document: gql(SmsFragments.smsFragment + SmsMutations.confirmSMS),
        variables: {'input': sms});

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw AuthException(result.exception!.graphqlErrors.first.message);
      }

      final response = ConfirmSmsResponse.fromJson(result.data!);
      final confirmSmsResponse = response.confirmSmsCode.smsType;

      return confirmSmsResponse.message;

    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<String> sendVerificationSMS(String phoneNumber) async {
    final client = await initializeGraphQLClient();

    final options = MutationOptions(
      document: gql(SmsFragments.smsFragment + SmsMutations.sendSMS),
      variables: {'input': phoneNumber},
    );

    try {
      final QueryResult result = await client.mutate(options);

      // Manejar errores generales de comunicación con el servidor GraphQL
      if (result.hasException) {
        throw AuthException(result.exception!.graphqlErrors.first.message);
      }

      final response = SendVerificationSmsResponse.fromJson(result.data!);
      final smsType = response.sendVerificationSms.smsType;

      // Devolver la información relevante del envío de SMS
      return smsType.message;
    } on AuthException catch (e) {
      // Lanzar una excepción AuthException si ocurre un error específico de autenticación
      throw AuthException(e.message);
    }
  }
}
