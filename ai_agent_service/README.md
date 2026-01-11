# AI Agent Service

This service provides AI-powered features for the VocabMaster application, including quiz generation, word explanations, story generation, and chat functionality.

## LLM Provider Configuration

The service supports two LLM providers:

### 1. Self-Hosted LLM (LM Studio) - Default

Configure for your self-hosted LLM at `llm.vikashgaurav.com`:

```env
LLM_PROVIDER=openai
OPENAI_API_KEY=dummy
OPENAI_BASE_URL=http://llm.vikashgaurav.com/v1
OPENAI_MODEL=gpt-3.5-turbo
```

**Note:** 
- LM Studio provides an OpenAI-compatible API endpoint
- The API key can be any value (often "dummy" or "lm-studio")
- Check your LM Studio server for the exact model name
- Base URL should point to `/v1` endpoint

### 2. Anthropic Claude

To use Anthropic Claude instead:

```env
LLM_PROVIDER=anthropic
ANTHROPIC_API_KEY=your-anthropic-api-key
```

## Setup

1. Create `.env` file in `ai_agent_service/` directory:

```bash
cp .env.example .env
```

2. Update `.env` with your configuration

3. Install dependencies:

```bash
pip install -r requirements.txt
```

4. Run the service:

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8001 --reload
```

## Docker

The service is configured in `docker-compose.yml`. Environment variables can be set in the root `.env` file.

## Testing

Test the service:

```bash
curl http://localhost:8001/health
```

## API Endpoints

- `POST /generate-quiz` - Generate quiz for a word
- `POST /explain-word` - Explain a word
- `POST /generate-story` - Generate learning story
- `POST /chat` - Chat about a word
