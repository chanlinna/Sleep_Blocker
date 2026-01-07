# Sleep Blocker

**Sleep Blocker** is a **fully offline Flutter app** that helps users track their sleep, understand what affects it, and improve their sleep quality over time. The app logs both sleep data and habits, analyzes patterns, and provides insights to help users make better decisions for their rest.  

This project was developed as a **final project for a Mobile Development course**, with an emphasis on offline functionality and layered architecture.

## Purpose

Many people struggle with poor sleep due to habits like:
- Staying up late  
- High screen time before bed  
- Stress or noise disturbances  
- Pain or discomfort  

Sleep Blocker aims to help users:
- Log nightly sleep duration and quality  
- Track daily habits affecting sleep  
- Identify patterns that improve or worsen sleep  
- Get actionable insights to optimize rest


## Key Features

- **Sleep Logging:** Record sleep duration and quality for each night.  
- **Habit Tracking:** Log habits such as screen time, stress, noise, and pain.  
- **Sleep Health Index:** Calculates a simple score combining sleep duration and quality.  
- **Insights:** Highlights which factors are most affecting sleep quality.  
- **History:** View past sleep logs and habit trends.  
- **Offline:** Fully functional without an internet connection.

## Architecture

The app follows a **layered architecture**:

- **UI Layer:** Screens, widgets, and visual components.  
- **Logic Layer:** Sleep health calculations and habit impact analysis.  
- **Data Layer:** Local storage using SharedPreferences.  

State is handled with **Stateful Widgets only**, no external state management libraries are used.


## Screens

1. **Dashboard:** Overview of recent sleep and overall sleep health.  
2. **Sleep Log:** Input nightly sleep data and daily habits.  
3. **Insights:** Analyze factor impact, and track improvements.

## Technology

- **Framework:** Flutter  
- **Language:** Dart  
- **Storage:** SharedPreferences (local)  
- **Design Tool:** Figma 


## UI / UX Design

**Wireframe & Design:**  [Figma – Sleep Blocker](https://www.figma.com/design/KGUU40U8ljcjBoG2XQG8O2/Sleep-Blocker?node-id=0-1&t=KIPhSyuEVvs46Gn6-1)


## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/chanlinna/Sleep_Blocker.git
   ```

2. Navigate to the project folder and install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on an emulator or physical device:
    ```bash
   flutter run
   ```
No internet connection is required.

## Team

Developed as a 2-member academic project:
- CHUM Chanlinna - Analyze logic handling & UX/UI Design
- IN Chanaliza - Data handling & UX/UI Design

## Limitations

- Offline only (no cloud backup).
- Analysis is rule-based (no AI/ML).
- Accuracy depends on consistent logging by the user.

## Future Improvements
- Smarter habit recommendations.
- Custom reminders for factors affecting sleep.
- Graphs and trends for long-term sleep monitoring.
- Data export options (CSV / PDF).
- Improved accessibility and animations.

## License

This project is for educational purposes only, part of the Mobile Development course.