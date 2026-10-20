import 'package:healthys_cli/domain/entities/producte.dart';

class Beguda extends Producte {
  final bool isAlcoholic; // añadido en lugar del dietType

  Beguda({
    required super.id,
    required super.name,
    required super.description,
    super.tipus,
    required super.allergens,
    required super.price,
    required super.calories,
    required this.isAlcoholic,
    super.additionalInfo,
    super.img,
  }); 
  
  // Constructor de factoria a partir d'un JSON
  // Arguments:
  //  - el JSON en qüestió
  //  - L'adreça URL base, per construir la URL de la imatge completa

  factory Beguda.fromJson(Map<String, dynamic> json, String urlBase) {
    return Beguda(
      id: json['id'],
      name: json['name'] ?? "-",
      description: json['description'] ?? "-",
      tipus: json["tipus"] ?? "-",
      allergens: List<String>.from(json["allergens"]),
      price: (json['price'] as num).toDouble(),
      calories: json['calories'],
      isAlcoholic: json['isAlcoholic'],
      additionalInfo: json['additionalInfo'],
      img: json['img'] != ""
          ? "$urlBase/${json['img']}"
          : "$urlBase/not_found.png",
    );
  }

  @override
  String toString() {
    return 'Beguda(name: $name, description: $description, tipus: $tipus, allergens: $allergens, price: $price, calories: $calories, isAlcoholic: $isAlcoholic, additionalInfo: $additionalInfo)';
  }

  @override
  String toStringSmart() {
    return '''\n\n\x1B[32m$name
  \x1B[36m$description\n
  \x1B[92mtipus de beguda: \x1B[0m$tipus
  ${allergens.isEmpty ? "\x1B[92mNo conté cap al·lèrgens" : "\x1B[92mAl·lèrgens del producte: \x1B[0m${allergens.join(', ')}"} 
  \x1B[92mpreu: \x1B[0m$price€
  \x1B[92mcalories: \x1B[0m$calories
  \x1B[92mTé alcohol: \x1B[0m$isAlcoholic
  \x1B[92mInformació addicional: \x1B[0m$additionalInfo
  \x1B[92murl a la imatge: \x1B[0m$img''';
  }

  @override
  ProductsType getClass() {
    return ProductsType.beguda;
  }
}