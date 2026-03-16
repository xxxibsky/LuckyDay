# LuckyDay - Complete Setup Guide

This guide will walk you through setting up the Xcode project and running the app.

## Prerequisites

- macOS with Xcode 14.0 or later installed
- An Apple ID (for code signing)
- At least one AI API key (see links below)

## Step-by-Step Setup

### Step 1: Open Xcode

1. Launch **Xcode** from your Applications folder
2. If prompted, install additional components

### Step 2: Create New Project

1. In Xcode, select **File → New → Project** (or press `Cmd+Shift+N`)
2. Select **iOS** tab at the top
3. Choose **App** template
4. Click **Next**

### Step 3: Configure Project Settings

Enter the following details:

| Field | Value |
|-------|-------|
| **Product Name** | `LuckyDay` |
| **Team** | Select your Apple Developer team |
| **Organization Identifier** | `com.yourname` (or any reverse domain) |
| **Bundle Identifier** | `com.yourname.LuckyDay` (auto-generated) |
| **Interface** | **SwiftUI** |
| **Language** | **Swift** |
| **Storage** | None (uncheck Core Data) |
| **Include Tests** | Optional (you can uncheck these) |

Click **Next**

### Step 4: Choose Project Location

1. Navigate to: `/Users/skyzhang/Github/`
2. You'll see a warning that a folder named "LuckyDay" already exists
3. Click **Choose** anyway - Xcode will merge with the existing folder

**Important**: Make sure "Create Git repository" is **UNCHECKED** (we already have one!)

### Step 5: Clean Up Auto-Generated Files

Xcode will create some default files we don't need. In the **Project Navigator** (left sidebar):

1. **Delete** these auto-generated files (Right-click → Delete → Move to Trash):
   - `ContentView.swift` (in the root LuckyDay folder)
   - `LuckyDayApp.swift` (in the root LuckyDay folder)
   - `Preview Content` folder (if it exists)

### Step 6: Add Our Source Files

Now we need to add our actual app files:

1. In **Finder**, navigate to `/Users/skyzhang/Github/LuckyDay/LuckyDay/`
2. You should see folders: `Models`, `Services`, `Views`, and files: `LuckyDayApp.swift`, `Info.plist`

3. **Drag and drop** these into Xcode:
   - Drag the `Models` folder → into the LuckyDay group in Xcode
   - Drag the `Services` folder → into the LuckyDay group in Xcode
   - Drag the `Views` folder → into the LuckyDay group in Xcode
   - Drag `LuckyDayApp.swift` → into the LuckyDay group in Xcode

4. When the dialog appears:
   - ✅ **Check** "Copy items if needed"
   - ✅ **Check** "Create groups"
   - ✅ **Check** your LuckyDay target
   - Click **Finish**

### Step 7: Configure Info.plist

1. In Project Navigator, select your **LuckyDay project** (blue icon at top)
2. Select the **LuckyDay target** (under TARGETS)
3. Go to the **Info** tab
4. Find **Custom iOS Target Properties**
5. Add this entry:
   - **Key**: `Privacy - User Notifications Usage Description`
   - **Type**: String
   - **Value**: `Get daily reminders to check your fortune`

Or simply replace the auto-generated Info.plist with our custom one.

### Step 8: Configure Signing

1. Select your **LuckyDay target**
2. Go to **Signing & Capabilities** tab
3. Check **"Automatically manage signing"**
4. Select your **Team** from the dropdown
5. The **Bundle Identifier** should show `com.yourname.LuckyDay`

### Step 9: Set Deployment Target

1. Still in the target settings
2. Go to **General** tab
3. Under **Deployment Info**:
   - **Minimum Deployments**: iOS 15.0 or later
   - **iPhone Orientation**: Portrait (uncheck others if desired)
   - **iPad Orientation**: All (or customize as needed)

### Step 10: Build and Run

1. Select a simulator or your physical device from the scheme selector (top toolbar)
   - For simulator: Choose **iPhone 14** or any model you prefer
   - For device: Connect your iPhone and select it

2. Click the **Play** button (▶️) or press `Cmd+R`

3. Xcode will:
   - Compile the code
   - Build the app
   - Install it on the simulator/device
   - Launch the app

### Step 11: First Run Setup

When the app launches:

1. You'll see the **Onboarding screen**
2. Enter your name (optional)
3. Select your birth date
4. Tap **Get Started**

5. You'll be taken to the main app
6. Go to the **Settings** tab (gear icon)
7. Tap on **OpenAI API Key** (or your preferred provider)
8. Enter your API key
9. Select the provider at the top

### Step 12: Generate Your First Prediction

1. Go to the **Today** tab
2. Tap **Generate Prediction**
3. Wait a few seconds
4. Enjoy your daily fortune! ✨

## Troubleshooting

### Build Errors

**Error**: "No such module 'SwiftUI'"
- **Solution**: Make sure your deployment target is iOS 15.0+

**Error**: "Command CodeSign failed"
- **Solution**: Check your signing settings, make sure you have a valid team selected

**Error**: Duplicate file errors
- **Solution**: Make sure you deleted the auto-generated ContentView.swift and LuckyDayApp.swift before adding our files

### Runtime Errors

**Error**: "API error with status code: 401"
- **Solution**: Check your API key is correct and valid

**Error**: "API error with status code: 429"
- **Solution**: You've exceeded your API rate limit, wait a few minutes or check your API credits

**Error**: Notifications not appearing
- **Solution**:
  1. Go to iOS Settings → LuckyDay → Notifications
  2. Make sure "Allow Notifications" is enabled

## Getting API Keys

You need at least one API key to use the app:

### OpenAI (Recommended for beginners)
1. Go to: https://platform.openai.com/api-keys
2. Sign up or log in
3. Click **"Create new secret key"**
4. Copy the key (it starts with `sk-`)
5. **Note**: Requires payment setup, but offers $5 free credit for new users

### Anthropic Claude
1. Go to: https://console.anthropic.com/settings/keys
2. Sign up or log in
3. Click **"Create Key"**
4. Copy the key
5. **Note**: Requires payment setup, offers free trial credits

### Google Gemini (Has free tier!)
1. Go to: https://aistudio.google.com/app/apikey
2. Sign in with Google account
3. Click **"Create API key"**
4. Copy the key
5. **Note**: Has a free tier with generous limits!

## Alternative: Quick Start Script (Coming Soon)

We're working on an automated setup script that will:
- Create the Xcode project automatically
- Configure all settings
- Add all files

Stay tuned!

## Next Steps

Once your app is running:

1. **Customize the notification time** (edit `NotificationService.swift`)
2. **Adjust the AI prompt** for different types of predictions
3. **Add your own UI customizations**
4. **Share your predictions** with friends

## Need Help?

- Check the main [README.md](README.md) for app features
- Review the code comments in each file
- Open an issue on GitHub if you encounter problems

---

Happy coding! May your days be lucky! 🍀✨
