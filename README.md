# App Dados

App simples com grid de 6 pessoas que redirecionam para links do Google Drive.

## Como compilar o APK

### Opção 1: Android Studio (Recomendado)
1. Abra o Android Studio.
2. File > Open > Selecione a pasta `dados_app`.
3. Aguarde a sincronização do Gradle.
4. Build > Build Bundle(s) / APK(s) > Build APK(s).
5. O APK estará em `android/app/release/app-release.apk`.

### Opção 2: Flutter CLI
```bash
cd dados_app
flutter pub get
flutter build apk --release
```

O APK gerado estará em: `build/app/outputs/flutter-apk/app-release.apk`

## Pessoas no App

1. EDERSON DA SILVA
2. ANY RITA
3. AVR JOSEFINO
4. SIRETE ARRUBES
5. GABRIELA ARRUBES LEANDRO
6. ANDREW DE SOUZA

Cada pessoa é um cartão colorido que abre o respectivo link do Drive ao toque.

## Design

- Grid 2x3 tipo Instagram.
- Cores gradiente em cada cartão.
- Animação de escala ao tocar.
- Icons de pessoas no centro.
