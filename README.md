# StudyAI

StudyAI es una aplicación móvil educativa desarrollada con **Flutter y Dart** que utiliza inteligencia artificial para generar exámenes personalizados a partir de un tema elegido por el usuario.

El proyecto nació como una exploración de cómo integrar servicios de inteligencia artificial en una aplicación móvil y convertir una respuesta generada por IA en una experiencia educativa interactiva.

## Funcionalidades

StudyAI permite al usuario:

* Introducir un tema que desea estudiar.
* Configurar las características del examen.
* Generar preguntas mediante inteligencia artificial.
* Realizar el examen de forma interactiva.
* Registrar y evaluar las respuestas.
* Calcular automáticamente la puntuación.
* Revisar los resultados y las respuestas correctas.

### Flujo de la aplicación

```text
Tema de estudio
      ↓
Configuración del examen
      ↓
Solicitud a la API de IA
      ↓
Generación de preguntas
      ↓
Examen interactivo
      ↓
Evaluación
      ↓
Resultados
```

## Tecnologías utilizadas

* **Flutter** — Framework utilizado para desarrollar la aplicación multiplataforma.
* **Dart** — Lenguaje principal de programación.
* **OpenRouter API** — Servicio utilizado como intermediario para acceder al modelo de IA encargado de generar los exámenes.
* **HTTP** — Utilizado para realizar las peticiones a la API.
* **flutter_dotenv** — Utilizado para gestionar variables de entorno y credenciales de API.
* **JSON** — Formato utilizado para enviar y recibir información entre la aplicación y la API.
* **Visual Studio Code** — Entorno utilizado durante el desarrollo.

## Arquitectura

La aplicación utiliza una estructura sencilla basada en la separación de responsabilidades:

```text
lib/
├── models/
│   └── exam.dart
│
├── services/
│   └── ai_service.dart
│
└── screens/
    ├── generate_exam_screen.dart
    ├── exam_screen.dart
    └── result_screen.dart
```

## Screenshots

<p align="center">
  <img src="docs/screenshots/generate-exam.JPEG" width="250" alt="Pantalla de generación de exámenes">
  <img src="docs/screenshots/exam.JPEG" width="250" alt="Pantalla del examen">
  <img src="docs/screenshots/results.JPEG" width="250" alt="Pantalla de resultados">
</p>

### Models

Contiene las estructuras de datos utilizadas por la aplicación, incluyendo los exámenes, preguntas y respuestas.

### Services

Contiene la lógica relacionada con servicios externos.

`AiService` se encarga principalmente de comunicarse con la API de inteligencia artificial y transformar las respuestas recibidas en datos que la aplicación pueda utilizar.

### Screens

Contiene las diferentes interfaces que forman el flujo principal de StudyAI:

* `GenerateExamScreen` — Configuración y generación del examen.
* `ExamScreen` — Realización del examen.
* `ResultScreen` — Visualización de los resultados.

## Estado del proyecto

**Estado: MVP funcional / Archivado**

StudyAI alcanzó un MVP funcional capaz de generar y realizar exámenes mediante inteligencia artificial.

Durante las pruebas se realizaron múltiples exámenes reales para evaluar el comportamiento de la aplicación y detectar problemas de funcionamiento y experiencia de usuario.

El proyecto se encuentra actualmente archivado y no está en desarrollo activo.

## Limitaciones conocidas

### Fiabilidad de la conexión

Algunas solicitudes a la API pueden fallar y, en determinadas ocasiones, es necesario realizar varios intentos antes de obtener una respuesta correcta.

Una versión futura podría mejorar este comportamiento mediante:

* Timeouts más adecuados.
* Reintentos automáticos.
* Manejo de errores más robusto.
* Mejor retroalimentación al usuario.

### Revisión de resultados

La pantalla de resultados cumple su función, pero la revisión de las respuestas puede resultar poco cómoda.

Una posible mejora sería rediseñar esta sección para presentar las respuestas correctas e incorrectas de una manera más clara e interactiva.

### Calidad de la generación mediante IA

La generación funciona correctamente con temas generales y conocidos, pero los temas extremadamente específicos pueden producir información incorrecta o incluso contenido inventado.

Entre las posibles soluciones se encuentran:

* Mejorar los prompts utilizados para generar los exámenes.
* Implementar validación adicional del contenido.
* Incorporar fuentes externas.
* Explorar arquitecturas basadas en búsqueda o **RAG (Retrieval-Augmented Generation)**.

## Configuración

Para ejecutar StudyAI localmente es necesario proporcionar las credenciales necesarias para acceder al servicio de IA.

Las claves y credenciales se gestionan mediante variables de entorno y **no forman parte del repositorio**.

Por razones de seguridad, nunca se deben incluir claves de API directamente en el código fuente ni subirlas a GitHub.

## Objetivo del proyecto

StudyAI fue desarrollado como un proyecto práctico para explorar:

* Desarrollo de aplicaciones móviles con Flutter.
* Integración de APIs externas.
* Consumo de servicios de inteligencia artificial.
* Procesamiento de datos JSON.
* Separación de responsabilidades dentro de una aplicación.
* Diseño de una experiencia educativa basada en generación de contenido mediante IA.

---

**StudyAI — Flutter + Dart + AI**
