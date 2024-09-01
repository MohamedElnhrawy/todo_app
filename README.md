# Flutter ToDo App with Hive and FireBase (Auth and FireStore)
## ToDo App using Flutter implemented with Hive DataBase(Locale Caching), FireBase(Auth && Sync) and SharedPreferences for save Locale and UserStatus

## Overview
- This project embraces a robust development approach by incorporating Clean Architecture principles with Bloc and Providers.
- A Flutter-based ToDo application that leverages Firebase for authentication, Hive for local caching of tasks, and Firestore for syncing tasks with the cloud.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Testing](#testing)
- [Images](#images)

## Features

- **Firebase Authentication**: Secure user login and registration.
- **Hive Caching**: Efficient local storage of tasks.
- **Firestore Sync**: Real-time synchronization of tasks with Firebase Firestore.
- **Background Sync**: Periodic synchronization of tasks using `WorkManager` every 6 hours.
- **Modular Architecture**: Clean and maintainable code structure.
- **TDD**: Test-Driven Development practices using Mock and Mocktail for reliable and maintainable code.
- **Localization**: Multi-language support for a better user experience.


## Architecture

The app follows a modular architecture and is organized as follows:

### Core Modules

- **Common**: Contains reusable components like app widgets, views, and utility functions.
- **Errors**: Defines custom error handling.
- **Extensions**: Provides extensions to enhance functionality.
- **Res**: Manages app resources.
- **Services**: Provides core services and API integrations.
- **Usecases**: Contains business logic and use case implementations.
- **Utils**: Contains utility functions and helpers.

### Features

Each feature is structured into three main layers:

- **Data**: Manages data models, repositories, and data sources.
- **Domain**: Contains entities, repositories, and use cases.
- **Presentation**: Manages BLoC state management, views, and UI widgets.

### Background Sync

- **WorkManager**: Utilizes `WorkManager` to periodically sync local tasks with Firestore every 6 hours. This ensures that tasks are consistently updated in the cloud even when the app is not in use.

### folder Structure

```plaintext 
lib
├── core
│   ├── common
│   │   ├── app
│   │   ├── views
│   │   └── widgets
│   ├── errors
│   ├── extensions
│   ├── res
│   ├── services
│   ├── usecases
│   └── utils
└── src
    └── features
        ├── auth
        │   ├── data
        │   ├── domain
        │   └── presentation
        ├── profile
        │   ├── data
        │   ├── domain
        │   └── presentation
        ├── dashboard
        │   ├── data
        │   ├── domain
        │   └── presentation
        └── tasks
            ├── data
            ├── domain
            └── presentation    
```            

### testing

```plaintext 
test
└── src
    └── features
        └── auth
            ├── data
            │   ├── repositories
            │   └── datasources
            ├── domain
            │   └──  usecases
            │ 
            └── presentation
                └──  bloc
```                  

### images

<div class="row">
  <div class="column">
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-001544_One%20UI%20Home.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-043832.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-043839.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-043921.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-043928.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044005.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044048.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044057.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044131.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044141.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044148.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044156.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044206.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044212.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044220.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044225.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044248.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044255.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044301.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044309.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044317.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044332.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044820.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044843.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screenshot_20240901-044851.jpg?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screen%20Shot%202024-09-01%20at%206.09.47%20AM.png?raw=true" height="400"/>
   <img src="https://github.com/MohamedElnhrawy/todo_app/blob/master/images/Screen%20Shot%202024-09-01%20at%206.09.37%20AM.png?raw=true" height="400"/>
   </div>
  
</div>
