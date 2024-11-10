class ComputadoraModel {
  final int id;
  final String procesador;
  final String discoDuro;
  final String ram;

  ComputadoraModel({
    this.id = -1,
    required this.procesador,
    required this.discoDuro,
    required this.ram,
  });

  ComputadoraModel copyWith({
    int? id,
    String? procesador,
    String? discoDuro,
    String? ram,
  }) {
    return ComputadoraModel(
      id: id ?? this.id,
      procesador: procesador ?? this.procesador,
      discoDuro: discoDuro ?? this.discoDuro,
      ram: ram ?? this.ram,
    );
  }

  factory ComputadoraModel.fromMap(Map<String, dynamic> map) {
    return ComputadoraModel(
      id: map['id'],
      procesador: map['procesador'],
      discoDuro: map['discoDuro'],
      ram: map['ram'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'procesador': procesador,
    'discoDuro': discoDuro,
    'ram': ram,
  };
}
