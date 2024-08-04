<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    include('conn.php');

    $data = json_decode(file_get_contents('php://input'), true);

    $nom = $data['nom'];
    $postnom = $data['postnom'];
    $prenom = $data['prenom'];
    $sexe = $data['sexe'];
    $latitude = $data['latitude'];
    $longitude = $data['longitude'];
    $type = $data['type']; // Le type d'urgence (par exemple: 'police', 'ambulance', 'pompier')

    if ($nom && $postnom && $prenom && $sexe && $latitude && $longitude && $type) {
        // Préparer la requête d'insertion en fonction du type d'urgence
        $stmt = $connect->prepare("INSERT INTO $type (nom, postnom, prenom, sexe, locations) VALUES (?, ?, ?, ?, ST_GeomFromText(?))");

        // Créer le POINT en format WKT
        $point = "POINT($longitude $latitude)";

        $stmt->bind_param("sssss", $nom, $postnom, $prenom, $sexe, $point);

        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'id' => $stmt->insert_id]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Erreur lors de l\'insertion']);
        }

        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'Données manquantes']);
    }
}

?>
