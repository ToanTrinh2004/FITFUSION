const jwt = require('jsonwebtoken');

exports.verifyToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];

  if (!authHeader) {
    return res.status(403).json({ status: false, error: 'No token provided' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, 'secretKey');
    req.user = decoded; // ✅ always use req.user
    next();
  } catch (error) {
    return res.status(401).json({ status: false, error: 'Invalid token' });
  }
};
