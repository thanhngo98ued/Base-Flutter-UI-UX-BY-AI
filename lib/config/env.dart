final class Env {
  const Env._();

  static const String flavor = String.fromEnvironment("FLAVOR");

  static const String baseUrl = String.fromEnvironment("BASE_URL");

  static const String apiKey = String.fromEnvironment("API_KEY");
}
