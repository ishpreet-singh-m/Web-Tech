# Backend for Flutter App

## Setup

1. Copy `.env.example` to `.env` and update values:
```
MONGO_URI=mongodb://localhost:27017/flutter_app_db
PORT=4000
JWT_SECRET=your_jwt_secret_here
```

2. Install dependencies:
```
cd backend
npm install
```

3. Start server:
```
npm start
```

## API

### POST /auth/signup
Body: { "email": "user@example.com", "password": "secret" }

### POST /auth/login
Body: { "email": "user@example.com", "password": "secret" }
Response: { "token": "<jwt>" }

### POST /location/upload
Headers: Authorization: Bearer &lt;token&gt;
Body: { "latitude": 12.34, "longitude": 56.78, "timestamp": "2025-09-29T12:34:56.000Z" }
