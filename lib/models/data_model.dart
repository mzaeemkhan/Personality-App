class DataModel {
  DataModel({
    this.combinations,
    this.test,
    this.indicator,
    this.personalitiesList,
  });

  List<Combinations>? combinations;
  List<Test>? test;
  Indicator? indicator;
  List<Personalities>? personalitiesList;

  DataModel.fromJson(dynamic json) {
    if (json['combinations'] != null) {
      combinations = [];
      json['combinations'].forEach((v) {
        combinations?.add(Combinations.fromJson(v));
      });
    }
    if (json['test'] != null) {
      test = [];
      json['test'].forEach((v) {
        test?.add(Test.fromJson(v));
      });
    }
    indicator = json['Indicator'] != null
        ? Indicator.fromJson(json['Indicator'])
        : null;

    personalitiesList = List<Personalities>.from(
        json["personalities"].map((x) => Personalities.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (combinations != null) {
      map['combinations'] = combinations?.map((v) => v.toJson()).toList();
    }
    if (test != null) {
      map['test'] = test?.map((v) => v.toJson()).toList();
    }
    if (indicator != null) {
      map['Indicator'] = indicator?.toJson();
    }
    if (personalitiesList != null) {
      map["personalities"] =
          List<dynamic>.from(personalitiesList!.map((x) => x.toJson()));
    }
    return map;
  }
}

class Indicator {
  Indicator({
    this.e,
    this.i,
    this.s,
    this.n,
    this.t,
    this.f,
    this.j,
    this.p,
  });

  Indicator.fromJson(dynamic json) {
    e = json['E'];
    i = json['I'];
    s = json['S'];
    n = json['N'];
    t = json['T'];
    f = json['F'];
    j = json['J'];
    p = json['P'];
  }
  String? e;
  String? i;
  String? s;
  String? n;
  String? t;
  String? f;
  String? j;
  String? p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['E'] = e;
    map['I'] = i;
    map['S'] = s;
    map['N'] = n;
    map['T'] = t;
    map['F'] = f;
    map['J'] = j;
    map['P'] = p;
    return map;
  }
}

class Test {
  Test({
    this.question,
    this.alpha,
    this.beta,
  });

  Test.fromJson(dynamic json) {
    question = json['question'];
    alpha = json['alpha'];
    beta = json['beta'];
  }
  String? question;
  String? alpha;
  String? beta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['alpha'] = alpha;
    map['beta'] = beta;
    return map;
  }
}

class Combinations {
  Combinations({
    this.name,
    this.personality,
    this.motto,
    this.abr,
    this.character,
    this.overview,
    this.population,
    this.male,
    this.female,
    this.careers,
    this.person,
    this.rules,
    this.keyElements,
    this.traits,
    this.relationship,
    this.strengths,
    this.weaknesses,
  });

  Combinations.fromJson(dynamic json) {
    name = json['name'];
    personality = json['personality'];
    motto = json['motto'];
    abr = json['abr'];
    character = json['character'];
    svgCharacter = json['svg_character'];
    overview = json['overview'];
    population = json['population'];
    male = json['male'];
    female = json['female'];
    careers =
        json['careers'] != null ? Careers.fromJson(json['careers']) : null;
    person = json['person'] != null ? Person.fromJson(json['person']) : null;
    rules = json['rules'] != null ? json['rules'].cast<String>() : [];
    keyElements =
        json['keyElements'] != null ? json['keyElements'].cast<String>() : [];
    traits = json['traits'] != null ? json['traits'].cast<String>() : [];
    relationship = json['relationship'] != null
        ? Relationship.fromJson(json['relationship'])
        : null;
    strengths =
        json['strengths'] != null ? json['strengths'].cast<String>() : [];
    weaknesses =
        json['weaknesses'] != null ? json['weaknesses'].cast<String>() : [];
  }
  String? name;
  String? personality;
  String? motto;
  String? abr;
  String? character;
  String? svgCharacter;
  String? overview;
  String? population;
  String? male;
  String? female;
  Careers? careers;
  Person? person;
  List<String>? rules;
  List<String>? keyElements;
  List<String>? traits;
  Relationship? relationship;
  List<String>? strengths;
  List<String>? weaknesses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['personality'] = personality;
    map['motto'] = motto;
    map['abr'] = abr;
    map['character'] = character;
    map['svg_character'] = svgCharacter;
    map['overview'] = overview;
    map['population'] = population;
    map['male'] = male;
    map['female'] = female;
    if (careers != null) {
      map['careers'] = careers?.toJson();
    }
    if (person != null) {
      map['person'] = person?.toJson();
    }
    map['rules'] = rules;
    map['keyElements'] = keyElements;
    map['traits'] = traits;
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    map['strengths'] = strengths;
    map['weaknesses'] = weaknesses;
    return map;
  }
}

class Relationship {
  Relationship({
    this.asParent,
    this.asPartner,
    this.asFriend,
  });

  Relationship.fromJson(dynamic json) {
    asParent = json['asParent'] != null ? json['asParent'].cast<String>() : [];
    asPartner =
        json['asPartner'] != null ? json['asPartner'].cast<String>() : [];
    asFriend = json['asFriend'] != null ? json['asFriend'].cast<String>() : [];
  }
  List<String>? asParent;
  List<String>? asPartner;
  List<String>? asFriend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asParent'] = asParent;
    map['asPartner'] = asPartner;
    map['asFriend'] = asFriend;
    return map;
  }
}

class Person {
  Person({
    this.personName,
    this.personImage,
  });

  Person.fromJson(dynamic json) {
    personName =
        json['personName'] != null ? json['personName'].cast<String>() : [];
    personImage =
        json['personImage'] != null ? json['personImage'].cast<String>() : [];
  }
  List<String>? personName;
  List<String>? personImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['personName'] = personName;
    map['personImage'] = personImage;
    return map;
  }
}

class Careers {
  Careers({
    this.carname,
    this.carimage,
  });

  Careers.fromJson(dynamic json) {
    carname = json['carname'] != null ? json['carname'].cast<String>() : [];
    carimage = json['carimage'] != null ? json['carimage'].cast<String>() : [];
  }
  List<String>? carname;
  List<String>? carimage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['carname'] = carname;
    map['carimage'] = carimage;
    return map;
  }
}

class Personalities {
  Personalities({
    required this.name,
    this.personalityDataList,
  });

  String name;
  List<PersonalityData>? personalityDataList;

  factory Personalities.fromJson(Map<String, dynamic> json) => Personalities(
        name: json["name"],
        personalityDataList: List<PersonalityData>.from(
            json["data"].map((x) => PersonalityData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "data": List<dynamic>.from(personalityDataList!.map((x) => x.toJson())),
      };
}

class PersonalityData {
  PersonalityData({
    required this.type,
    required this.personality,
    required this.character,
  });

  PersonalityData.fromJson(dynamic json) {
    type = json['type'] ?? "";
    personality = json['personality'] ?? "";
    character = json['character'] ?? "";
  }

  String? type;
  String? personality;
  String? character;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['personality'] = personality;
    map['character'] = character;
    return map;
  }
}
