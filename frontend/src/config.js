// src/config.js
const BASE_URL =
  process.env.NODE_ENV === 'development'
    ? 'http://127.0.0.1:8000/api'
    : 'https://toruspuzzle-hjfpfwdwb7gba5ch.canadacentral-01.azurewebsites.net';

export { BASE_URL };
