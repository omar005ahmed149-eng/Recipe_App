# Recipe App

A Flutter recipe application built to practice scalable app architecture, state management, API integration, and Firebase services in a real-world style project.

This project combines remote data, authentication, local persistence, and reusable architecture patterns. Some parts of the codebase were adapted and refactored from an earlier movie application, then reorganized to fit the recipe domain.

## Main Features

### Recipe Viewer (Home Screen)

The home screen allows users to browse and explore recipes fetched from an external API.

Features include:

* recipe listing
* recipe details
* structured recipe information
* API-driven content rendering
* state handling with Bloc

### Profile Screen

The profile screen focuses on user-related content and personal activity.

It includes:

* **Cook List** — recipes saved by the user
* **History** — previously viewed recipes and recent activity
* user authentication state
* profile-related local persistence

## Tech Stack

* **Flutter**
* **Bloc** for state management
* **REST API integration**
* **Firebase Authentication**
* **Firebase Storage**
* **Local file storage**

## Project Background

This project reuses selected files and architectural ideas from a previous movie app.

Instead of building everything again from scratch, the goal was to practice a more realistic workflow:

* reusing existing code where it made sense
* refactoring old components
* adapting API layers for a new domain
* improving folder structure and maintainability

That process helped make the project closer to real development work, where existing codebases evolve over time.

## Architecture

The application follows a feature-oriented structure with clear separation of responsibilities.

### Presentation

* screens
* widgets
* Bloc state management

### Data

* API services
* Firebase services
* repositories

### Local Storage

* file handling
* persistent user-related data

This structure makes the project easier to scale, maintain, and extend.

## What I Practiced

Through this project I worked on:

* managing asynchronous state with Bloc
* consuming REST APIs and mapping responses
* Firebase authentication flows
* storing and retrieving images with Firebase Storage
* reading and writing local files
* reusing and refactoring code from an older project
* structuring a Flutter project for maintainability

## Getting Started

### Prerequisites

* Flutter SDK installed
* Firebase project configured
* Android Studio or VS Code

### Installation

```bash
git clone <your-repository-url>
cd recipe-app
flutter pub get
```

### Firebase Setup

Add your Firebase configuration files:

* `google-services.json` for Android
* `GoogleService-Info.plist` for iOS

Then run:

```bash
flutter run
```

## Future Improvements

* favorites and bookmarks
* offline caching
* pagination
* advanced filtering
* profile editing
* improved UI polish

## Notes

This project is part of my ongoing Flutter learning journey, with a focus on building production-style applications that combine architecture, state management, remote data, and persistent storage.
