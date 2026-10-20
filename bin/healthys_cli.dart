// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';
import 'package:healthys_cli/data/repositories/carta_repository.dart';
import 'package:healthys_cli/domain/entities/entrant.dart';
import 'package:healthys_cli/domain/entities/principal.dart';
import 'package:healthys_cli/domain/entities/beguda.dart';

// Healthy's CLI
// Aplicació de consola per a la consulta dels plats de la cadena Healthy's

void main(List<String> arguments) {
  // Funció principal:
  // - parseja els arguments proporcionats
  // - Crea una instància del repositori de dades
  // - Crea una instància de l'aplicació
  // - Fa ús de la funcionalitat de l'aplicació per mostrar els plats indicats
  //   a través dels arguments.

  // Comprovem els paràmetres
  if (arguments.isEmpty) {
    print("\x1B[31m Nombre d'arguments incorrectes\x1B[0m");
    exit(-1);
  }

  // Capturem els paràmetres
  List<String> llistaArgs = List.from(arguments);
  String? producte;
  String? tipus;

  producte = llistaArgs[0]; // Tenim el producte que es vol consultar
  llistaArgs.removeAt(0);
  tipus = llistaArgs.join(" "); // Tenim el tipus de plat (dins el producte)

  // Inicialitzem el repositori
  CartaRepository repo = CartaRepository(
    "https://healthys-express-backend-production.up.railway.app", // API Express a Railway
    // Alternatives
    // "http://127.0.0.1:8080", // API Dart local (https://github.com/joamuran/healthys-backend)
    // "https://healthys-backend.globeapp.dev", // API Dart en Globe.dev
  );

  // Creem la instància de l'aplicació
  HealthysApp myApp = HealthysApp(repository: repo);

  // Segons el tipus de producte, farem ús d'una o altra funcionalitat
  switch (producte) {
    case "entrants":
      myApp.mostraEntrants(tipus);
      break;
    case "principals":
      myApp.mostraPrincipals(tipus);
      break;

    case "begudes":
      myApp.mostraBegudes(tipus);
      break;

    // TO-DO: Incorporar els casos per als plats "principals" i "begudes"

    default:
      print("\n\x1B[31mNo s'ha trobat cap producte de tipus: $producte\n");
      break;
  }
}

// Classe principal de l'aplicació

class HealthysApp {
  // Declarem el repositori de l'aplicació
  CartaRepository repository;

  // Inicialització del repositori
  HealthysApp({required this.repository});

  // Mètode per mostrar els entrants

  void mostraEntrants(String tipus) async {
    // Observeu que és una funció asíncrona
    List<Entrant> entrants;

    // Distingim si ens han demanat un tipus d'entrant concret o no
    if (tipus == "") {
      entrants = await repository.getEntrants();
    } else {
      entrants = await repository.getEntrantsByTipus(tipus);
    }

    if (entrants.isEmpty) {
      print("\n\x1B[31mNo hi ha cap entrant de tipus $tipus\n");
    } else {
      for (var e in entrants) {
        print(e.toStringSmart());
      }
    }
  }

  // TO-DO:
  // Implementar el mètode mostraPrincipals(String tipus) per als plats principals
void mostraPrincipals(String tipus) async {
  List<Principal> principals;

  if (tipus == "") {
    principals = await repository.getPrincipals();
  } else {
    principals = await repository.getPrincipalsByTipus(tipus);
  }

  if (principals.isEmpty) {
    print("\n\x1B[31mNo hi ha cap principal de tipus $tipus\n");
  } else {
    for (var p in principals) {
      print(p.toStringSmart());
    }
  }
}
  // TO-DO:
  // Implementar el mètode mostraBegudes(String tipus) per a les begudes
  void mostraBegudes(String tipus) async {
  List<Beguda> begudes;

  if (tipus == "") {
    begudes = await repository.getBegudes();
  } else {
    begudes = await repository.getBegudesByTipus(tipus);
  }

  if (begudes.isEmpty) {
    print("\n\x1B[31mNo hi ha cap beguda de tipus $tipus\n");
  } else {
    for (var b in begudes) {
      print(b.toStringSmart());
    }
  }
}
}
