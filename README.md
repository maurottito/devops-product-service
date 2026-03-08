# devops-product-service

Node.js/Express microservice that manages the product catalog. Used by the frontend and the order service.

## Requirements

- Node.js 18+
- PostgreSQL with `ecommerce` schema (see `devops-database`)

## Setup

```bash
git clone <repo-url>
cd devops-product-service
npm install
```

## Run

```bash
PORT=3001 DB_HOST=localhost DB_NAME=ecommerce DB_USER=postgres DB_PASSWORD=password \
npm start
```

## API Endpoints

| Method | Path            | Description          |
|--------|-----------------|----------------------|
| GET    | `/health`       | Health check         |
| GET    | `/products`     | List all products    |
| GET    | `/products/:id` | Get a single product |
| POST   | `/products`     | Create a product     |

## Environment Variables

| Variable      | Default     |
|---------------|-------------|
| `PORT`        | `3001`      |
| `DB_HOST`     | `localhost` |
| `DB_NAME`     | `ecommerce` |
| `DB_USER`     | `postgres`  |
| `DB_PASSWORD` | `password`  |

## Available Scripts

| Script      | Description             |
|-------------|-------------------------|
| `npm start` | Start the service       |
| `npm test`  | Run tests with Jest     |

## Folder Structure

```
devops-product-service/
├── src/
│   └── index.js        # Express app and route handlers
├── .env.example        # Environment variable template
├── .gitignore
├── package.json
└── README.md
```
