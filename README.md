# Healthy's CLI

Aplicación de consola desarrollada en **Dart** para consultar la carta de Healthy's a través de una **API REST**.

El proyecto permite obtener entrantes, platos principales y bebidas, tanto de forma completa como filtrando por tipo.

## Objetivo del ejercicio

El objetivo principal ha sido practicar el consumo de una API desde Dart y organizar la aplicación separando las responsabilidades entre la interfaz de consola, el acceso a datos y las entidades del dominio.

Durante el desarrollo se han trabajado especialmente:

- Peticiones HTTP con el paquete `http`.
- Programación asíncrona con `Future`, `async` y `await`.
- Decodificación de respuestas JSON.
- Manejo de códigos de estado HTTP y excepciones de red.
- Herencia mediante una clase abstracta común (`Producte`).
- Constructores `factory` para crear entidades a partir de JSON.
- Transformación de colecciones mediante `.map()` y `.toList()`.
- Separación entre servicio, repositorio, dominio e interfaz de consola.
- Filtrado de productos mediante argumentos de línea de comandos.

## Funcionalidades

La aplicación permite consultar:

- Entrantes.
- Platos principales.
- Bebidas.
- Productos filtrados por tipo dentro de cada categoría.

Cada producto muestra información como nombre, descripción, tipo, alérgenos, precio, calorías e información adicional. En el caso de entrantes y principales también se muestra el tipo de dieta, mientras que las bebidas indican si contienen alcohol.

## Arquitectura

El proyecto está dividido en tres partes principales:

```text
.
├── bin
│   └── healthys_cli.dart
├── lib
│   ├── data
│   │   ├── repositories
│   │   │   └── carta_repository.dart
│   │   └── services
│   │       └── healthys_api.dart
│   └── domain
│       └── entities
│           ├── producte.dart
│           ├── entrant.dart
│           ├── principal.dart
│           └── beguda.dart
└── pubspec.yaml
```

### `bin/`

Contiene el punto de entrada de la aplicación. Procesa los argumentos recibidos por consola y decide qué tipo de producto debe consultarse.

### `domain/entities/`

Contiene las entidades del dominio:

- `Producte`: clase abstracta con las propiedades comunes.
- `Entrant`: añade información sobre tipos de dieta.
- `Principal`: añade información sobre tipos de dieta.
- `Beguda`: añade la propiedad booleana `isAlcoholic`.

Las entidades utilizan constructores `factory fromJson()` para convertir los datos recibidos de la API en objetos Dart.

### `data/services/`

`HealthysApi` se encarga de realizar las peticiones HTTP.

La lógica común se ha centralizado en:

```dart
Future<List<dynamic>> getDataFromAPI(String url)
```

Este método realiza la petición, comprueba el estado HTTP, decodifica la respuesta y devuelve los datos obtenidos.

### `data/repositories/`

`CartaRepository` actúa como intermediario entre la aplicación y el servicio HTTP. Recibe los datos de la API y los transforma en entidades del dominio mediante `fromJson()`.

Por ejemplo:

```text
CLI
 ↓
CartaRepository
 ↓
HealthysApi
 ↓
API REST
 ↓
JSON
 ↓
Entrant / Principal / Beguda
```

## API utilizada

La aplicación consulta la API de Healthy's publicada en Railway:

```text
https://healthys-express-backend-production.up.railway.app
```

Endpoints utilizados:

```text
/api/entrants
/api/entrants/{tipus}
/api/principals
/api/principals/{tipus}
/api/begudes
/api/begudes/{tipus}
```

## Requisitos

- Dart SDK compatible con `^3.10.7`.
- Conexión a Internet para acceder a la API.

Instalar las dependencias:

```bash
dart pub get
```

## Uso

Consultar todos los entrantes:

```bash
dart run healthys_cli entrants
```

Consultar entrantes de un tipo concreto:

```bash
dart run healthys_cli entrants rotllets
```

Consultar todos los platos principales:

```bash
dart run healthys_cli principals
```

Consultar principales de un tipo concreto:

```bash
dart run healthys_cli principals <tipus>
```

Consultar todas las bebidas:

```bash
dart run healthys_cli begudes
```

Consultar bebidas de un tipo concreto:

```bash
dart run healthys_cli begudes <tipus>
```

## Tecnologías utilizadas

- Dart
- `package:http`
- API REST
- JSON
- Programación orientada a objetos
- Programación asíncrona

## Aprendizajes principales

Este proyecto ha servido para reforzar el flujo completo de consumo de datos remotos en una aplicación Dart:

```text
argumentos CLI
→ repositorio
→ servicio HTTP
→ respuesta JSON
→ conversión a entidades
→ presentación por consola
```

También ha permitido trabajar con una estructura de proyecto más organizada, evitando concentrar toda la lógica de acceso a datos, transformación y presentación en un único archivo.
