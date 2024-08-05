<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");
include('conn.php');

$id = htmlspecialchars($_POST['id']);

if (!$id) {
    echo json_encode(array("status" => "failed", "message" => "ID utilisateur manquant"));
    exit;
}

$sql = "DELETE FROM users WHERE userId = ?";
$stmt = $connect->prepare($sql);

if ($stmt === false) {
    echo json_encode(array("status" => "failed", "message" => "Erreur de préparation de la requête"));
    exit;
}

$stmt->bind_param("s", $id);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(array("status" => "success", "message" => "Utilisateur supprimé avec succès"));
    } else {
        echo json_encode(array("status" => "failed", "message" => "Aucun utilisateur trouvé avec cet ID"));
    }
} else {
    echo json_encode(array("status" => "failed", "message" => "Erreur lors de l'exécution de la requête"));
}

$stmt->close();
$connect->close();
?>
