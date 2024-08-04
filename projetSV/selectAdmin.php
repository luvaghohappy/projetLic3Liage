<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST");
include('conn.php');

// Traitement de la connexion
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['email']) && isset($_POST['passwords'])) {
    // Récupérer les données de l'utilisateur
    $email = $_POST['email'];
    $password = $_POST['passwords'];

    // Requête SQL pour vérifier les informations d'identification dans la table "users"
    $query = "SELECT passwords, roles FROM users WHERE email = ?";
    $statement = mysqli_prepare($connect, $query); 
    if ($statement) {
        mysqli_stmt_bind_param($statement, 's', $email);
        mysqli_stmt_execute($statement);
        mysqli_stmt_store_result($statement);

        // Vérifier si la requête s'est bien déroulée
        if (mysqli_stmt_num_rows($statement) > 0) {
            // Récupérer le mot de passe haché et le rôle de l'utilisateur
            mysqli_stmt_bind_result($statement, $hashed_password, $roles);
            mysqli_stmt_fetch($statement);

            // Vérifier si le mot de passe correspond
            if (password_verify($password, $hashed_password)) {
                // Vérifier le rôle de l'utilisateur
                if ($roles == "admin") {
                    // Utilisateur authentifié avec succès
                    $response['success'] = true;
                    $response['message'] = "Connexion réussie.";
                    $response['roles'] = $roles; // Envoyer le rôle de l'utilisateur
                } else {
                    // Rôle non autorisé
                    $response['success'] = false;
                    $response['message'] = "Vous n'avez pas les autorisations nécessaires pour accéder.";
                }
            } else {
                // Mot de passe incorrect
                $response['success'] = false;
                $response['message'] = "Identifiants incorrects.";
            }
        } else {
            // Utilisateur non trouvé
            $response['success'] = false;
            $response['message'] = "Identifiants incorrects.";
        }
    } else {
        // Erreur de préparation de la requête
        $response['success'] = false;
        $response['message'] = "Erreur de préparation de la requête.";
    }

    // Renvoyer la réponse au format JSON à l'application Flutter
    echo json_encode($response);
} else {
    // Méthode non autorisée
    http_response_code(405);
    echo json_encode(array("message" => "Méthode non autorisée."));
}
?>
