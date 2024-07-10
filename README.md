# Sample iOS Swift App

This project is an iOS Swift application that demonstrates how to integrate a single listing API with pagination. It provides a simple UI to display a list of items fetched from the API.

## Features

- Fetches data from a single listing API.
- Implements pagination.
- Provides a simple and intuitive UI for displaying the fetched data.

## Requirements

- macOS
- Xcode 15.0 or above
- Any simulator in Xcode

## Getting Started

1. Clone this repository to your local machine:
    ```sh
    git clone https://github.com/priyankgandhi0/SampleiOS-SwiftApp.git
    ```
2. Navigate into the project directory and open `SampleiOSSwiftApp.xcodeproj`. Wait a few minutes for Xcode to automatically install package dependencies (visible in the bottom of the left sidebar).
3. Choose any simulator and run the app by pressing `CMD + R`.

## Configuration

To modify the API endpoint in the source code:

1. Go to the `Utils` folder.
2. Navigate to the `AIHeaders` folder within `Utils`.
3. Open the `AIServiceConstants.swift` file and change the `URL_PRODUCTS_LIST` API endpoint.

## Usage

- Upon launching the application, it will fetch data from the specified API and display it on the screen.
- Interact with the listed items as per your application requirements.
