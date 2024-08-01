# Custos Task

This is a Flutter web application for the Custos Task project.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Backendless Configuration](#backendless-configuration)


## Introduction

Custos Task is a web application built with Flutter. The project aims to demonstrate various features and functionalities using the Flutter framework.

## Features

- Responsive design for different screen sizes (mobile, tablet, desktop).
- Integration with Backendless for backend services.
- File uploads , displaying, and downloading

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- [Backendless Account](https://backendless.com/) for backend services
- A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/OmarMustafaIsmail/custos_task.git
   cd custos_task

2. **Install dependencies:**

    ```bash
    flutter pub get



## backendless-configuration

1. **Manage Backendless:**

    - Login to your backendless account 
    - create an app
    - copy the Backendless subdomain and replace the baseUrl in lib/utils/network/remote/end_points.dart with your domain
        note: MAKE SURE TO ADD https:// before your subdomain
    

