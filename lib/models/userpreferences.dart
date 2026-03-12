class UserPreferences {
  bool nutFree;
  bool dairyFree;
  bool lowSugar;
  bool lowCarb;
  bool lowSodium;
  bool lowSatFat;
  bool vegetarian;
  bool vegan;
  bool halal;
  bool kosher;
  bool glutenFree;
  bool soyFree;
  bool eggFree;
  bool shellfishFree;

  UserPreferences({
    required this.nutFree,
    required this.dairyFree,
    required this.lowSugar,
    required this.lowCarb,
    required this.lowSodium,
    required this.lowSatFat,
    required this.vegetarian,
    required this.vegan,
    required this.halal,
    required this.kosher,
    required this.glutenFree,
    required this.soyFree,
    required this.eggFree,
    required this.shellfishFree,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      nutFree: json["nut_free"],
      dairyFree: json["dairy_free"],
      lowSugar: json["low_sugar"],
      lowCarb: json["low_carb"],
      lowSodium: json["low_sodium"],
      lowSatFat: json["low_sat_fat"],
      vegetarian: json["vegetarian"],
      vegan: json["vegan"],
      halal: json["halal"],
      kosher: json["kosher"],
      glutenFree: json["gluten_free"],
      soyFree: json["soy_free"],
      eggFree: json["egg_free"],
      shellfishFree: json["shellfish_free"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nut_free": nutFree,
      "dairy_free": dairyFree,
      "low_sugar": lowSugar,
      "low_carb": lowCarb,
      "low_sodium": lowSodium,
      "low_sat_fat": lowSatFat,
      "vegetarian": vegetarian,
      "vegan": vegan,
      "halal": halal,
      "kosher": kosher,
      "gluten_free": glutenFree,
      "soy_free": soyFree,
      "egg_free": eggFree,
      "shellfish_free": shellfishFree,
    };
  }
}
