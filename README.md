
<div align="center">

<img width="300" src="https://i.imgur.com/03HqEIy.png">

<h1 style="border-bottom: none">
    <b><a href="#">Flutter Todo App</a></b>
</h1>

A minimalistic `TODO` app built with **`Flutter`**. State management is handled by **`Riverpod`**, and local databases **`Isar`** and **`Hive`** provide efficient data storage. The project follows **`Clean Architecture`** principles for a modular codebase.

[![Made-with-flutter](https://img.shields.io/badge/Made%20with-Flutter-orange)](https://flutter.dev/) 
![GitHub repo size](https://img.shields.io/github/repo-size/ivansaul/flutter_todo_app)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**`Don't forget to ⭐ the repo`**

![GitHub stars](https://img.shields.io/github/stars/ivansaul/flutter_todo_app?style=social)
![GitHub forks](https://img.shields.io/github/forks/ivansaul/flutter_todo_app?style=social)

</div>

![Repo Banner](https://i.imgur.com/ZYLGAGh.png)

> [!Note]
> This project is not completed yet, as soon as possible when it's complete I will update it here. Stay tuned for more exciting updates!

> [!Tip]
> The `Isar` database implementation is in `new-isar` branch and the `Hive` database implementation is in `new-hive` branch.

## Features

- [x] Task creation.
- [x] Task editing.
- [x] Task deletion.
- [x] Task completion tracking.
- [x] Local data base (Isar / Hive)
- [x] Custom search bar
- [x] Custom Bottom navigation bar
- [ ] Sync across devices.
- [ ] Customizable labels and tags.
- [ ] Customizable settings.

and much more...
Check it yourself :)


## Screenshots

<p align="center">
  <img src="https://i.imgur.com/39QVqTZ.jpg" alt="Screenshots">
</p>

## Demo

<p align="center">
  <img src="https://raw.githubusercontent.com/ivansaul/demos/master/flutter/todo-list-app-demo.gif" alt="Demo">
</p>

## Packages we are using

Package | Usage
------------ | -------------
[isar](https://pub.dev/packages/isar) | Extremely fast, easy to use, and fully async NoSQL database for Flutter.
[hive](https://pub.dev/packages/hive) | Lightweight and blazing fast key-value database written in pure Dart.
[uuid](https://pub.dev/packages/uuid) | Generator and Parser for all Dart platforms.
[riverpod](https://pub.dev/packages/riverpod) | A simple way to access state from anywhere in your application.
[google_fonts](https://pub.dev/packages/google_fonts) | A Flutter package to use fonts from fonts.google.com.
[stylish_bottom_bar](https://pub.dev/packages/stylish_bottom_bar) | A collection of stylish bottom navigation bars.

## Design

- [Figma](https://www.figma.com/community/file/1124394532783501567)

## Building from Source

1. If you don't have Flutter SDK installed, please visit official [Flutter](https://flutter.dev/) site.
2. Fetch latest source code from master branch.

    ```bash
    git clone https://github.com/ivansaul/flutter_todo_app.git
    ```

3. Run the app with Android Studio or VS Code. Or the command line.

```bash
dart pub get
dart run build_runner watch
flutter run
```

## Contribute

Contributions are welcome.

## Facing any Issue?

Feel free to open an Issue :)
