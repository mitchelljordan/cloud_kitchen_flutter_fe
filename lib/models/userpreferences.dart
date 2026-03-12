class Preferences {
  Map<String, bool> values;

  Preferences(this.values);

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences({
      "nut_free": json["nut_free"] ?? false,
      "dairy_free": json["dairy_free"] ?? false,
      "low_sugar": json["low_sugar"] ?? false,
      "low_carb": json["low_carb"] ?? false,
      "low_sodium": json["low_sodium"] ?? false,
      "low_sat_fat": json["low_sat_fat"] ?? false,
      "vegetarian": json["vegetarian"] ?? false,
      "vegan": json["vegan"] ?? false,
      "halal": json["halal"] ?? false,
      "kosher": json["kosher"] ?? false,
      "gluten_free": json["gluten_free"] ?? false,
      "soy_free": json["soy_free"] ?? false,
      "egg_free": json["egg_free"] ?? false,
      "shellfish_free": json["shellfish_free"] ?? false,
    });
  }

  Map<String, dynamic> toJson() => values;
}
