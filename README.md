# ExploreNow 

## Overview

ExploreNow is a hybrid app project designed to integrate physical and digital experiences, leveraging Google Maps and LINE official accounts to promote local tourism and culture. The app guides users to visit attractions, rewarding them upon arrival to encourage continued exploration. This modular system can be adapted to various activities, such as pub crawling or coffee crawling events.

## Features

- **Interactive Exploration**: Guides users to local attractions and rewards them for visiting.
- **Modular Design**: Can be adapted for different activity scenarios, such as pub or coffee crawls.
- **LINE Official Account Integration**: Utilizes LINE's point card functionality and chatbot for user interaction.
- **LIFF and Flutter Web App**: Incorporates a Flutter-based web app hosted on Firebase to display maps and attraction details.
- **Google Sheets Integration**: Enables organizers to easily edit and update attraction and partner store information.

## Tech Stack

- **Frontend**: Flutter Web App hosted on Firebase Hosting
- **Backend**: Google Apps Script
- **Platform**: Google Maps API, LINE Messaging API, LINE LIFF
- **Storage**: Google Sheets

## Prerequisites

1. A LINE Developers account with a channel configured for Messaging API.
2. Firebase account with hosting enabled.
3. Google account with access to Google Sheets.


## Usage

1. Users scan QR codes at attractions to collect points using LINE's point card feature.
2. Points can be redeemed for rewards from local partner stores.
3. Organizers can update attraction details via Google Sheets, automatically reflected in the app.

## Future Enhancements

- **Custom Rewards**: Allow organizers to configure unique rewards for specific events.
- **User Authentication**: Add personalized profiles for enhanced user experiences.
- **Advanced Analytics**: Integrate analytics to track user behavior and improve event design.

