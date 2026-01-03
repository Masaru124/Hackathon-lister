# Hackathon Explorer

A Flutter application that displays hackathons fetched from a Supabase database. Browse upcoming hackathons, see details like prizes, participants, dates, and location, and click to open the Devpost page.

## Features

- List of hackathons with real-time data 
- Display hackathon details: name, prize, participants, location, start/end dates
- Direct link to Devpost page for each hackathon
- Clean, modern UI with badges and cards

## Tech Stack

- **Flutter** - UI framework
- **Supabase** - Backend database and authentication
- **flutter_dotenv** - Environment variable management

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd hackfton/front
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure environment variables:
   - Copy your Supabase credentials to `assets/.env`:
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_anon_key
   ```

4. Run the app:
```bash
flutter run
   ```

## Project Structure

```
lib/
  main.dart           # App entry point and Supabase initialization
  hackathon_list_page.dart  # Main page displaying hackathon list
assets/
  .env               # Environment variables (not committed to git)
```

## Dependencies

- `supabase_flutter: ^2.12.0` - Supabase client
- `url_launcher: ^6.3.2` - Open external URLs
- `flutter_dotenv: ^6.0.0` - Load .env files

## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

