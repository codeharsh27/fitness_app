/*
 * Firestore Database Schema Documentation
 * 
 * This file documents the Firestore database schema for the Fitness App SaaS Platform.
 * It serves as a reference for developers working on the project.
 */

/*
 * Collection: users
 * Description: Stores user account information and profile data
 * 
 * Document ID: User's UID from Firebase Authentication
 * Fields:
 * - uid: String - User ID from Firebase Auth
 * - email: String - User's email address
 * - name: String - User's full name
 * - role: String - User role (user, trainer, admin)
 * - profileCompleted: bool - Whether the user has completed onboarding
 * - photoUrl: String? - URL to user's profile photo (optional)
 * - profileData: Map<String, dynamic> - Additional profile information
 *   - gender: String - User's gender
 *   - age: int - User's age
 *   - height: double - User's height (in cm)
 *   - weight: double - User's weight (in kg)
 *   - fitnessGoal: String - User's primary fitness goal
 *   - activityLevel: String - User's activity level
 *   - specialization: String - Trainer's specialization (for trainers only)
 *   - experience: int - Years of experience (for trainers only)
 *   - bio: String - Trainer's biography (for trainers only)
 *   - rating: double - Trainer's average rating (for trainers only)
 *   - sessionsCompleted: int - Number of sessions completed (for trainers only)
 * - createdAt: Timestamp - When the user account was created
 * - updatedAt: Timestamp - When the user account was last updated
 */

/*
 * Collection: workouts
 * Description: Stores workout plans created by trainers or the system
 * 
 * Document ID: Auto-generated
 * Fields:
 * - title: String - Workout plan title
 * - description: String - Workout plan description
 * - creatorId: String - UID of the trainer who created the workout
 * - creatorName: String - Name of the trainer who created the workout
 * - difficulty: String - Difficulty level (beginner, intermediate, advanced)
 * - category: String - Workout category (strength, cardio, flexibility, etc.)
 * - duration: int - Estimated duration in minutes
 * - imageUrl: String? - URL to workout image (optional)
 * - isPublic: bool - Whether the workout is publicly available
 * - exercises: List<Map<String, dynamic>> - List of exercises in the workout
 *   - name: String - Exercise name
 *   - description: String - Exercise description
 *   - sets: int - Number of sets
 *   - reps: int - Number of repetitions
 *   - duration: int - Duration in seconds (for timed exercises)
 *   - restTime: int - Rest time between sets in seconds
 *   - imageUrl: String? - URL to exercise image (optional)
 *   - videoUrl: String? - URL to exercise video (optional)
 * - createdAt: Timestamp - When the workout was created
 * - updatedAt: Timestamp - When the workout was last updated
 */

/*
 * Collection: userWorkouts
 * Description: Stores user-specific workout assignments and progress
 * 
 * Document ID: Auto-generated
 * Fields:
 * - userId: String - User ID
 * - workoutId: String - Reference to workout document
 * - startDate: Timestamp - When the user started the workout
 * - endDate: Timestamp? - When the user completed the workout (optional)
 * - progress: double - Progress percentage (0-100)
 * - status: String - Status (not_started, in_progress, completed)
 * - completedExercises: List<String> - IDs of completed exercises
 * - notes: String? - User notes about the workout (optional)
 * - createdAt: Timestamp - When the record was created
 * - updatedAt: Timestamp - When the record was last updated
 */

/*
 * Collection: dietPlans
 * Description: Stores diet plans created by trainers or the system
 * 
 * Document ID: Auto-generated
 * Fields:
 * - title: String - Diet plan title
 * - description: String - Diet plan description
 * - creatorId: String - UID of the trainer who created the diet plan
 * - creatorName: String - Name of the trainer who created the diet plan
 * - category: String - Diet category (weight_loss, muscle_gain, maintenance, etc.)
 * - imageUrl: String? - URL to diet plan image (optional)
 * - isPublic: bool - Whether the diet plan is publicly available
 * - meals: List<Map<String, dynamic>> - List of meals in the diet plan
 *   - name: String - Meal name (breakfast, lunch, dinner, snack)
 *   - time: String - Recommended time for the meal
 *   - foods: List<Map<String, dynamic>> - List of foods in the meal
 *     - name: String - Food name
 *     - quantity: double - Quantity
 *     - unit: String - Unit of measurement
 *     - calories: int - Calories
 *     - protein: double - Protein in grams
 *     - carbs: double - Carbohydrates in grams
 *     - fat: double - Fat in grams
 * - totalCalories: int - Total daily calories
 * - macros: Map<String, double> - Macronutrient breakdown
 *   - protein: double - Protein percentage
 *   - carbs: double - Carbohydrates percentage
 *   - fat: double - Fat percentage
 * - createdAt: Timestamp - When the diet plan was created
 * - updatedAt: Timestamp - When the diet plan was last updated
 */

