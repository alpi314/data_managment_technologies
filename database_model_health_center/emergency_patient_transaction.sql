START TRANSACTION;

    DECLARE kzzs INT;

    SELECT z.stevilka_kzzs INTO kzzs 
    FROM zavraovanci z
    LEFT JOIN oseba o ON z.oseba_id = o.id
    WHERE o.ime = 'Janez' AND o.priimek = 'Novak';

    DECLARE st_obravnave INT;

    INSERT INTO obravnava 
    (stevilka_kzzs) 
    VALUES 
    (kzzs) 
    RETURNING st_obravnave INTO st_obravnave;

    INSERT INTO testi 
    (st_obravnave, test_id, datum, rezultat) 
    VALUES 
    (st_obravnave, 1, '2020-01-01', -1) 
    ON CONFLICT DO NOTHING;

    INSERT INTO testi 
    (st_obravnave, test_id, datum, rezultat) 
    VALUES 
    (st_obravnave, 240, '2020-01-01', 3.14) 
    ON CONFLICT DO NOTHING;

COMMIT;