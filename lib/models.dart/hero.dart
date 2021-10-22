class HeroItem {
  String heroName;
  String powers;
  String description;
  num rate;

  HeroItem({this.heroName, this.powers, this.rate, this.description});

  HeroItem.fromJson(Map<String, dynamic> json) {
    heroName = json['hero_name'];
    powers = json['powers'];
    rate = json['rate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hero_name'] = this.heroName;
    data['powers'] = this.powers;
    data['rate'] = this.rate;
    data['description'] = this.description;
    return data;
  }
}
