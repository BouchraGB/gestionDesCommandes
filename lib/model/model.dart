class Produit {
  int idProduit;
  String titreProduit;
  int prixProduit;
  String descriptionProduit;
  String image;

  Produit(this.titreProduit, this.prixProduit, this.descriptionProduit, this.image);

  Produit.withId(this.idProduit, this.titreProduit, this.prixProduit,
      this.descriptionProduit, this.image);

  Produit.fromObjet(dynamic o) {
    this.idProduit = o["idProduit"];
    this.titreProduit = o["titreProduit"];
    this.prixProduit = o["prixProduit"];
    this.descriptionProduit = o["descriptionProduit"];
    this.image = o["image"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["titreProduit"] = this.titreProduit;
    map["prixProduit"] = this.prixProduit;
    map["descriptionProduit"] = this.descriptionProduit;
    map["image"] = this.image;

    if (this.idProduit != null) {
      map["idProduit"] = this.idProduit;
    }
    return map;
  }
}
///////////////////////////////////////////////////////////////////////////////
class Commande {
  int idCommande;
  int numTel;
  String nomClient;
  String dateTime;
  String heure;
  int livraison;
  String lieu;
  int etat;
  String descriptionCommande;

  Commande(this.numTel, this.nomClient, this.dateTime, this.heure, this.livraison, this.lieu, this.etat,
      this.descriptionCommande);

  Commande.withId(this.idCommande, this.numTel, this.nomClient, this.dateTime, this.heure, this.lieu, this.etat,
      this.livraison, this.descriptionCommande);

  Commande.fromObjet(dynamic o) {
    this.idCommande = o["idCommande"];
    this.numTel = o["numTel"];
    this.nomClient = o["nomClient"];
    this.dateTime = o["dateTime"];
    this.heure = o["heure"];
    this.livraison = o["livraison"];
    this.lieu = o["lieu"];
    this.etat = o["etat"];
    this.descriptionCommande = o["descriptionCommande"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["numTel"] = this.numTel;
    map["nomClient"] = this.nomClient;
    map["dateTime"] = this.dateTime;
    map["heure"] = this.heure;
    map["livraison"] = this.livraison;
    map["lieu"] = this.lieu;
    map["etat"] = this.etat;
    map["descriptionCommande"] = this.descriptionCommande;

    if (this.idCommande != null) {
      map["idCommande"] = this.idCommande;
    }
    return map;
  }
}
//////////////////////////////////////////////////////////////////////////////////////
class ProduitCommande {
  // int idProduitCommande;
  // String titreProduit;
  // int quantite;
  int idCommandep;
  int idProduitp;
  String description;

  ProduitCommande(
      this.idCommandep, this.idProduitp, this.description);

  // ProduitCommande.withId(this.idProduitCommande, this.titreProduit,
  //     this.quantite, this.idCommande, this.idProduit);

  ProduitCommande.fromObjet(dynamic o) {
    // this.idProduitCommande = o["idProduitCommande"];
    // this.titreProduit = o["titreProduit"];
    // this.quantite = o["quantite"];
    this.idCommandep = o["idCommandep"];
    this.idProduitp = o["idProduitp"];
    this.description = o["description"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    // map["titreProduit"] = this.titreProduit;
    // map["quantite"] = this.quantite;
    map["idCommandep"] = this.idCommandep;
    map["idProduitp"] = this.idProduitp;
    map["description"] = this.description;

    // if (this.idProduitCommande != null) {
    //   map["idProduitCommande"] = this.idProduitCommande;
    // }
    return map;
  }
}

class Photo {
  int idImage;
  String nameImage;
 
  Photo(this.idImage, this.nameImage);
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idImage': idImage,
      'nameImage': nameImage,
    };
    return map;
  }
 
  Photo.fromMap(Map<String, dynamic> map) {
    idImage = map['idImage'];
    nameImage = map['nameImage'];
  }
}
