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
    SELECT
        d.List_id AS id,
        np.Name AS name,
        np.Street_address AS address,
        np.City AS city,
        np.State AS state,
        np.Zip AS zip,
        np.Email AS email,
        np.Area_code AS area_code,
        np.Phone_number AS phone,
        np.Website AS website,
        np.Latitude AS latitude,
        np.Longitude AS longitude,
        np.Last_updated AS last_updated,
        np.Description AS description,
        dc.CName AS category
    FROM Donation_Lists d
    INNER JOIN Non_Profits np ON d.Nonprofit_id = np.Nonprofit_id
    INNER JOIN Donation_Categories dc ON d.Donation_Category = dc.DCategory_id
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
        $row['latitude'] = (float) $row['latitude'];
        $row['longitude'] = (float) $row['longitude'];
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
            dc.CName AS catname
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
                $donations[$did]['donations'][] = $d['catname'];
            }
        }
        $resultscat->free();
    }

    $mysqli->close();

    echo json_encode(array_values($donations), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);