/*
 * Collection: userDietPlans
 * Description: Stores user-specific diet plan assignments and tracking
 * 
 * Document ID: Auto-generated
 * Fields:
 * - userId: String - User ID
 * - dietPlanId: String - Reference to diet plan document
 * - startDate: Timestamp - When the user started the diet plan
 * - endDate: Timestamp? - When the user completed the diet plan (optional)
 * - status: String - Status (active, completed, abandoned)
 * - dailyLogs: List<Map<String, dynamic>> - Daily food logs
 *   - date: Timestamp - Date of the log
 *   - meals: List<Map<String, dynamic>> - Meals logged for the day
 *     - name: String - Meal name
 *     - foods: List<Map<String, dynamic>> - Foods consumed
 *       - name: String - Food name
 *       - quantity: double - Quantity consumed
 *       - calories: int - Calories
 *   - totalCalories: int - Total calories consumed
 *   - notes: String? - User notes for the day (optional)
 * - createdAt: Timestamp - When the record was created
 * - updatedAt: Timestamp - When the record was last updated
 */

/*
 * Collection: sessions
 * Description: Stores training sessions between users and trainers
 * 
 * Document ID: Auto-generated
 * Fields:
 * - userId: String - User ID
 * - trainerId: String - Trainer ID
 * - userName: String - User's name
 * - trainerName: String - Trainer's name
 * - title: String - Session title
 * - description: String? - Session description (optional)
 * - date: Timestamp - Scheduled date and time
 * - duration: int - Duration in minutes
 * - status: String - Status (scheduled, completed, cancelled)
 * - type: String - Session type (in_person, virtual)
 * - location: String? - Location for in-person sessions (optional)
 * - meetingLink: String? - Link for virtual sessions (optional)
 * - notes: String? - Session notes (optional)
 * - userFeedback: Map<String, dynamic>? - User feedback after session (optional)
 *   - rating: double - Rating (1-5)
 *   - comment: String - Feedback comment
 * - trainerNotes: String? - Trainer's notes about the session (optional)
 * - createdAt: Timestamp - When the session was created
 * - updatedAt: Timestamp - When the session was last updated
 */

/*
 * Collection: memberships
 * Description: Stores user membership information
 * 
 * Document ID: Auto-generated
 * Fields:
 * - userId: String - User ID
 * - userName: String - User's name
 * - planId: String - Membership plan ID
 * - planName: String - Membership plan name
 * - startDate: Timestamp - Start date of membership
 * - expiryDate: Timestamp - Expiry date of membership
 * - status: String - Status (active, expired, cancelled)
 * - autoRenew: bool - Whether the membership auto-renews
 * - features: List<String> - List of features included in the membership
 * - createdAt: Timestamp - When the membership was created
 * - updatedAt: Timestamp - When the membership was last updated
 */

/*
 * Collection: payments
 * Description: Stores payment transaction records
 * 
 * Document ID: Auto-generated
 * Fields:
 * - userId: String - User ID
 * - userName: String - User's name
 * - paymentId: String - Payment gateway transaction ID
 * - planId: String - Membership plan ID
 * - planName: String - Membership plan name
 * - amount: double - Payment amount
 * - currency: String - Currency code (e.g., USD)
 * - status: String - Payment status (completed, failed, refunded)
 * - paymentMethod: String - Payment method used
 * - timestamp: Timestamp - When the payment was made
 */

/*
 * Collection: notifications
 * Description: Stores user notifications
 * 
 * Document ID: Auto-generated
 * Fields:
 * - userId: String - User ID
 * - title: String - Notification title
 * - body: String - Notification body
 * - type: String - Notification type (session, workout, membership, system)
 * - read: bool - Whether the notification has been read
 * - data: Map<String, dynamic>? - Additional data related to the notification (optional)
 * - timestamp: Timestamp - When the notification was created
 */

/*
 * Collection: appSettings
 * Description: Stores application-wide settings
 * 
 * Document ID: "settings"
 * Fields:
 * - maintenanceMode: bool - Whether the app is in maintenance mode
 * - currentVersion: String - Current app version
 * - requiredVersion: String - Minimum required app version
 * - features: Map<String, bool> - Feature flags
 * - membershipPlans: List<Map<String, dynamic>> - Available membership plans
 *   - id: String - Plan ID
 *   - name: String - Plan name
 *   - description: String - Plan description
 *   - price: double - Plan price
 *   - durationInDays: int - Plan duration in days
 *   - features: List<String> - Features included in the plan
 *   - isPopular: bool - Whether this is a popular/featured plan
 * - updatedAt: Timestamp - When the settings were last updated
 */