import 'package:anaquel/utils/config.dart';
import 'package:appwrite/appwrite.dart';

class Appwrite {
  static Account init() {
    Client client = Client()
        .setEndpoint(Config.APPWRITE_ENDPOINT)
        .setProject(Config.APPWRITE_PROJECT)
        .setSelfSigned();

    return Account(client);
  }
}
