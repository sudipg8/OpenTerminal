import os

# class Config:
#     SECRET_KEY = os.environ.get('SECRET_KEY') or 'supersecretkey'
#     SQLALCHEMY_DATABASE_URI = 'sqlite:///open_terminal.db'
#     SQLALCHEMY_TRACK_MODIFICATIONS = False
#     # Set session type (options: 'filesystem', 'redis', 'sqlalchemy')
#     SESSION_TYPE = 'filesystem'  # Change to 'redis' or 'sqlalchemy' if needed
#     SECRET_KEY = 'your_secret_key_here'  # Add a secret key for Flask session
from datetime import timedelta
import redis  # Import redis module

class Config:
    # Broker API configurations
    BROKER_API_URL = os.environ.get('BROKER_API_URL', 'https://apiconnect.angelone.in')
    BROKER_API_VERSION = 'v1'
    WEBSOCKET_URL = os.environ.get('WEBSOCKET_URL', 'wss://smartapisocket.angelone.in/smart-stream')
    
    # Order related configurations
    MAX_ORDER_VALUE = 10000000  # 1 Crore
    MIN_ORDER_VALUE = 0
    MAX_QUANTITY = 500000
    DEFAULT_TICK_SIZE = 0.05

    # Database configuration
    SQLALCHEMY_DATABASE_URI = 'sqlite:///open_terminal.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Secret key for CSRF protection and session signing
    SECRET_KEY = '45ggd3rf3dhgr456gtygx45dftrg'  # Ensure this is a securely generated key

    # Session and cookie settings
    SESSION_COOKIE_SECURE = True
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'

    # Server-side session configuration using Redis
    SESSION_TYPE = 'redis'
    SESSION_KEY_PREFIX = 'flask_session:' #added by Sudip
    SESSION_USE_SIGNER = True #added by Sudip
    SESSION_REDIS = redis.StrictRedis(
        host='localhost', # or host='127.0.0.1'
        port=6379,
        db=0
        # No password parameter since you don't have a Redis password
    )
    SESSION_PERMANENT = False
    PERMANENT_SESSION_LIFETIME = timedelta(hours=1)

    # (Optional) CSRF protection settings
    WTF_CSRF_TIME_LIMIT = None  # Disable CSRF token expiration if needed
    WTF_CSRF_ENABLED = True


