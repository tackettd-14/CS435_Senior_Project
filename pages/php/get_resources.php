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

    // Fill resources array with results
    $resources = [];
    while($row = $result->fetch_assoc()) {
        $row['id'] = (int) $row['id'];
        $row['latitude'] = (float) $row['latitude'];
        $row['longitude'] = (float) $row['longitude'];
        $row['hours'] = [];
        $row['category'] = $row['category'] ?? 'Uncategorized';
        $resources[$row['id']] = $row;
    }
    $result->free();

    if(empty($resources)) {
        echo json_encode([]);
        exit;
    }

    $ids_placeholder = implode(',', array_keys($resources));

    // Query for resource time table
    $sqlhours = "
        SELECT
            rh.Resource_id,
            rw.Description AS desc,
            rh.Week AS week_id,
            rh.Day,
            rh.Open,
            rh.Close
        FROM Resource_Hours rh
        INNER JOIN Resource_Week rw ON rh.Week = rw.RWeek_id
        WHERE rh.Resource_id IN ($ids_placeholder)
        ORDER BY rh.Resource_id, rh.Week,
            FIELD(rh.Day,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
            rh.Open";

    // Fill array with time information
    $resulthours = $mysqli->query($sqlhours);
    if($resulthours) {
        while($h = $resulthours->fetch_assoc()) {
            $rid = (int) $h['Resource_id'];
            if(isset($resources[$rid])) {
                $resources[$rid]['hours'][] = [
                    'week' => $h['desc'],
                    'day' => $h['Day'],
                    'open' => $h['Open'],
                    'close' => $h['Close']
                ];
            }
        }
        $resulthours->free();
    }

    $mysqli(close);

    echo json_encode(array_values($resources), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);