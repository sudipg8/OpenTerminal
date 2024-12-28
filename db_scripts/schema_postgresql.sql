
-- PostgreSQL DDL Script
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL,
    client_id VARCHAR(50) NOT NULL UNIQUE,
    api_key VARCHAR(100) NOT NULL,
    access_token VARCHAR(1000),
    feed_token VARCHAR(1000),
    refresh_token VARCHAR(1000),
    token_expiry TIMESTAMP,
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP
);

CREATE TABLE user_settings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    voice_activate_commands VARCHAR(500) DEFAULT '["MILO"]' NOT NULL,
    groq_api_key VARCHAR(100),
    preferred_exchange VARCHAR(10) DEFAULT 'NSE' NOT NULL,
    preferred_product_type VARCHAR(10) DEFAULT 'MIS' NOT NULL,
    preferred_model VARCHAR(50) DEFAULT 'whisper-large-v3' NOT NULL,
    trading_symbols_mapping TEXT DEFAULT '{}' NOT NULL,
    show_ltp_change BOOLEAN DEFAULT TRUE,
    show_ltp_change_percent BOOLEAN DEFAULT TRUE,
    show_holdings BOOLEAN DEFAULT TRUE
);

CREATE TABLE watchlists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE watchlist_items (
    id SERIAL PRIMARY KEY,
    watchlist_id INTEGER NOT NULL REFERENCES watchlists(id) ON DELETE CASCADE,
    symbol VARCHAR(150) NOT NULL,
    name VARCHAR(150),
    token VARCHAR(50),
    expiry VARCHAR(50),
    strike FLOAT,
    lotsize INTEGER,
    instrumenttype VARCHAR(50),
    exch_seg VARCHAR(10) NOT NULL,
    tick_size FLOAT
);

CREATE TABLE instruments (
    id SERIAL PRIMARY KEY,
    token VARCHAR(50) NOT NULL,
    symbol VARCHAR(150) NOT NULL,
    name VARCHAR(150),
    expiry VARCHAR(50),
    strike FLOAT,
    lotsize INTEGER,
    instrumenttype VARCHAR(50),
    exch_seg VARCHAR(10) NOT NULL,
    tick_size FLOAT
);

CREATE TABLE order_logs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    order_id VARCHAR(100) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    symbol VARCHAR(50) NOT NULL,
    exchange VARCHAR(10) NOT NULL,
    order_type VARCHAR(20) NOT NULL,
    transaction_type VARCHAR(10) NOT NULL,
    product_type VARCHAR(20) NOT NULL,
    quantity INTEGER NOT NULL,
    price FLOAT,
    trigger_price FLOAT,
    status VARCHAR(20) NOT NULL,
    message VARCHAR(255),
    order_source VARCHAR(20) DEFAULT 'REGULAR' NOT NULL
);
