# Koora Live iOS App

Welcome to the Koora Live iOS application! Utilizing a free API, we bring you real-time updates on the English Premier League, allowing you to stay informed about team matchups at your fingertips.

## Table of Contents
- [Getting Started](#getting-started)
- [Key Features](#key-features)
- [Used In The APP](#used-in-the-app)
- [Screenshots](#screenshots)
- [Important to know](#important-to-know)
- [App Structure](#app-structure)
- [Authors](#authors)

## Getting Started

To set up and run the KooraLive app, follow these steps:

1. Clone the repository:
   ```swift
   git clone https://github.com/dalia61/KooraLive.git
   cd KooraLive
   ```
   
2. Install CocoaPods dependencies:
  ```swift
   pod install
   ```
   
3. Open the Xcode workspace and build the app.

## Key Features

The app has two lists:

1. List of Matches: 
   - Explore a curated list of matches. 
   - Each cell represents the team’s name, flag, the time of the game, and the game result if played.
   - The list is sectioned by day, and the first section is today's match or the next if the current day has no fixtures.
   - Allows you to add or delete matches to your favorites.

2. List of Favorite Matches:
   - Displays favorite matches that are marked.

## Used In The APP

- SWIFT
- UIKit
- MVP Architecture Pattern
- Coordinator Pattern For Handling Navigation
- UseCase Layer
- Network Layer (Alamofire)
- Realm For Caching Favorite Matches using [Generic Realm Manager]
- Delegation Pattern For Communication between Module entities
- Kingfisher For Images Downloading and Caching
- XIB Files
- Figma For Designing The UI

## TODO:-

- [ ] Code Refactoring
- [ ] Unit Tests

## Screenshots

Here are some screenshots from the app:

- **Launch Screen**

  <img src="https://github.com/dalia61/KooraLive/assets/70582993/e2a29752-b9eb-4afe-9c4e-a770e9952431" width="300" height="600">

- **Schedule Matches List**

   <img src="https://github.com/dalia61/KooraLive/assets/70582993/c51f936a-29e9-40dd-84d2-b72bed155e19" width="300" height="600">

- **Favorite Matches List**

  <img src="https://github.com/dalia61/KooraLive/assets/70582993/8941b42f-5d91-4949-910e-cbd4cfda562d" width="300" height="600">



## Important to know 

-  The app retrieves matches from the JSON endpoint https://api.football-data.org/v4/competitions/2021/matches instead of the V2 endpoint. The V4 endpoint is preferred due to the additional information it provides, such as flags for teams.
 
- Separation of Concerns: MVP divides the application into distinct layers, promoting a clear separation of responsibilities for easier maintenance and debugging.

- Enhanced Code Structure: By incorporating Coordinator, Network, Persistence, and UseCase layers, the architecture achieves a well-organized and cohesive codebase, improving readability and maintainability.


## App Structure

The app follows a modular structure, divided into different components:

- **Koora Live**
  
  * Koora Live
     * Foundation
        * App
        * Configuration
        * Extensions
          * UI
        * Externals
          * Coordinator
          * Data Persistence
             * Realm
          * DataNetwork
        * Resources
  * Modules
     * Match
        * Coordinator
        * Network
        * UseCase
        * Model
        * View
        * Presenter
      
## Authors

Created by:
- Dalia Hamada
  * [LinkedIn](https://www.linkedin.com/in/daliahamada/)

Don't hesitate to reach out if you have any questions or need further clarification about the project.
