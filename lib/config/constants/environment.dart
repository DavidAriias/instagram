import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static initEnvironment() async{
    await dotenv.load(fileName: "lib/.env");
  }
  static String graphqlApi = dotenv.env['API_GRAPHQL'] ?? 'Not configured';
}