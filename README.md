# Planets App

## Overview

The goal of this project is to create a responsive planet exploration app that allows users to browse a list of planets, search for specific planets, view detailed information about each planet, and mark their as favorites.

## How to run the project

### Developer Environment Requirements

- Go to [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install) (Minimum version recommended: 3.27.3)

- Download the flutter SDK and extract it in some location (e.g., C:\flutter en Windows)

- Following the windows example go to "Environment variables". Add C:\flutter\bin to Path and then restar your terminal

- Run `flutter doctor -v` to verify the installation and check others steps for the installation

### Steps to run the project

1. Run `git clone https://github.com/DavidAriza/planets-app.git` or download the project as Zip and extrac all in your desired folder.

2. Run `flutter devices` and check the id (2nd column) of the device you want to run it

3. Run `flutter run -d <device id>` to start the project in an emulator or a real device 

## Technical considerations

Clean Architecture ensures a clear separation of concerns by organizing the code into distinct layers: Presentation (UI & state management), Domain (business logic & use cases), and Data (repositories & data sources).

Riverpod is used to manage state because it is robust, typically requires less boilerplate, making it easier to implement and maintain, Riverpod also allow us to inject our dependencies so we don't need and extra package for that (I usually use get_it with other state management solutions).

Hive serves as a local database solution for storing favorite planets. It is fast, lightweight, and non-relational, making it perfect for our use case.

dartz package for better error handling – Either<Failure, Success> helps return failures or results instead of just throwing exceptions.

go router is a powerful routing package that simplifies navigation

