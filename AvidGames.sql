DELIMITER $$
CREATE PROCEDURE `json_to_table_final`(IN `json_input` JSON)
BEGIN
  -- Check if the input is a valid JSON object
  IF JSON_VALID(json_input) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid JSON input';
  END IF;

  -- Parse the JSON object using a Common Table Expression
  WITH parsed_json AS (
    SELECT
      JSON_KEYS(json_input) AS `json_keys`,
      JSON_EXTRACT(json_input, '$.*') AS `values`
  )

  -- Output the result set with two columns: key and value
  SELECT
    parsed_json.json_keys AS `key`,
    parsed_json.values AS `value`
  FROM parsed_json;
END$$
DELIMITER ;

CALL json_to_table('{"foo":true,"bar":{"baz":2},"0":1,"2":"three"}');