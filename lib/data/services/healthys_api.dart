import 'dart:convert'; // Per a utf8 i jsondecode
import 'dart:io'; // Per a HttpStatus
import 'package:http/http.dart'
    as http; // Importem la llibreria http l'àlias http

/*
 Classe de Servei per accedir a l'API REST
*/

class HealthysApi {
  String urlBase;
  Future<List<dynamic>> getDataFromAPI(String url) async {
    // los errores hay que cambiarlos de puesto para que la GUI lo haga
    try {
      http.Response data = await http.get(Uri.parse(url));

      if (data.statusCode == 404) {
        print("\n\x1B[31mError 404: No es troba el recurs $url");
      } else if (data.statusCode == 500) {
        print("n\x1B[31mError 500: Error del servidor");
      } else if (data.statusCode == HttpStatus.ok) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body);
        return bodyJSON as List;
      } else {
        print(
          "n\x1B[31mEl servidor ha respost, però s'ha produit un codi d'error ${data.statusCode}",
        );
      }
      return [];
    } on SocketException {
      print(
        "\n\x1B[31mNo es pot connectar al servidor $url. Comprova l'estat de la xarxa, els DNS o la connexió al servidor a través d'un navegador",
      );
      return [];
    } on FormatException {
      print("El format esperat és incorrecte (Excepció FormatException)");
      return [];
    } catch (e) {
      print("S'ha produït l'error: $e");
      return [];
    }
  }

  // Constructor
  HealthysApi(this.urlBase);

  ////////////////////////////////////////
  // Mètode per obtenir els entrants
  Future<List<dynamic>> getEntrants() async {
    //sin mas por que da TODOS los entrants
    String url = "$urlBase/api/entrants";

    return await getDataFromAPI(
      url,
    ); //todo el código de antes que estaba aqui y en 'GeEntrantsbyType' se ha pasadoa gDFromAPI
  }

  //todo el código de antes que estaba aqui y en 'getEntrants' se ha pasadoa gDFromAPI
  Future<List<dynamic>> getEntrantsByType(String tipus) async {
    //aqui SI va el tipus para concretar CUAL
    String url = "$urlBase/api/entrants/$tipus";

    return await getDataFromAPI(url);
  }

  /////////////////////////////////////////
  //Ahora los ppales
  Future<List<dynamic>> getPrincipals() async {
    //tods
    String url = "$urlBase/api/principals";

    return await getDataFromAPI(url);
  }

  //////////////////////////////////////////
  // por Type
  Future<List<dynamic>> getPrincipalsByType(String tipus) async {
    //el coincreto
    String url = "$urlBase/api/principals/$tipus";

    return await getDataFromAPI(url);
  }

  ////////////////////////////////////////
  //Bebidads
  Future<List<dynamic>> getBegudes() async {
    //todos
    String url = "$urlBase/api/begudes";

    return await getDataFromAPI(url);
  }

  // Begudes by type
  Future<List<dynamic>> getBegudesByType(String tipus) async {
    //un tipo
    String url = "$urlBase/api/begudes/$tipus";

    return await getDataFromAPI(url);
  }
}
