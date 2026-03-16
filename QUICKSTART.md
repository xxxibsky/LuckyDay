# 🚀 Quick Start Guide

Get LuckyDay running in 5 minutes!

## TL;DR

1. Open Xcode → New Project → iOS App (SwiftUI)
2. Name it "LuckyDay", save to this directory
3. Delete default files, drag in our source folders
4. Build & Run!

## Detailed Steps

### 1. Create Xcode Project (2 minutes)

```bash
# Open Xcode
open -a Xcode

# Or double-click Xcode in Applications
```

In Xcode:
- **File** → **New** → **Project** (`⌘⇧N`)
- Choose **iOS** → **App**
- Settings:
  - Product Name: `LuckyDay`
  - Interface: `SwiftUI`
  - Language: `Swift`
- Save to: `/Users/skyzhang/Github/LuckyDay`

### 2. Add Source Files (2 minutes)

Delete these auto-generated files:
- ❌ `ContentView.swift`
- ❌ `LuckyDayApp.swift`

Drag these into Xcode Project Navigator:
- ✅ `LuckyDay/Models/` folder
- ✅ `LuckyDay/Services/` folder
- ✅ `LuckyDay/Views/` folder
- ✅ `LuckyDay/LuckyDayApp.swift` file

### 3. Configure & Build (1 minute)

- Select **LuckyDay** target
- **Signing & Capabilities** tab → Choose your Team
- Click ▶️ Play button or press `⌘R`

### 4. Get API Key (2 minutes)

Choose ONE:

**Option A: Google Gemini** (FREE tier!)
- Visit: https://aistudio.google.com/app/apikey
- Create API key
- Copy it

**Option B: OpenAI**
- Visit: https://platform.openai.com/api-keys
- Create secret key (starts with `sk-`)
- Copy it

**Option C: Claude**
- Visit: https://console.anthropic.com/settings/keys
- Create key
- Copy it

### 5. Use the App

1. Enter your birth date on first launch
2. Go to **Settings** → tap provider → paste API key
3. Go to **Today** → tap **Generate Prediction**
4. ✨ Enjoy your fortune!

## Project Structure

```
LuckyDay/
├── 📄 README.md              ← Full documentation
├── 📄 SETUP.md               ← Detailed setup guide
├── 📄 QUICKSTART.md          ← This file
├── 🔧 setup-xcode.sh         ← Helper script
│
└── LuckyDay/                 ← Source code
    ├── LuckyDayApp.swift     ← App entry point
    ├── Info.plist            ← Configuration
    │
    ├── Models/               ← Data structures
    │   ├── User.swift
    │   ├── DailyPrediction.swift
    │   └── AIProvider.swift
    │
    ├── Services/             ← Business logic
    │   ├── AIService.swift   ← AI API calls
    │   ├── AppState.swift    ← State management
    │   └── NotificationService.swift
    │
    └── Views/                ← UI Components
        ├── ContentView.swift
        ├── OnboardingView.swift
        ├── DashboardView.swift
        ├── HistoryView.swift
        └── SettingsView.swift
```

## Troubleshooting

**Build fails?**
- Check deployment target is iOS 15.0+
- Make sure SwiftUI is selected
- Clean build folder: `⌘⇧K`

**Can't sign the app?**
- Add your Apple ID in Xcode Preferences
- Select your team in Signing settings

**API errors?**
- Verify your API key is correct
- Check you have credits/quota
- Try a different provider

## Need More Help?

- 📖 **Detailed Setup**: See [SETUP.md](SETUP.md)
- 📚 **Full Docs**: See [README.md](README.md)
- 🐛 **Issues**: https://github.com/xxxibsky/LuckyDay/issues

---

**Made with ❤️ using Claude Code**
