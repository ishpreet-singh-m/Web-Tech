const mongoose = require('mongoose');

const LocationSchema = new mongoose.Schema({
  userId: { type: String, required: true },
  latitude: { type: Number, required: true },
  longitude: { type: Number, required: true },
  timestamp: { type: Date, required: true }
}, { timestamps: true });

module.exports = mongoose.model('Location', LocationSchema);
