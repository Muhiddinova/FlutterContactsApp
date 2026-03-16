# Flutter Contacts App

A simple **Flutter Contacts Application** for storing and managing contacts locally.
The app allows users to create, edit, view, and delete contacts with persistent local storage.

## ✨ Features

* Add new contacts
* Edit existing contacts
* Delete contacts
* Save contacts locally
* Input masking for phone numbers
* State management using BLoC
* Local database support

## 🧰 Technologies Used

This project uses the following Flutter packages:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  mask_text_input_formatter: ^2.5.0
  flutter_bloc: ^8.1.2
  bloc: ^8.1.4
  sqflite: ^2.4.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
```

### Package Purpose

* **flutter_bloc / bloc** – State management
* **sqflite** – Local SQLite database
* **hive / hive_flutter** – Lightweight local storage
* **shared_preferences** – Store simple app preferences
* **mask_text_input_formatter** – Format phone number inputs

## 🎨 Design

The UI design for this project was created in **Figma**.

## 🚀 Getting Started

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/FlutterContactsApp.git
```

Go to the project directory:

```bash
cd FlutterContactsApp
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 📱 Platform Support

* Android
* iOS
* Web (optional)

## 📂 Project Purpose

This project is mainly used as a **practice template for Flutter development**, including:

* BLoC architecture
* Local data storage
* Clean Flutter project structure

## 👩‍💻 Author

Developed by **Muhiddinova**

---

⭐ If you find this project useful, feel free to star the repository.
