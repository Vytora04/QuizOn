# QuizOn

A modular Flutter quiz app featuring Firebase authentication, registration, profile management, quiz gameplay, leaderboard, and clean code structure—ready for further extension.

---

## 🚀 Features

- **Firebase Auth**: Secure login and registration
- **Profile Screen**: View and edit user profile
- **Quiz Gameplay**: Automatic question progression and scoring
- **Leaderboard**: Displays top user scores (Firebase-backed)
- **Modular UI**: Reusable widgets and clean folder structure
- **Easy Collaboration**: Extensible, well-organized codebase

---

## 📁 Project Structure

```
lib/
  models/         # Data models (User, Question, etc.)
  services/       # Auth, DB, and Firebase services
  screens/        # App screens: login, register, profile, home, quiz, leaderboard
  widgets/        # Reusable UI components
  utils/          # Constants, helpers, themes
assets/           # Images, icons (registered in pubspec.yaml)
pubspec.yaml
```

---

## 🛠️ Getting Started

1. **Install dependencies:**
   ```sh
   flutter pub get
   ```

2. **Firebase setup:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your Android/iOS/Web app to Firebase
   - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place them in the respective directories
   - Enable Email/Password authentication in Firebase Authentication

3. **Run the app:**
   ```sh
   flutter run
   ```

4. **Assets:**
   - Place images/icons in the `assets/` directory and register them in `pubspec.yaml`:
     ```yaml
     flutter:
       assets:
         - assets/images/
     ```

---

## 👤 Account Management

- Register a new account via the app’s registration screen
- Login with your credentials
- View and edit your profile on the Profile screen

---

## 🤝 Collaboration & Integration

- Authentication and user data are now handled with Firebase.
- Quiz and leaderboard logic are easily extendable for categories, timers, and more.
- Consistent file and folder naming for easy navigation and teamwork.

---

## 💡 Roadmap / TODO

- [ ] Add quiz categories
- [ ] Implement per-question timer
- [ ] Add transition animations
- [x] UI/UX polish and theming
- [ ] Automated testing

---

## ✨ Development Tips

- Use [Google Fonts](https://pub.dev/packages/google_fonts) and ThemeData for UI polish.
- Add new business logic in `services/`, not directly in UI.
- Reuse widgets from `widgets/` for a consistent design.
- Store constants in `utils/constants.dart` for easy updates.

---

## 📝 Credits

- Starter project by [Vytora04](https://github.com/Vytora04) & contributors.
- Built with Flutter, Dart, and Firebase.

---

Feel free to fork, improve, and contribute! 🚀
