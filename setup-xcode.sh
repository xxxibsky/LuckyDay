#!/bin/bash

# LuckyDay Xcode Project Setup Script
# This script helps set up the Xcode project structure

set -e  # Exit on error

echo "🍀 LuckyDay - Xcode Project Setup"
echo "=================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$SCRIPT_DIR"

echo -e "${BLUE}Project Directory:${NC} $PROJECT_DIR"
echo ""

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${YELLOW}⚠️  Xcode is not installed or not in PATH${NC}"
    echo "Please install Xcode from the App Store and try again."
    exit 1
fi

echo -e "${GREEN}✓${NC} Xcode found: $(xcodebuild -version | head -n 1)"
echo ""

# Verify source files exist
echo "Checking source files..."
REQUIRED_FILES=(
    "LuckyDay/LuckyDayApp.swift"
    "LuckyDay/Models/User.swift"
    "LuckyDay/Services/AIService.swift"
    "LuckyDay/Views/ContentView.swift"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$PROJECT_DIR/$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${YELLOW}✗${NC} Missing: $file"
        exit 1
    fi
done

echo ""
echo -e "${GREEN}All source files found!${NC}"
echo ""

# Display instructions for manual Xcode project creation
echo "======================================"
echo "📱 Next Steps - Create Xcode Project"
echo "======================================"
echo ""
echo "Unfortunately, creating Xcode projects programmatically is complex."
echo "Please follow these steps in Xcode:"
echo ""
echo -e "${BLUE}1.${NC} Open Xcode"
echo -e "${BLUE}2.${NC} File → New → Project"
echo -e "${BLUE}3.${NC} Choose: iOS → App"
echo -e "${BLUE}4.${NC} Configure:"
echo "   - Product Name: LuckyDay"
echo "   - Interface: SwiftUI"
echo "   - Language: Swift"
echo "   - Organization Identifier: com.yourname"
echo ""
echo -e "${BLUE}5.${NC} Save location: $PROJECT_DIR"
echo "   (Choose the existing LuckyDay folder)"
echo ""
echo -e "${BLUE}6.${NC} Delete auto-generated files in Xcode:"
echo "   - ContentView.swift (the default one)"
echo "   - LuckyDayApp.swift (the default one)"
echo ""
echo -e "${BLUE}7.${NC} Add our source files:"
echo "   Drag these folders into Xcode:"
echo "   - LuckyDay/Models/"
echo "   - LuckyDay/Services/"
echo "   - LuckyDay/Views/"
echo "   - LuckyDay/LuckyDayApp.swift"
echo ""
echo -e "${BLUE}8.${NC} Configure signing in Xcode:"
echo "   - Select LuckyDay target"
echo "   - Signing & Capabilities tab"
echo "   - Choose your Team"
echo ""
echo -e "${BLUE}9.${NC} Build and Run (⌘R)"
echo ""
echo "======================================"
echo ""
echo "For detailed instructions, see: SETUP.md"
echo ""

# Ask if user wants to open the project directory
echo ""
read -p "Open project directory in Finder? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    open "$PROJECT_DIR"
fi

echo ""
echo -e "${GREEN}Setup information displayed!${NC}"
echo "Follow the steps above to complete your Xcode project setup."
echo ""
