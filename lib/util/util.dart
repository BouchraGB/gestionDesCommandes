import 'package:gestion_commandes/model/model.dart';
import 'package:intl/intl.dart';

class Val {
  // Validations

  //verifier titre de produit : 
  static String validerTitreProduit(String titre) {
    return (titre != null && titre != "") ? null : "Veuillez saisir le titre du produit";
  }

  //verifier prix du produit :
  static String validerPrixProduit(int prix) {
    return (prix != null ) ? null : "Veuillez saisir le prix du produit";
  }  

  //verifier liste des produits dans une commande : //mazal(incomplete)
  static String validerListeProduits(List<Produit> produits) {
    return "la commande doit contenir au moins un produit";
  }

}

class DateUtils {

  //from string to date (annee-mois-jour)
  static DateTime convertToDate(String input) {
    try {
      var d = new DateFormat("yyyy-MM-dd").parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }


  //change string to date format jour mois annee
  static String convertToDateFull(String input) {
    try {
      var d = new DateFormat("yyyy-MM-dd").parseStrict(input);
      var formatter = new DateFormat('dd MMM yyyy');
      return formatter.format(d);
    } catch (e) {
      return null;
    }
  }

  static String convertToDateFullDt(DateTime input) {
    try {
      var formatter = new DateFormat('dd MMM yyyy');
      return formatter.format(input);
    } catch (e) {
      return null;
    }
  }

  static bool isDate(String dt) {
    try {
      // var d = new DateFormat("yyyy-MM-dd").parseStrict(dt);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidDate(String dt) {
    if (dt.isEmpty || !dt.contains("-") || dt.length < 10) return false;
    List<String> dtItems = dt.split("-");
    var d = DateTime(
        int.parse(dtItems[0]), int.parse(dtItems[1]), int.parse(dtItems[2]));
    return d != null && isDate(dt) && d.isAfter(new DateTime.now());
  }

  // String functions
  static String daysAheadAsStr(int daysAhead) {
    var now = new DateTime.now();
    DateTime ft = now.add(new Duration(days: daysAhead));
    return ftDateAsStr(ft);
  }

  static String ftDateAsStr(DateTime ft) {
    return ft.year.toString() +
        "-" +
        ft.month.toString().padLeft(2, "0") +
        "-" +
        ft.day.toString().padLeft(2, "0");
  }

  static String timDate(String dt) {
    if (dt.contains(" ")) {
      List<String> p = dt.split(" ");
      return p[0];
    } else
      return dt;
  }

  //verifier date de livraison : //mazal(incomplete)
  static String validerDateLivraison(String date) {
    return "la date doit etre superieure ou egale a la date actuelle";
  }
}



