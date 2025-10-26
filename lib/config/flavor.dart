enum Flavor {
  dev("develop"),
  stg("staging"),
  prod("production");

  const Flavor(this.value);

  final String value;

  factory Flavor.fromValue(String value) {
    return switch (value.toLowerCase()) {
      "develop" => dev,
      "staging" => stg,
      "production" => prod,
      _ => dev,
    };
  }
}
