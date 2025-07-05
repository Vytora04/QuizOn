# QuizOn!

**QuizOn** is a simple and modular Flutter quiz application.  
This project is structured for easy extension, UI improvement, and integration with backend services (such as Firebase).

---

## 🚀 Features

- **Dummy login** (ready to upgrade to Firebase Auth)
- **Home Screen**: navigate to quiz & leaderboard
- **Quiz**: auto-progress questions, score calculation
- **Leaderboard**: display top user scores (dummy, ready for backend)
- **Modular UI** with reusable widgets
- **Clean folder structure**: /models, /services, /widgets, /screens, /utils

---

## 📁 Project Structure

```
lib/
  models/         # Data models (User, Question, etc.)
  services/       # Auth & DB Service (login, score, leaderboard logic)
  screens/        # Each page (login, home, quiz, leaderboard, etc.)
  widgets/        # Reusable widgets (question card, option button, etc.)
  utils/          # Constants, helpers, theme
assets/           # Images, icons (register in pubspec.yaml)
pubspec.yaml
```

---

## 🛠️ Getting Started

### 1. Install Dependencies
```sh
flutter pub get
```

### 2. Run on Emulator/Device
```sh
flutter run
```

### 3. Assets Structure
Place images/icons in the `assets/` folder (e.g. `assets/images/logo.png`)  
Make sure to register in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
```

---

## 👤 Collaboration & Integration

- All login and database logic is currently **dummy** (local, without backend).  
  **Integrating backend (Firebase Auth/Firestore) only requires replacing the functions in `/services/`.**
- Widgets and UI are modular—just swap in your data and logic.
- File, folder, and model naming is consistent for easy merging and teamwork.

---

## 💡 TODO / Next Steps

- [ ] Integrate Firebase Auth (login, register, session)
- [ ] Integrate Firestore for scores & leaderboard
- [ ] Timer per question
- [ ] Transition animations
- [ ] Quiz category mode
- [ ] UI/UX polish (theme, illustration, etc.)
- [ ] Add automated tests

---

## ✨ Development Tips

- For better UI, use [Google Fonts](https://pub.dev/packages/google_fonts) and global ThemeData in main.dart.
- Put new logic in services/ (not in UI).
- Use widgets from widgets/ for a consistent and easily updatable UI.
- Store constants in utils/constants.dart for easy access and modification.

---

## 📝 Credits

- Starter structure by [Vytora04](https://github.com/Vytora04) & contributors.
- Flutter & Dart ecosystem.

---

Feel free to fork, develop, and contribute! 🚀