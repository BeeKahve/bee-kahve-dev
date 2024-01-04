class Coffee {
  final int id;
  final String name;
  final String photoPath;
  final double price;
  final String? sizeChoice;
  final String? milkChoice;
  final bool? extraShotChoice;
  final bool? caffeineChoice;

  Coffee(
      {required this.id,
      required this.name,
      required this.photoPath,
      required this.price,
      required this.sizeChoice,
      required this.milkChoice,
      this.extraShotChoice,
      this.caffeineChoice});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coffee &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          photoPath == other.photoPath &&
          price == other.price &&
          sizeChoice == other.sizeChoice &&
          milkChoice == other.milkChoice &&
          extraShotChoice == other.extraShotChoice &&
          caffeineChoice == other.caffeineChoice;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      photoPath.hashCode ^
      price.hashCode ^
      sizeChoice.hashCode ^
      milkChoice.hashCode ^
      extraShotChoice.hashCode ^
      caffeineChoice.hashCode;
}
