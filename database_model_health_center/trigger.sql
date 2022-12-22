CREATE TRIGGER unique_test_in_treatment
BEFORE INSERT OR UPDATE tests
FOR EACH ROW 
BEGIN
    IF (SELECT COUNT(*) FROM tests WHERE tests.treatment = NEW.treatment AND tests.laboratory_test = NEW.laboratory_test) > 1 THEN
        RAISE EXCEPTION 'Error: Pacient ne sme ponavljati laboratorijskih preiskav v sklopu ene obravnave.';
    END IF;
    RETURN NEW;
END;