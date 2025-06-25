# 🌿 EcoHub

An all-in-one mobile app designed to foster a sustainable lifestyle and provide essential tools for a greener future. EcoHub uses machine learning for plant care, delivers real-time environmental updates, and builds a community passionate about eco-conscious living.

[View the Project Presentation](https://www.canva.com/design/DAGHSRiFVRs/SR74Lbef8n56stodHg_E2w/edit?utm_content=DAGHSRiFVRs&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

---

## 📱 App Showcase

Here's a glimpse into the EcoHub user experience, from the welcome screen to its core features.

| Welcome Screen | Home Screen | Disease Detection |
| :---: | :---: | :---: |
| ![Welcome Screen](https://github.com/scarredhands/EcoHub/blob/master/readme-assets/1.jpeg) | ![Home Screen](https://github.com/scarredhands/EcoHub/blob/master/readme-assets/2.jpeg) | ![Disease Detection](https://github.com/scarredhands/EcoHub/blob/master/readme-assets/3.jpeg) |

| Weather Updates | News Screen | Blog Screen |
| :---: | :---: | :---: |
| <img src="https://github.com/scarredhands/EcoHub/blob/master/readme-assets/4.jpeg?raw=true" width="300"> | <img src="https://github.com/scarredhands/EcoHub/blob/master/readme-assets/5.jpeg?raw=true" width="300"> | <img src="https://github.com/scarredhands/EcoHub/blob/master/readme-assets/7.jpeg?raw=true" width="300"> |

---

## 📑 Table of Contents

- [Key Features](#-key-features)
- [Tech Stack](#-tech-stack)
- [Setup Instructions](#-setup-instructions)
- [Deployment](#-deployment)
- [Contact](#-contact)

---

## ✨ Key Features

- **🤖 Plant Disease Detection**: Uses an integrated machine learning model to identify diseases from plant images, helping users care for their plants effectively.
- **🌦️ Live Weather Updates**: Provides real-time weather information and forecasts to help users plan their outdoor and gardening activities.
- **📰 Curated Environmental News**: Aggregates the latest news on climate change, conservation, and green initiatives to keep users informed.
- **💡 Eco-Friendly Advisory**: Offers practical tips and actionable advice for adopting a more sustainable and environmentally friendly lifestyle.
- **✍️ Community Blog Section**: A space for users to share their own stories, tips, and experiences, fostering a community of eco-conscious individuals.

---

## 🛠️ Tech Stack

| Category          | Technology / Service                         |
|-------------------|----------------------------------------------|
| **Frontend**      | Flutter (Dart)                               |
| **Backend/Cloud** | Firebase (Firestore, Authentication, Storage)|
| **Machine Learning**| TensorFlow Lite (On-device Inference)        |
| **APIs**          | OpenWeatherMap API, NewsAPI                  |

---

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (version 3.22.2 or higher)
- A Firebase project

### Installation Steps

1.  **Clone the repository:**
    ```
    git clone https://github.com/your-username/ecohub.git
    ```

2.  **Navigate to the project directory:**
    ```
    cd ecohub
    ```

3.  **Install dependencies:**
    ```
    flutter pub get
    ```

4.  **Configure Firebase:**
    - Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from your Firebase project settings.
    - Place `google-services.json` in the `android/app/` directory.
    - Place `GoogleService-Info.plist` in the `ios/Runner/` directory.

5.  **Run the app:**
    ```
    flutter run
    ```

---

## 📦 Deployment

The app is currently configured for local development and testing.

1.  **Internal Testing:**
    - Use **Firebase App Distribution** to share test builds with a limited audience. Setup instructions are available [here](https://firebase.google.com/docs/app-distribution).

2.  **Public Release (Future Scope):**
    - **Android:** Generate a signed App Bundle and submit it to the Google Play Store.
    - **iOS:** Archive the app using Xcode and submit it to the App Store.

---

## 🧑‍💻 Contact

For any queries, collaboration, or support, please reach out to:

- **Yatika** - `j.yatika@iitg.ac.in`
- **Aman** - `aman.ajad@iitg.ac.in`
