# M.E.O.Z LABORATOIRE
Microscope Électronique-Optique de Ziko — application Flutter Android (Français + Arabe).
Devise : Maths → Vie Humaine (physique et chimique) → Branche de Ziko.

## Compiler l'APK
1. Pousser ce dépôt sur GitHub (`meoz-laboratoire`).
2. Sur codemagic.io, connecter GitHub, ajouter le dépôt, choisir le workflow `meoz-apk` (codemagic.yaml).
3. Lancer la compilation, télécharger l'APK.

## Configuration
Dans `lib/services/api_service.dart`, remplacer `baseUrl` par l'adresse HTTPS du backend FastAPI.

## Sécurité
Le chiffrement AES-256 et le JWT sont prévus côté backend (PostgreSQL). Le stockage SQLite local n'est pas encore chiffré.

## Éthique
« Estimation assistée par IA. À confirmer par un laboratoire. » — le médecin seul pose le diagnostic.
Les versets doivent être validés par un savant qualifié.
