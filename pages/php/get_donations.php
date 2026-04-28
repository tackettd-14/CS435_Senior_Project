<?php

//Database config

define('DBHost', 'localhost');
define('DBUser', 'admin');
define('DBPass', '1234');
define('DBName', 'resource_directory');

header('Content-Type: application/json');

$mysqli = new mysqli(DBHost, DBUser, DBPass, DBName);
if($mysqli->connect_error) {
    http_response_code(500);
    echo json_encode([
        'error' => 'Database connection failed'
    ]);
    exit;
}
$mysqli->set_charset('utf8mb4');

// Query to join donations and non-profit tables
$sql = "
    SELECT DISTINCT
        np.Nonprofit_id AS id,
        np.Name         AS name,
        np.Street_address AS address,
        np.City         AS city,
        np.State        AS state,
        np.Zip          AS zip,
        np.Phone_number AS phone,
        np.Area_code    AS area_code,
        np.Email        AS email,
        np.Website      AS website,
        np.Description  AS description,
        np.Latitude     AS lat,
        np.Longitude    AS lng
    FROM Non_Profits np
    INNER JOIN Donation_Lists d ON np.Nonprofit_id = d.Nonprofit_id
    ORDER BY np.Name ASC";

    $result = $mysqli->query($sql);
    if(!$result) {
        http_response_code(500);
        echo json_encode([
            'error' => 'Query failed'
        ]);
        exit;
    }

    // Fill donations array with results
    $donations = [];
    while($row = $result->fetch_assoc()) {
        $row['id'] = (int) $row['id'];
        $row['lat'] = (float) $row['lat'];
        $row['lng'] = (float) $row['lng'];
        $row['hours'] = [];
        $row['categories'] = [];
        $donations[$row['id']] = $row;
    }
    $result->free();

    if(empty($donations)) {
        echo json_encode([]);
        exit;
    }

    $ids_placeholder = implode(',', array_keys($donations));

    // Query for donation time table
    $sqlhours = "
        SELECT Nonprofit_id, Day, Open, Close
        FROM Donation_Hours
        WHERE Nonprofit_id IN ($ids_placeholder)
        ORDER BY Nonprofit_id,
            FIELD(Day,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
            Open";

    // Fill array with time information
    $resulthours = $mysqli->query($sqlhours);
    if($resulthours) {
        while($h = $resulthours->fetch_assoc()) {
            $did = (int) $h['Nonprofit_id'];
            if(isset($donations[$did])) {
                $donations[$did]['hours'][] = [
                    'day' => $h['Day'],
                    'open' => $h['Open'],
                    'close' => $h['Close']
                ];
            }
        }
        $resulthours->free();
    }

    // Query for donation categories
    $sqlcat = "
        SELECT 
            dl.Nonprofit_id,
            dc.CName AS category_name
        FROM Donation_Lists dl
        INNER JOIN Donation_Categories dc ON dl.Donation_Category = dc.DCategory_id
        WHERE dl.Nonprofit_id IN ($ids_placeholder)
        ORDER BY Nonprofit_id, dc.CName";

    // Fill array with donation categories
    $resultcat = $mysqli->query($sqlcat);
    if($resultcat) {
        while($d = $resultcat->fetch_assoc()) {
            $did = (int) $d['Nonprofit_id'];
            if(isset($donations[$did])) {
                $donations[$did]['categories'][] = $d['category_name'];
            }
        }
        $resultcat->free();
    }

    $mysqli->close();

    echo json_encode(array_values($donations), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);