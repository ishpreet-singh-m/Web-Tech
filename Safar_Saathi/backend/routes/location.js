const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const Location = require('../models/Location');

const JWT_SECRET = process.env.JWT_SECRET || 'change_this_secret';

function authMiddleware(req, res, next) {
  const auth = req.headers.authorization;
  if (!auth) return res.status(401).json({ message: 'No token' });
  const parts = auth.split(' ');
  if (parts.length !== 2) return res.status(401).json({ message: 'Invalid token' });
  const token = parts[1];
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = payload;
    next();
  } catch (err) {
    return res.status(401).json({ message: 'Invalid token' });
  }
}

router.post('/upload', authMiddleware, async (req, res) => {
  try {
    const { latitude, longitude, timestamp } = req.body;
    if (typeof latitude !== 'number' || typeof longitude !== 'number' || !timestamp) {
      return res.status(400).json({ message: 'Invalid data' });
    }
    const loc = new Location({
      userId: req.user.userId,
      latitude,
      longitude,
      timestamp: new Date(timestamp)
    });
    await loc.save();
    return res.json({ message: 'Location saved' });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
