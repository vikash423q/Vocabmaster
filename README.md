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
- Python 3.11+ (for local development)
- Flutter SDK
- Anthropic API key (or self-hosted LLM endpoint)

### First-Time Setup

#### 1. Clone the Repository

```bash
git clone <repository-url>
cd vocabmaster
```

#### 2. Configure Environment Variables

Create a `.env` file in the project root:

```bash
# Database
DB_PASSWORD=vocabmasterdb

# JWT
JWT_SECRET=your-secret-key-change-in-production

# Anthropic API (optional if using self-hosted LLM)
ANTHROPIC_API_KEY=your-anthropic-api-key-here

# AI Agent Service Configuration
LLM_PROVIDER=ANTHROPIC  # or OPENAI_COMPATIBLE for self-hosted
OPENAI_API_BASE=https://llm.vikashgaurav.com/v1  # if using self-hosted
OPENAI_API_KEY=your-key  # if using self-hosted

# MinIO
MINIO_USER=minioadmin
MINIO_PASSWORD=minioadmin
```

#### 3. Start Docker Services

Start all services with Docker Compose:

```bash
docker-compose up -d
```

This will start:
- PostgreSQL (port 5432)
- Redis (port 6379)
- API Backend (port 8000)
- AI Agent Service (port 8001)
- MinIO (ports 9000, 9001)
- Nginx (port 80)

Verify services are running:

```bash
docker-compose ps
```

#### 4. Run Database Migrations

Run migrations inside the API container:

```bash
docker-compose exec api alembic upgrade head
```

**Alternative (Local Python Environment):**

If you have a local virtual environment set up:

```bash
cd backend
source venv/bin/activate
alembic upgrade head
```

#### 5. Seed Initial Data

**Option A: Seed from Generated Data (Recommended)**

If you have `generated_seed_data.json` with pre-generated word data:

```bash
# Using Docker
docker-compose exec api python -m scripts.seed_data

# Or using local Python environment
cd backend
source venv/bin/activate
python -m scripts.seed_data
```

**Option B: Generate and Seed Data**

If you need to generate seed data first:

1. Generate seed data (this will call AI service, fetch images, etc.):
   ```bash
   cd backend
   source venv/bin/activate
   python -m scripts.generate_seed_data
   ```

2. Update with CEFR levels and difficulty scores:
   ```bash
   python -m scripts.update_seed_data_with_cefr
   ```

3. Seed the database:
   ```bash
   python -m scripts.seed_data
   ```

**Note:** The seeding process will:
- Create vocabulary categories and sub-categories
- Load words from `generated_seed_data.json` (if available)
- Create word definitions, etymology, media, and all related data
- Assign CEFR levels and difficulty scores

#### 6. Verify Setup

Test the API:

```bash
# Health check
curl http://localhost:8000/

# API documentation
open http://localhost:8000/docs
```

### Troubleshooting Data Issues

If you encounter data-related issues or need to start fresh:

#### Clear All Words and Re-seed

To delete all existing words and re-seed from `generated_seed_data.json`:

```bash
# Using Docker
docker-compose exec api python -m scripts.seed_data --delete-and-reseed

# Or using local Python environment
cd backend
source venv/bin/activate
python -m scripts.seed_data --delete-and-reseed
```

**Warning:** This will delete:
- All words and their definitions
- All etymology records
- All word media
- All user progress (word learning progress)
- All daily stack entries
- All quiz sessions

**Note:** User accounts and categories are preserved.

#### Reset Database Completely

If you need to start completely fresh:

```bash
# Stop services
docker-compose down

# Remove volumes (WARNING: deletes all data)
docker-compose down -v

# Start services again
docker-compose up -d

# Run migrations
docker-compose exec api alembic upgrade head

# Seed data
docker-compose exec api python -m scripts.seed_data
```

#### Common Data Issues

**Issue: Words missing CEFR levels or difficulty scores**

Solution: Run the update script to add CEFR data:
```bash
cd backend
python -m scripts.update_seed_data_with_cefr
python -m scripts.seed_data --delete-and-reseed
```

**Issue: Categories not found during seeding**

Solution: Ensure categories are seeded first:
```bash
cd backend
python -m scripts.seed_categories
python -m scripts.seed_data
```

**Issue: Duplicate words or data inconsistencies**

Solution: Clear and re-seed:
```bash
python -m scripts.seed_data --delete-and-reseed
```

### Backend API

The API will be available at `http://localhost:8000`

API Documentation: `http://localhost:8000/docs`

### AI Agent Service

The AI agent service runs on `http://localhost:8001`

### Flutter App Setup

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
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Configure API endpoint (if needed):
   
   For Android Emulator, edit `lib/core/constants/api_constants.dart`:
   ```dart
   static const String baseUrl = 'http://10.0.2.2:8000';
   ```
   
   For physical device, use your computer's IP address:
   ```dart
   static const String baseUrl = 'http://192.168.1.100:8000';
   ```

5. Run the app:
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

### Viewing Logs

```bash
# Backend API logs
docker-compose logs -f api

# AI Agent Service logs
docker-compose logs -f ai-agent

# PostgreSQL logs
docker-compose logs -f postgres
```

### Restarting Services

```bash
# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart api
```

## Data Management

### Seed Data Scripts

The project includes several scripts for managing seed data:

- **`seed_categories.py`**: Seeds vocabulary categories and sub-categories
- **`generate_seed_data.py`**: Generates word data using AI service, Pixabay images, and MinIO
- **`update_seed_data_with_cefr.py`**: Updates generated seed data with CEFR levels and difficulty scores
- **`seed_data.py`**: Main seeding script that loads data into the database

### Seed Data Workflow

1. **Generate word data** (calls AI, fetches images):
   ```bash
   cd backend
   source venv/bin/activate
   python -m scripts.generate_seed_data
   ```

2. **Update with CEFR levels**:
   ```bash
   python -m scripts.update_seed_data_with_cefr
   ```

3. **Seed database**:
   ```bash
   python -m scripts.seed_data
   ```

4. **Re-seed if needed** (deletes all words first):
   ```bash
   python -m scripts.seed_data --delete-and-reseed
   ```

## License

MIT
