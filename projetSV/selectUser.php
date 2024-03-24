<?php
header("Access-Control-Allow-Origin: http://localhost:54422");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST");
include('conn.php');

function getUserRole($userId) {
    // Remplacez cette requête par celle correspondant à votre base de données
    $query = "SELECT roles FROM users WHERE id = $userId";
    $result = mysqli_query($connection, $query);
    
    // Récupérer le rôle de l'utilisateur
    $row = mysqli_fetch_assoc($result);
    return $row['roles'];
}

// Exemple d'utilisation de la fonction
if (isset($_GET['userId'])) {
    $userId = $_GET['userId'];
    $role = getUserRole($userId);
    echo json_encode(array("roles" => $role));
}
?>