class ProductModel {
  String? Title;
  String? Year;
  String? imdbID;
  String? Type;
  String? Poster;

  ProductModel({
    this.Title,
    this.Year,
    this.imdbID,
    this.Type,
    this.Poster,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    Title: json['Title'],
    Year: json['Year'],
    imdbID: json['imdbID'],
    Type: json['Type'],
    Poster: json['Poster'],
  );

  Map<String, dynamic> toJson() => {
    'Title': Title,
    'Year': Year,
    'imdbID':  imdbID,
    'Type': Type,
    'Poster': Poster,

  };
}
