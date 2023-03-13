# Chat App

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation guide

### Requirements
1. Flutter installed in your favourite text editor.
1. Android Studio or your preferred emulator(works on your actual Android device too).

### How to get started
```bash
git clone https://github.com/ElNgatia/chat_app

cd {foldername}

code .
```
Once the code loads in your editor, in this case, Visual Studio Code, run
```flutter
flutter get pub
```
to update the packages required.

## Project Scope

This project targets Android platform only. Any other platform may or may not run as intended and should be noted that no intentions are in place to build it for other platforms.

## Project Goal

This project seeks to deliver real time messaging using Firebase as the backend. We have implemented a Google sign up to identify the users.
A profanity filter has been put in place to check the messages sent to other users.
The list used to filter out words can be found at [LDNOOBW on Github](https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words)