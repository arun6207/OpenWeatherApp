# OpenWeatherApp
Swift code for consuming open weather API's

## Code
- Swift 5.0
- Minimum deployment target iOS 13.0 

## Build Requirements
 - **Xcode 11.3.1 (10A255)
 - Command Line Tools: Xcode 11.3.1

## Available build configuration
- BaseURL	: (http://api.openweathermap.org/data/2.5/)

## Project Structure
- 📁 StoryBoards      : StoaryBoards used for the project. Currently we have only one ie. Main.storyBoard
- 📁 ViewControllers	: All UIViewControllers of the project
- 📁 Views            : Custom views 
- 📁 Helpers	        : All required helper classes and extensions
- 📁 Models	          : All models
- 📁 Network          : All classes related to Network layer (URLSessions)
- 📁 Resources        :All third party related files (mock files)

##### Additional information
- Project doesn't have any client database. Neither saved in userdefaults nor coredata
- There are no unit/ui tests.

##### Constraints
- It's not possible to debug using devices higher than iOS 13 (max version Xcode 11.3.1 supports)







