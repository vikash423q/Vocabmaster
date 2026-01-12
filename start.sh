#!/bin/bash

# VocabMaster Quick Start Script

echo "🚀 Starting VocabMaster Services..."

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from template..."
    cat > .env << EOF
# Database
DB_PASSWORD=vocabpass

# JWT
JWT_SECRET=$(openssl rand -hex 32)

# Anthropic API (required for AI features)
ANTHROPIC_API_KEY=your-anthropic-api-key-here

# MinIO
MINIO_USER=minioadmin
MINIO_PASSWORD=minioadmin

# Application
ENVIRONMENT=development
DEBUG=True
EOF
    echo "✅ Created .env file. Please update ANTHROPIC_API_KEY with your actual key."
fi

mkdir -p docker/{postgres,redis,minio}
mkdir -p docker/api/{data,logs}
mkdir -p docker/ai-agent/{data,logs}
mkdir -p docker/nginx/logs
chmod -R 777 docker/postgres

# Start Docker services
echo "📦 Starting Docker services..."
docker-compose up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if database needs migration
echo "🗄️  Setting up database..."
docker-compose exec -T api alembic upgrade head 2>/dev/null || echo "⚠️  Migration may have failed. Check if services are ready."

# Seed data if needed
echo "🌱 Seeding initial data..."
docker-compose exec -T api python -m scripts.seed_data 2>/dev/null || echo "⚠️  Seeding may have failed. You can run it manually later."

echo ""
echo "✅ Services started!"
echo ""
echo "📋 Service URLs:"
echo "   - API: http://localhost:8000"
echo "   - API Docs: http://localhost:8000/docs"
echo "   - AI Agent: http://localhost:8001"
echo "   - MinIO Console: http://localhost:9001"
echo ""
echo "📱 To start Flutter app:"
echo "   cd flutter_app"
echo "   flutter pub get"
echo "   flutter pub run build_runner build --delete-conflicting-outputs"
echo "   flutter run"
echo ""
echo "📊 View logs: docker-compose logs -f"
