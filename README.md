# LuckyDay - AI-Powered Daily Fortune App

An iOS app that uses AI to predict your daily lucky color and provide personalized recommendations based on your birth date.

## 🚀 Getting Started

- **New to the project?** → Start with [QUICKSTART.md](QUICKSTART.md) (5 minutes)
- **Need detailed setup?** → See [SETUP.md](SETUP.md) (step-by-step guide)
- **Already set up?** → Continue reading below for features and usage

## Features

- **Multiple AI Providers**: Choose between OpenAI (GPT), Claude, or Google Gemini
- **Daily Predictions**: Get personalized fortune predictions including:
  - Lucky color with beautiful visualization
  - Outfit suggestions
  - Recommended activities
  - General life advice
- **Prediction History**: View all your past daily predictions
- **Daily Notifications**: Optional reminders to check your daily fortune
- **Secure Storage**: API keys stored securely on your device
- **Beautiful UI**: Modern SwiftUI design with color animations

## Requirements

- iOS 15.0 or later
- Xcode 14.0 or later
- An API key from at least one AI provider:
  - [OpenAI API Key](https://platform.openai.com/api-keys)
  - [Claude API Key](https://console.anthropic.com/settings/keys)
  - [Google Gemini API Key](https://aistudio.google.com/app/apikey)

## Installation

### Option 1: Open with Xcode

1. Open Xcode
2. Select "File" > "Open"
3. Navigate to the `LuckyDay` folder
4. Create a new Xcode project:
   - Choose "iOS" > "App"
   - Product Name: `LuckyDay`
   - Organization Identifier: `com.yourname` (or your preference)
   - Interface: SwiftUI
   - Language: Swift
   - Bundle Identifier: `com.yourname.LuckyDay`

5. Replace the auto-generated files with the files from this directory:
   - Delete the default files
   - Add all `.swift` files from the `LuckyDay` directory
   - Add the `Info.plist` file

6. Configure the project:
   - Select your development team in "Signing & Capabilities"
   - Make sure "Automatically manage signing" is checked

7. Build and run on your device or simulator

### Option 2: Manual Xcode Project Setup

You can also create an Xcode project file by running:

```bash
cd LuckyDay
# Create .xcodeproj manually or use Xcode's File > New > Project
```

## Project Structure

```
LuckyDay/
├── LuckyDayApp.swift          # App entry point
├── Models/
│   ├── User.swift             # User model
│   ├── DailyPrediction.swift  # Prediction data model
│   └── AIProvider.swift       # AI provider enum
├── Services/
│   ├── AIService.swift        # AI API integration
│   ├── AppState.swift         # App state management
│   └── NotificationService.swift # Notification handling
├── Views/
│   ├── ContentView.swift      # Main navigation view
│   ├── OnboardingView.swift   # Birth date input
│   ├── DashboardView.swift    # Today's prediction
│   ├── HistoryView.swift      # Past predictions
│   └── SettingsView.swift     # Settings and API keys
└── Info.plist                 # App configuration
```

## How to Use

1. **First Launch**: Enter your birth date (and optionally your name)

2. **Configure API Key**:
   - Go to Settings tab
   - Select your preferred AI provider
   - Tap on the provider to enter your API key
   - Links to get API keys are provided in Settings

3. **Generate Prediction**:
   - Go to "Today" tab
   - Tap "Generate Prediction" button
   - Wait for the AI to generate your daily fortune

4. **View History**:
   - Go to "History" tab
   - Browse all your past predictions
   - Tap any prediction to view details

5. **Notifications** (Optional):
   - The app requests notification permission on launch
   - Daily reminders are automatically scheduled for 9:00 AM

## AI Provider Configuration

### OpenAI (GPT)
- Model: GPT-4o-mini
- Get API Key: https://platform.openai.com/api-keys
- Pricing: Pay-per-use

### Claude
- Model: Claude 3.5 Sonnet
- Get API Key: https://console.anthropic.com/settings/keys
- Pricing: Pay-per-use

### Google Gemini
- Model: Gemini Pro
- Get API Key: https://aistudio.google.com/app/apikey
- Pricing: Free tier available

## Privacy & Security

- All data is stored locally on your device
- API keys are stored in UserDefaults (consider using Keychain for production)
- No data is sent to any server except the selected AI provider
- Birth date is only used to generate predictions

## Customization

### Change Notification Time
Edit `NotificationService.swift`:

```swift
// Change the hour and minute
NotificationService.shared.scheduleDailyNotification(at: 9, minute: 0)
```

### Modify AI Prompts
Edit `AIService.swift` > `createPrompt()` function to customize the prediction format.

### Add New AI Providers
1. Add new case to `AIProvider` enum in `AIProvider.swift`
2. Implement API call in `AIService.swift`

## Troubleshooting

### API Errors
- Check your API key is correct
- Verify you have credits/quota with your AI provider
- Check internet connection

### Build Errors
- Make sure you're using Xcode 14.0+
- Check deployment target is iOS 15.0+
- Clean build folder (Cmd+Shift+K) and rebuild

### Notifications Not Working
- Check notification permissions in iOS Settings
- Verify the app has permission to send notifications

## Future Enhancements

- [ ] Keychain storage for API keys
- [ ] Share predictions with friends
- [ ] Customizable notification times
- [ ] Widget support
- [ ] Dark mode optimization
- [ ] Localization support
- [ ] More AI providers
- [ ] Export predictions as PDF

## License

This is a personal project. Feel free to modify and use as you wish.

## Credits

Built with SwiftUI and powered by AI:
- OpenAI GPT
- Anthropic Claude
- Google Gemini

---

Enjoy discovering your daily fortune! ✨
