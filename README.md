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

### testing            

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
                

     
<div class="row">
  <div class="column">
   <img src="https://drive.google.com/file/d/18gnCdRch1C-aqjXM4GgH-UKasMlinvAx/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/18_1HlkCTRwGogwS2OeJkM39JLkT3L0RA/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19Vyy7b_Gsf97Eav6R8Ci_uPnno2bdPtb/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19VJ5Bi3ZVv5U9wx8NsrLEi6atduRyaYX/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/1937zgMBxTWwSQYc45tbW5idpr89xfyuG/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19GchSgCPudosDxWW6--ecNkXckBZ66Pb/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/18ot-dx5idc6TfAmkUxqEcZe0Ax-o1VKC/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/18sFX7jy_IhtQXZZiTomRPRyW_hb-cvFP/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/18t6LBqWjAh-KZi_hGwiPXKjJISLq4f-3/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/18yM8l4lYUM1DE704Mn_MEj0ZSVlIAftU/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/1904KGmujP7QAw91LeL2n_XIM5M4bxGxC/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/1979j9bZ8WlNQzJ7kDaeXw-BVOLsSYZ-4/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19DFVsgA9OCzaxlrXQ3Hm0nOfPxzHnFOE/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19U2Eim-qoRfvrZkjU_77Tt4lAyok_42q/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19efBbYO5jfxFpkmfC8vNl1aZR-VamSaB/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/19_tvqRyLqOr8P3tfipxb1VC3muSxUCYP/view?usp=drive_link" height="400"/>
<img src="https://drive.google.com/file/d/18UMXWFH-QQV_R4tl9aZor_Dm9Qsl8qXH/view?usp=drive_link" height="400"/>

   </div>
  
</div>
