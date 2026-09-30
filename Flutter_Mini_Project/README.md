# Flutter Mini Project (Job Portal App).

A modern Flutter web & mobile application featuring job search, job details, application submission with resume upload, and saved jobs management.

---

## 🚀 Deploying on Vercel

This repository includes `vercel.json` and `build.sh` pre-configured for automated building and deployment of Flutter Web.

### Option 1: Deploy via Vercel Dashboard (Recommended)

1. Go to [vercel.com](https://vercel.com) and log in.
2. Click **Add New...** > **Project**.
3. Import your GitHub repository: `Flutter_Assignments`.
4. In the **Configure Project** screen:
   - **Root Directory**: Click *Edit* and select `Flutter_Mini_Project`.
   - **Framework Preset**: Leave as *Other*.
   - **Build Command**: `bash build.sh` *(already configured in vercel.json)*
   - **Output Directory**: `build/web` *(already configured in vercel.json)*
5. Click **Deploy**.

Vercel will download the stable Flutter SDK via `build.sh`, run `flutter build web --release`, and publish the web output with SPA client-side routing.

---

## 💻 Local Development

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and added to PATH.

### Run Locally
```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome
```

### Build for Web
```bash
flutter build web --release
```
