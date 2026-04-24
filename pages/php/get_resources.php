<?php

//Database config

define('DBHost', 'localhost');
define('DBUser', 'admin');
define('DBPass', '1234');
define('DBName', 'resource_directory');

header('Content-Type: application/json');

$mysqli = new mysqli(DBHost, DBUser, DBPass, DBName);
if ($mysqli->connect_error) {
    http_response_code(500);
    echo json_encode([
        'error' => 'Database connection failed'
    ]);
    exit;
}
$mysqli->set_charset('utf8mb4');

// Query to join resources and non-profit tables
$sql = "
    SELECT
        r.Resource_id AS id,
        np.Name AS name,
        np.Street_address AS address,
        np.City AS city,
        np.State AS state,
        np.Zip AS zip
        np.Email AS email,
        np.Area_code AS area_code,
        np.Phone_number AS phone,
        np.Website AS website,
        np.Latitude AS latitude,
        np.Longitude AS longitude,
        np.Last_updated AS last_updated
        np.Description AS description
        rc.Name AS category
    FROM Resources r
    INNER JOIN Non_Profits np ON r.Nonprofit_id = np.Nonprofit_id
    INNER JOIN Resource_Categories rc ON r.RCategory_id = rc.RCategory_id
    ORDER BY np.Name ASC";

    $result = $mysqli->query($sql);
    if(!$result) {
        http_response_code(500);
        echo json_encode([
            'error' => 'Query failed'
        ]);
        exit;
    }