CREATE SCHEMA dw;

CREATE TABLE dw.dim_atc (
    atc_key           SERIAL PRIMARY KEY,
    atc_code          TEXT NOT NULL UNIQUE,
    atc_name          TEXT,
    therapeutic_group TEXT
);

INSERT INTO dw.dim_atc (atc_code, atc_name, therapeutic_group) VALUES
    ('M01AB', 'Derivati ocetne kisline (diklofenak)', 'Nesteroidni antirevmatiki'),
    ('M01AE', 'Derivati propionske kisline (ibuprofen)', 'Nesteroidni antirevmatiki'),
    ('N02BA', 'Salicilna kislina (aspirin)', 'Analgetiki'),
    ('N02BE', 'Pirazoloni in anilidi (paracetamol)', 'Analgetiki'),
    ('N05B', 'Anksiolitiki', 'Psiholeptiki'),
    ('N05C', 'Hipnotiki in sedativi', 'Psiholeptiki'),
    ('R03', 'Zdravila za obstruktivne bolezni dihal', 'Respiratorni sistem'),
    ('R06', 'Antihistaminiki', 'Respiratorni sistem');

SELECT * FROM dw.dim_atc;
