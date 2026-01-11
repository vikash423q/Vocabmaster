# VocabMaster Setup Guide

## Prerequisites

- Docker and Docker Compose installed
- Flutter SDK installed
- Anthropic API key (for AI features)

## Step 1: Environment Configuration

Create a `.env` file in the project root:

```bash
# Database
DB_PASSWORD=vocabpass

# JWT
JWT_SECRET=your-secret-key-change-in-production

# Anthropic API (required for AI features)
ANTHROPIC_API_KEY=your-anthropic-api-key-here

# MinIO
MINIO_USER=minioadmin
MINIO_PASSWORD=minioadmin

# Application
ENVIRONMENT=development
DEBUG=True
```

## Step 2: Start Docker Services

Start all services with Docker Compose:

```bash
# From project root
docker-compose up -d
```

This will start:
- PostgreSQL (port 5432)
- Redis (port 6379)
- API Backend (port 8000)
- AI Agent Service (port 8001)
- MinIO (ports 9000, 9001)
- Nginx (port 80)

Check service status:
```bash
docker-compose ps
```

View logs:
```bash
docker-compose logs -f api
```

## Step 3: Database Setup

### Option A: Using Docker (Recommended)

Run migrations inside the API container:

```bash
docker-compose exec api alembic upgrade head
```

Seed initial data:

```bash
docker-compose exec api python -m scripts.seed_data
```

### Option B: Using Local Python Environment

If you have the virtual environment set up locally:

```bash
cd backend
source venv/bin/activate

# Set database URL for local connection
export DATABASE_URL="postgresql://vocabuser:vocabpass@localhost:5432/vocabmaster"

# Run migrations
alembic upgrade head

# Seed data
python -m scripts.seed_data
```

## Step 4: Verify Backend is Running

Test the API:

```bash
# Health check
curl http://localhost:8000/health

# API docs
open http://localhost:8000/docs
```

## Step 5: Flutter App Setup

### 5.1 Install Dependencies

```bash
cd flutter_app
flutter pub get
```

### 5.2 Generate Code

Generate code for Freezed models and Retrofit:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5.3 Configure API Endpoint

The Flutter app is configured to connect to `http://localhost:8000` by default.

**For Android Emulator**: Use `http://10.0.2.2:8000` instead of `localhost`

**For iOS Simulator**: `localhost` works fine

**For Physical Device**: Use your computer's IP address (e.g., `http://192.168.1.100:8000`)

To change the API endpoint, edit:
```
flutter_app/lib/core/constants/api_constants.dart
```

Change:
```dart
static const String baseUrl = 'http://localhost:8000';
```

To your desired endpoint.

### 5.4 Run Flutter App

```bash
# List available devices
flutter devices

# Run on a specific device
flutter run

# Or run in release mode
flutter run --release
```

## Step 6: Testing the Connection

1. **Start the backend** (if not already running):
   ```bash
   docker-compose up -d
   ```

2. **Run the Flutter app**:
   ```bash
   cd flutter_app
   flutter run
   ```

3. **Test registration/login** in the app

## Troubleshooting

### Backend not starting

Check logs:
```bash
docker-compose logs api
docker-compose logs postgres
```

### Database connection errors

Ensure PostgreSQL is healthy:
```bash
docker-compose ps postgres
```

### Flutter can't connect to API

1. **Android Emulator**: Change `localhost` to `10.0.2.2` in `api_constants.dart`
2. **Physical Device**: Use your computer's local IP address
3. **Check firewall**: Ensure port 8000 is not blocked

### Port conflicts

If ports are already in use, modify `docker-compose.yml` to use different ports.

## Development Workflow

### Backend Development

1. Code changes are automatically reloaded (volume mount)
2. View logs: `docker-compose logs -f api`
3. Restart service: `docker-compose restart api`

### Flutter Development

1. Hot reload: Press `r` in the terminal
2. Hot restart: Press `R` in the terminal
3. View logs: Check Flutter console output

## Stopping Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: deletes data)
docker-compose down -v
```

## Next Steps

- Register a user account in the Flutter app
- Add words to your learning stack
- Start reviewing words with spaced repetition
- Explore AI-powered features
