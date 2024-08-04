<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include('conn.php');

$response = array();

function getTableData($tableName) {
    global $connect;
    $stmt = $connect->prepare("SELECT id, nom, postnom, prenom, sexe, ST_AsText(locations) as locations, created_at FROM $tableName");
    $stmt->execute();
    $data = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    
    // Ajouter le champ 'service' pour indiquer la source des données
    foreach ($data as &$row) {
        $row['service'] = $tableName;
    }
    
    return $data;
}

try {
    $response = array_merge(
        getTableData('ambulance'),
        getTableData('police'),
        getTableData('pompier')
    );

    echo json_encode($response);

} catch (Exception $e) {
    echo json_encode(['error' => 'An error occurred while retrieving data']);
}
?>
