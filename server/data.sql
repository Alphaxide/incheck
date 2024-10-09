-- Drop the products table if it already exists (optional)
DROP TABLE IF EXISTS products;

-- Create products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,            -- Unique identifier for each product
    product_name VARCHAR(255) NOT NULL, -- Name of the product
    price NUMERIC(10, 2) NOT NULL,    -- Price of the product, with 2 decimal places
    image VARCHAR(255),               -- Filepath or URL for the product image
    category VARCHAR(255) NOT NULL,   -- Product category (e.g., electronics, clothing)
    flavour VARCHAR(255),             -- Optional field for product flavour (e.g., for food items)
    on_offer BOOLEAN DEFAULT FALSE,   -- Indicates if the product is on offer
    ratings NUMERIC(3, 2) CHECK (ratings >= 0 AND ratings <= 5), -- Product rating (0 to 5, with 2 decimal places)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the product is created
);

-- Create index on product category to speed up category-based searches
CREATE INDEX idx_products_category ON products (category);

-- Create index on product name to improve search performance
CREATE INDEX idx_products_name ON products (product_name);

-- Create index on on_offer field to improve queries for discounted products
CREATE INDEX idx_products_on_offer ON products (on_offer);
