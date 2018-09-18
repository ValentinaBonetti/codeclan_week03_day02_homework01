DROP TABLE IF EXISTS houses;

CREATE TABLE houses (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  bedrooms INT2,
  build VARCHAR(255)
)
