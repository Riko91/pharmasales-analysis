CREATE SCHEMA staging;

CREATE TABLE staging.sales_hourly (
    datum        TEXT, 
    m01ab        TEXT,
    m01ae        TEXT,
    n02ba        TEXT,
    n02be        TEXT,
    n05b         TEXT,
    n05c         TEXT,
    r03          TEXT,
    r06          TEXT,
    year         TEXT,   
    month        TEXT,  
    hour         TEXT,   
    weekday_name TEXT   
);
SELECT COUNT(*) FROM staging.sales_hourly;
