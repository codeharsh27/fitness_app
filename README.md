# Fitness App SaaS Platform

A comprehensive Flutter-based SaaS platform for fitness management, connecting users with trainers, workout plans, diet tracking, and membership management.

## Features

### User Features
- **Authentication**: Secure login, registration, and password recovery
- **Profile Management**: Complete user profiles with fitness goals and metrics
- **Workout Plans**: Access to personalized and public workout plans
- **Diet Tracking**: Meal plans and nutrition tracking
- **Trainer Booking**: Find and schedule sessions with fitness trainers
- **Progress Tracking**: Monitor fitness progress over time
- **Membership Management**: Subscribe to premium plans for enhanced features

### Trainer Features
- **Profile Management**: Create professional profiles with specializations
- **Client Management**: View and manage client relationships
- **Session Scheduling**: Manage training session calendar
- **Content Creation**: Create custom workout and diet plans
- **Performance Analytics**: Track client progress and engagement

### Admin Features
- **User Management**: Oversee all platform users
- **Trainer Verification**: Approve and manage trainer accounts
- **Content Moderation**: Review and manage platform content
- **Membership Management**: Configure subscription plans
- **Analytics Dashboard**: Monitor platform usage and revenue

## Tech Stack

- **Frontend**: Flutter (Cross-platform mobile framework)
- **Backend**: Firebase (Authentication, Firestore, Storage, Cloud Functions)
- **State Management**: Provider
- **Payment Processing**: Razorpay
- **Notifications**: Firebase Cloud Messaging

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/                # Data models
│   ├── user_model.dart
│   ├── membership_model.dart
│   └── ...
├── screens/               # UI screens
│   ├── auth/              # Authentication screens
│   ├── dashboard/         # Main app screens
│   ├── workout/           # Workout related screens
│   ├── diet/              # Diet related screens
│   ├── trainer/           # Trainer related screens
│   ├── membership/        # Membership related screens
│   ├── admin/             # Admin dashboard screens
│   └── onboarding/        # User onboarding screens
├── services/              # Business logic and API services
│   ├── auth_service.dart
│   ├── firebase_service.dart
│   ├── firestore_service.dart
│   └── payment_service.dart
├── utils/                 # Utility functions and constants
│   └── firestore_schema.dart
└── widgets/               # Reusable UI components
```

## 📱 Screenshots
<img width="1920" height="1080" alt="5" src="https://github.com/user-attachments/assets/7a378a31-370c-436c-8917-336fd668984e" />
<img width="1920" height="1080" alt="7" src="https://github.com/user-attachments/assets/5255eece-b8bf-4ee6-ac39-76187209b98a" />
<img width="1920" height="1080" alt="6" src="https://github.com/user-attachments/assets/70388d1a-8477-4d08-ba3e-8769f66c4763" />


---

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Firebase account
- Razorpay account (for payment processing)
- Android Studio / VS Code with Flutter plugins

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/fitness_app_saas.git
   cd fitness_app_saas
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and add the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files
   - Enable Authentication, Firestore, and Storage services

4. Configure Razorpay:
   - Create a Razorpay account
   - Get your API keys
   - Add them to the appropriate configuration files

5. Run the app:
   ```
   flutter run
   ```

## Firebase Setup

1. **Authentication**: Enable Email/Password and Google Sign-In methods
2. **Firestore Database**: Create the following collections:
   - users
   - workouts
   - userWorkouts
   - dietPlans
   - userDietPlans
   - sessions
   - memberships
   - payments
   - notifications
   - appSettings
3. **Storage**: Set up storage buckets for user profile images and workout media
4. **Security Rules**: Configure appropriate security rules for Firestore and Storage

## User Roles

The application supports three user roles:

1. **User**: Regular app users seeking fitness guidance
2. **Trainer**: Fitness professionals providing services
3. **Admin**: Platform administrators with full access

## Deployment

### Android
```
flutter build apk --release
```

### iOS
```
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for the backend infrastructure
- All contributors who have helped shape this project
