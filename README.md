# Gram Panchayat Survey (ग्राम पंचायत सर्वेक्षण)

A Hindi-first Flutter app for running **door-to-door household surveys in a
village panchayat**. Field surveyors log in, fill in a 21-step questionnaire per
household, and attach photos and voice-typed remarks. Administrators manage the
surveyors, review every submission ward by ward, and print a **formatted PDF
report** for any household.

It was built to replace paper survey forms: the data lands in Firestore the
moment a survey is saved, and the PDF reproduces the official form layout for
printing.

## What it does

### Field surveyors
- **Login** with credentials created by the admin.
- **A 21-page guided survey** per household (`lib/pages/page1` … `page21`), in
  Hindi throughout. It covers the head of household and their photo, family
  members, voter, ration and Aadhaar details, bank account, housing-scheme
  status, toilet and sanitation, drinking water and handpumps, ration-card
  members, and other welfare schemes.
- **Conditional follow-ups:** for example, choosing "no toilet" asks for the
  reason, and missing benefits ask for a remark.
- **Hindi voice input:** remarks can be dictated with on-device speech-to-text
  using the `hi-IN` locale, which suits surveyors who are slower at typing in
  Devanagari.
- **Photo capture:** the camera image is uploaded to Firebase Storage and linked
  to the record.
- **Edit mode:** reopen and correct a submitted survey (सर्वेक्षण संपादित).
- Each household gets a **unique serial** made of the ward number plus a random
  suffix.

### Administrators
- A **separate admin login** backed by an `admin` collection.
- **Surveyor management:** create surveyor accounts, list them and reset their passwords.
- **Ward-wise dashboard** of every submission, with a detail view.
- **PDF report generation** with the `pdf` package: a multi-section
  printable form (about 90 laid-out fields) including the household photo. iPhone
  HEIC photos are converted before embedding. Reports go straight to the system
  print or share dialog through `printing`.

## Architecture

```
lib/
  main.dart            Firebase init, GetX app
  homepage.dart        Hindi landing: start survey / admin
  login_page.dart      surveyor login
  controller.dart      HomeController: all survey state as Rx fields,
                       save/update to Firestore, image upload to Storage
  pages/page1-21.dart  one screen per survey section
  admin/               admin login, dashboard, users, create user,
                       details, admin_controller (PDF builder)
  widgets/, utils/     shared inputs and helpers
```

**Data model (Cloud Firestore):**
- `details`: one document per household survey (ward, serial, surveyor id,
  answers, photo URL)
- `users`: surveyor accounts
- `admin`: admin accounts

## Tech stack

Flutter · Dart · GetX · Firebase (Core, Cloud Firestore, Storage) ·
speech_to_text (Hindi) · pdf + printing · heif_converter · image_picker ·
awesome_dialog · shared_preferences

## Running

```bash
flutter pub get
flutter run
```

This needs a Firebase project. Add your own `android/app/google-services.json`
and the matching options in `lib/main.dart`, then create the `admin` collection
with an admin account.

## Data privacy

The survey collects personal information (Aadhaar, phone and bank details). Any
deployment should lock down Firestore and Storage security rules so that only
authenticated surveyors can write and only admins can read.
