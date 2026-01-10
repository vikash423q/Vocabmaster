# VocabMaster

A comprehensive vocabulary learning application with AI-powered features, spaced repetition, and guided learning stories.

## Architecture

- **Backend**: FastAPI + PostgreSQL + Redis
- **AI Agent Service**: Anthropic Claude integration
- **Mobile App**: Flutter (Android/iOS)
- **Infrastructure**: Docker Compose with MinIO

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Python 3.11+
- Flutter SDK
- Anthropic API key

### Setup

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your configuration:
   ```bash
   cp .env.example .env
   ```

3. Update environment variables:
   - `ANTHROPIC_API_KEY`: Your Anthropic API key
   - `JWT_SECRET`: A secure secret for JWT tokens
   - `DB_PASSWORD`: PostgreSQL password

4. Start services with Docker Compose:
   ```bash
   docker-compose up -d
   ```

5. Run database migrations:
   ```bash
   cd backend
   alembic upgrade head
   ```

6. Seed initial data:
   ```bash
   python -m scripts.seed_data
   ```

### Backend API

The API will be available at `http://localhost:8000`

API Documentation: `http://localhost:8000/docs`

### AI Agent Service

The AI agent service runs on `http://localhost:8001`

### Flutter App

1. Navigate to the Flutter app directory:
   ```bash
   cd flutter_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate code (for freezed, retrofit, etc.):
   ```bash
   flutter pub run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Features

- **Fibonacci Spaced Repetition**: Intelligent review scheduling
- **AI-Powered Quizzes**: Dynamic quiz generation
- **Comprehensive Word Review**: Etymology, examples, media
- **Guided Learning Stories**: Thematic narratives
- **Progress Tracking**: Detailed statistics and analytics

## Project Structure

```
vocabmaster/
├── backend/           # FastAPI backend
├── ai_agent_service/ # AI agent service
├── flutter_app/      # Flutter mobile app
├── docker/           # Docker configurations
└── docker-compose.yml
```

## Development

### Running Tests

```bash
# Backend tests
cd backend
pytest

# Flutter tests
cd flutter_app
flutter test
```

## License

MIT
