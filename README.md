Aquí tienes un ejemplo de un archivo README para tu aplicación de Flutter que utiliza el paquete `mapbox` y otras dependencias relacionadas:

# Maps App

Una aplicación de Flutter que muestra un mapa basado en tu ubicación actual y te permite buscar direcciones o seleccionar manualmente una ubicación en el mapa. Utiliza la API de Mapbox para mostrar el mapa y calcular la distancia y el tiempo estimado hasta el destino seleccionado.

## Capturas de pantalla

_Inserta aquí capturas de pantalla de tu aplicación, si deseas mostrar cómo se ve._

## Características

- Visualización del mapa basado en la ubicación actual del usuario.
- Búsqueda de direcciones para seleccionar un destino.
- Selección manual de ubicaciones en el mapa.
- Cálculo de la distancia y el tiempo estimado hasta el destino seleccionado.
- Visualización de la ruta en la que te estás dirigiendo en tiempo real.

## Dependencias

- [animate_do](https://pub.dev/packages/animate_do): ^3.0.2
- [bloc](https://pub.dev/packages/bloc): ^8.1.1
- [cupertino_icons](https://pub.dev/packages/cupertino_icons): ^1.0.2
- [dio](https://pub.dev/packages/dio): ^5.1.1
- [equatable](https://pub.dev/packages/equatable): ^2.0.5
- [flutter](https://flutter.dev/): SDK de Flutter
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): ^8.1.2
- [geolocator](https://pub.dev/packages/geolocator): ^9.0.2
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter): ^2.2.5
- [google_polyline_algorithm](https://pub.dev/packages/google_polyline_algorithm): ^3.1.0
- [permission_handler](https://pub.dev/packages/permission_handler): ^10.2.0
- [mapbox](https://pub.dev/packages/mapbox): _Versión específica no especificada_

## Instalación

1. Clona este repositorio en tu máquina local:

   ```
   git clone https://github.com/tu-usuario/maps_app.git
   ```

2. Navega hasta el directorio del proyecto:

   ```
   cd maps_app
   ```

3. Ejecuta el siguiente comando para obtener las dependencias:

   ```
   flutter pub get
   ```

4. Configura tus credenciales de Mapbox en el archivo `android/app/src/main/AndroidManifest.xml` y `ios/Runner/AppDelegate.swift`. Sigue la documentación de [Mapbox](https://docs.mapbox.com/android/maps/overview/#configure-a-maps-api-key) para obtener más información sobre cómo obtener una clave de API.

5. Ejecuta la aplicación en tu dispositivo o emulador:

   ```
   flutter run
   ```

## Uso

_Proporciona instrucciones sobre cómo utilizar tu aplicación, cómo buscar direcciones, seleccionar una ubicación, etc._

## Contribución

Las contribuciones son bienvenidas. Si encuentras algún error o tienes sugerencias de mejoras, siéntete libre de abrir un [issue](https://github.com/tu-usuario/maps_app/issues) o enviar un [pull request](https://github.com/tu-usuario/maps_app/pulls).

## Licencia

_Inserta aquí la licencia que deseas utilizar para tu aplicación, por ejemplo: [MIT License](https://opensource.org/licenses/MIT)._
