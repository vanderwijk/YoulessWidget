# Youless Widget

The Youless Widget is an iOS widget that displays the current energy usage from a Youless P1 meter. It fetches data from a local URL and presents it in a user-friendly format.

## Features

- Displays current power usage in real-time.
- Fetches data from the Youless P1 meter via a local network.
- Simple and intuitive user interface.

## Project Structure

- **YoulessWidget**
  - `ContentView.swift`: Main content view of the app.
  - `YoulessWidgetApp.swift`: Entry point of the application.
  - **Models**
    - `EnergyUsage.swift`: Models the energy usage data.
  - **Services**
    - `YoulessService.swift`: Handles fetching energy usage data.
  - **Widgets**
    - `YoulessWidget.swift`: Defines the widget's main structure.

- **YoulessWidgetWidgetExtension**
  - `YoulessWidget.swift`: Entry point for the widget.
  - `YoulessWidgetEntry.swift`: Represents a single entry of the widget.
  - `YoulessWidgetProvider.swift`: Fetches data and provides it to the widget.
  - `YoulessWidgetTimeline.swift`: Manages the timeline of widget entries.
  - `YoulessWidgetView.swift`: Displays the current power usage.

- **Tests**
  - `YoulessWidgetWidgetExtensionTests/YoulessWidgetTests.swift`: Unit tests for the widget extension.
  - `YoulessWidgetTests/YoulessWidgetTests.swift`: Unit tests for the main app.
  - `YoulessWidgetUITests/YoulessWidgetUITests.swift`: UI tests for the app.

## Setup Instructions

1. Clone the repository.
2. Open the project in Xcode.
3. Ensure you are connected to the same local network as the Youless P1 meter.
4. Run the app to see the widget in action.

## Usage

Once the app is running, add the Youless Widget to your home screen to view the current energy usage at a glance. The widget will automatically update with the latest data from the Youless P1 meter.