# 💼 BTG Fondos - Prueba Técnica Flutter

Aplicación móvil desarrollada en **Flutter** (iOS y Android) que permite gestionar fondos de inversión (FPV/FIC) para BTG Pactual. Implementa arquitectura limpia, código limpio, pruebas unitarias, CI/CD con Fastlane, y despliegue con CloudFormation.

---

## 🚀 Características

- ✅ Login con perfiles de usuario (admin / consultor)
- ✅ Suscripción a fondos con validación de saldo y mínimos
- ✅ Cancelación de fondos con devolución del valor invertido
- ✅ Historial de transacciones por usuario (mock)
- ✅ Notificación mock por email o SMS al suscribirse
- ✅ Formulario para cambio de contraseña
- ✅ Arquitectura limpia (Domain - Data - Presentation)
- ✅ Bloc para gestión de estado
- ✅ CI/CD con **Fastlane**
- ✅ Despliegue en AWS con **CloudFormation**
- ✅ Mocks en JSON (`assets/mocks/data.json`)
- ✅ Código modular, escalable y probado

---

## 🧱 Arquitectura del Proyecto

    lib/
    ├── core/             # Constantes, errores, utils, theme
    ├── data/             # Models, Repositories, Datasources (mock)
    ├── domain/           # Entidades, repositorios, casos de uso
    ├── presentation/     # Blocs, Pages, Widgets
    ├── main.dart
    assets/mocks/         # Usuarios, fondos y transacciones
    test/                 # Pruebas unitarias por capa
    ---

## 🧪 Pruebas Unitarias

    ```bash
flutter test

Cobertura:
• Validaciones de saldo
• Casos de uso (subscribe, cancel)
• Modelos
• Bloc (eventos y estados)

⸻

🛠️ CI/CD con Fastlane

Android

    ```bash
cd android
fastlane deploy_beta

iOS

    ```bash
cd ios
fastlane deploy_beta

Configura:
• android/fastlane/Appfile → clave de Google Play
• ios/fastlane/Appfile → Apple ID y team

⸻

☁️ Despliegue Web con CloudFormation

cloudformation/deploy-flutter-web.yaml

Crea bucket S3 público con hosting para Flutter Web.

aws cloudformation deploy \
  --template-file cloudformation/deploy-flutter-web.yaml \
  --stack-name btg-fondos-web \
  --capabilities CAPABILITY_IAM

📦 Mocks (assets/mocks/data.json)

Contiene:
• Usuarios (admin / consultor)
• Fondos disponibles (FPV, FIC)
• Historial de transacciones

Incluye validación de:
• Rol y permisos
• Saldo mínimo
• Retiro y reintegro
• ID único por transacción

⸻

📲 Ejecución Local
flutter pub get
flutter run

🧑‍💼 Perfiles de prueba
{
  "username": "admin",
  "password": "admin123",
  "role": "admin",
  "balance": 500000
}
{
  "username": "consultor1",
  "password": "consultor123",
  "role": "consultor"
}

📬 Notificaciones

Notificación simulada al suscribirse:
• Muestra mensaje tipo “Notificación enviada por EMAIL/SMS”
• Seleccionable desde Dropdown
