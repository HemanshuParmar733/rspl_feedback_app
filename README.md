# feedback_app

# Description :
Flutter firebase application for both Android and iOS platform.

# APK Link (Android):
https://i.diawi.com/AhzXUu

# TechStack Used:

- architecture: TDD style clean architecture
- state management: Cubit from flutter_bloc library
- state generation and comparison: freezed package
- dependency injection : used get_it library and implemented feature wise dependency injection
- navigation: go_router library is used for navigation
- database : FirebaseAuth for email/pass authentication and Firestore as database, Sharedpreferences
  for storing local session data.
- responsive : application is responsive for mobile and tablets.



# Feature:

- Login or Register using Email & Password
- User can post feedback with category, user can also post anonymous feedback without mentioning
  reporter name.
- User can view others feedbacks with all the details and like/dislike the feedbacks.
- User can logout from system.



# Extra features that can be added later on:

- Pagination of feedbacks
- Local search of feedback by feedback title
- Display image of the feedback sender in feedback
- If user is owner of selected feedback he can edit/delete feedback
- Email verification using link and forgot password
- Localization and dark mode support


# Recommended flutter version
Flutter 3.13.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision ff5b5b5fa6 (2 weeks ago) • 2023-08-24 08:12:28 -0500
Engine • revision b20183e040
Tools • Dart 3.1.0 • DevTools 2.25.0

# How to run project?

- flutter pub get
- dart run build_runner build --delete-conflicting-outputs
- flutter run

# How to build release apk for internal release?

- flutter clean
- flutter pub get
- flutter build apk --release
- You can find the generated build at : build/app/outputs/flutter-apk/app-release.apk 
