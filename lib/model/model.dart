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

  Commande(this.numTel, this.nomClient, this.dateTime, this.livraison,
      this.descriptionCommande);

  Commande.withId(this.idCommande, this.numTel, this.nomClient, this.dateTime,
      this.livraison, this.descriptionCommande);

  Commande.fromObjet(dynamic o) {
    this.idCommande = o["idCommande"];
    this.numTel = o["numTel"];
    this.nomClient = o["nomClient"];
    this.dateTime = o["dateTime"];
    this.livraison = o["livraison"];
    this.descriptionCommande = o["descriptionCommande"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["numTel"] = this.numTel;
    map["nomClient"] = this.nomClient;
    map["dateTime"] = this.dateTime;
    map["livraison"] = this.livraison;
    map["descriptionCommande"] = this.descriptionCommande;

    if (this.idCommande != null) {
      map["idCommande"] = this.idCommande;
    }
    return map;
  }
}

class ProduitCommande {
  int idProduitCommande;
  String titreProduit;
  int quantite;
  int idCommande;
  int idProduit;

  ProduitCommande(
      this.titreProduit, this.quantite, this.idCommande, this.idProduit);

  ProduitCommande.withId(this.idProduitCommande, this.titreProduit,
      this.quantite, this.idCommande, this.idProduit);

  ProduitCommande.fromObjet(dynamic o) {
    this.idProduitCommande = o["idProduitCommande"];
    this.titreProduit = o["titreProduit"];
    this.quantite = o["quantite"];
    this.idCommande = o["idCommande"];
    this.idProduit = o["idProduit"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["titreProduit"] = this.titreProduit;
    map["quantite"] = this.quantite;
    map["idCommande"] = this.idCommande;
    map["idProduit"] = this.idProduit;

    if (this.idProduitCommande != null) {
      map["idProduitCommande"] = this.idProduitCommande;
    }
    return map;
  }
}
