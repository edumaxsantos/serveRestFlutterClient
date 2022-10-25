class ProductModel {
  final String nome;
  final int preco;
  final String descricao;
  final int quantidade;
  final String id;

  ProductModel({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.quantidade,
    required this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'],
      quantidade: json['quantidade'],
      id: json['_id'],
    );
  }
}
