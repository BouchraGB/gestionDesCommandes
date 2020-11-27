class Produit {
  final int id;
  final String titre;
  final int prix;

  static final columns = ["id", "name", "description", "price", "image"]; 

  Produit(this.id, this.titre, this.prix);

  factory Produit.fromMap(Map<String, dynamic> data) {
      return Produit(  
        data['id'], 
         data['titre'], 
         data['prix']
      ); 
   }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'prix': prix,
    };
  }
}