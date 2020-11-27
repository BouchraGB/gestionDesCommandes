class Produit {
  int idProduit;
  String titreProduit;
  int prixProduit;
  String descriptionProduit;

  Produit(this.titreProduit, this.prixProduit, this.descriptionProduit);

  Produit.withId(this.idProduit, this.titreProduit, this.prixProduit,
      this.descriptionProduit);

  Produit.fromObjet(dynamic o) {
    this.idProduit = o["idProduit"];
    this.titreProduit = o["titreProduit"];
    this.prixProduit = o["prixProduit"];
    this.descriptionProduit = o["descriptionProduit"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["titreProduit"] = this.titreProduit;
    map["prixProduit"] = this.prixProduit;
    map["descriptionProduit"] = this.descriptionProduit;

    if (this.idProduit != null) {
      map["idProduit"] = this.idProduit;
    }
    return map;
  }
}

class Commande {
  int idCommande;
  int numTel;
  String nomClient;
  String dateTime;
  int livraison;
  String descriptionCommande;
}

class ProduitCommande {
  int idProduitCommande;
  String titreProduit;
  int quantite;
  int idCommande;
  int idProduit;
}
