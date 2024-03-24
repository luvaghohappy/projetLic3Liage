<?php
header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Origin: http://localhost:54614");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST");

include('conn.php');

// Récupération des données du formulaire, en les protégeant contre les attaques XSS
$email = htmlspecialchars($_POST["email"]);
$password = htmlspecialchars($_POST["passwords"]);
$role = htmlspecialchars($_POST["roles"]);

// Vérification s'il y a une image envoyée
if(isset($_FILES['profil'])) {
    // Récupération des données de l'image
    $image = $_FILES['profil'];
    
    // Nom temporaire de l'image
    $tmpName = $image['tmp_name'];
    
    // Lecture des données binaires de l'image
    $imageData = file_get_contents($tmpName);
    
    // Encodage des données binaires de l'image en base64
    $base64Image = base64_encode($imageData);
    
    // Requête SQL pour insérer les données dans la table 'users'
    $sql = "INSERT INTO users (email, passwords,roles, profil) VALUES ('$email', '$password','$role', '$base64Image')";
    
    // Exécution de la requête SQL
    if(mysqli_query($connect, $sql)) {
        echo json_encode("success");
    } else {
        echo json_encode("failed");
    }
} else {
    // Si aucune image n'est envoyée, renvoyer une réponse d'erreur
    echo json_encode("Aucune image envoyée");
}
?>