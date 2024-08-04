-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 04 août 2024 à 15:17
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet_sv`
--

-- --------------------------------------------------------

--
-- Structure de la table `ambulance`
--

CREATE TABLE `ambulance` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `postnom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `sexe` varchar(250) NOT NULL,
  `locations` point NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ambulance`
--

INSERT INTO `ambulance` (`id`, `nom`, `postnom`, `prenom`, `sexe`, `locations`, `created_at`) VALUES
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x000000000101000000a758da4e004afabf9dae38e6863e3d40, '2024-08-03 23:27:30'),
(2, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x0000000001010000009dae38e6863e3d40a758da4e004afabf, '2024-08-03 23:27:30'),
(3, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x000000000101000000d3cdb4b39e3e3d409871aebc3f59fabf, '2024-08-03 23:27:30');

--
-- Déclencheurs `ambulance`
--
DELIMITER $$
CREATE TRIGGER `after_insert_ambulance` AFTER INSERT ON `ambulance` FOR EACH ROW BEGIN
    DECLARE table_exists INT;
    
    -- Vérifie si une entrée pour 'ambulance' existe déjà dans la table states
    SELECT COUNT(*) INTO table_exists 
    FROM states 
    WHERE table_names = 'ambulance';
    
    IF table_exists > 0 THEN
        -- Si une entrée existe, incrémente le compteur d'enregistrements
        UPDATE states 
        SET record_count = record_count + 1 
        WHERE table_names = 'ambulance';
    ELSE
        -- Si aucune entrée n'existe, insère une nouvelle ligne avec un compteur de 1
        INSERT INTO states (table_names, record_count) 
        VALUES ('ambulance', 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `calls`
--

CREATE TABLE `calls` (
  `id` int(11) NOT NULL,
  `usernom` varchar(100) NOT NULL,
  `userprenom` varchar(100) NOT NULL,
  `opnom` varchar(100) NOT NULL,
  `opprenom` varchar(100) NOT NULL,
  `date_heure` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historique_appel`
--

CREATE TABLE `historique_appel` (
  `id` int(11) NOT NULL,
  `numero` varchar(50) NOT NULL,
  `adresse` varchar(250) NOT NULL,
  `cordonnee_geo` point NOT NULL,
  `Date_Appel` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historique_travail`
--

CREATE TABLE `historique_travail` (
  `id` int(11) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Heure_Entree` datetime NOT NULL,
  `Heure_Sortie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_travail`
--

INSERT INTO `historique_travail` (`id`, `Email`, `Heure_Entree`, `Heure_Sortie`) VALUES
(1, 'happy@gmail.com', '2024-07-28 16:06:49', 0),
(2, 'happy@gmail.com', '2024-07-28 17:51:11', 0),
(3, 'happy@gmail.com', '2024-07-28 17:58:22', 0),
(4, 'happy@gmail.com', '2024-07-29 13:48:06', 0),
(5, 'happy@gmail.com', '2024-07-29 14:14:52', 0),
(6, 'happy@gmail.com', '2024-07-29 14:31:17', 0),
(7, 'happy@gmail.com', '2024-07-29 14:48:09', 0),
(8, 'happy@gmail.com', '2024-07-29 16:17:14', 0),
(9, 'furaha@gmail.com', '2024-08-03 22:36:37', 0),
(10, 'furaha@gmail.com', '2024-08-03 23:12:47', 0),
(11, 'furaha@gmail.com', '2024-08-03 23:16:53', 0),
(12, 'furaha@gmail.com', '2024-08-03 23:43:01', 0),
(13, 'furaha@gmail.com', '2024-08-03 23:49:06', 0),
(14, 'furaha@gmail.com', '2024-08-03 23:50:08', 0),
(15, 'furaha@gmail.com', '2024-08-03 23:52:04', 0),
(16, 'furaha@gmail.com', '2024-08-04 00:00:24', 0),
(17, 'furaha@gmail.com', '2024-08-04 00:11:52', 0),
(18, 'furaha@gmail.com', '2024-08-04 00:25:31', 0),
(19, 'furaha@gmail.com', '2024-08-04 01:33:32', 0),
(20, 'furaha@gmail.com', '2024-08-04 01:55:58', 0),
(21, 'happy@gmail.com', '2024-08-04 02:06:03', 0),
(22, 'happy@gmail.com', '2024-08-04 02:08:14', 0),
(23, 'happy@gmail.com', '2024-08-04 02:10:30', 0),
(24, 'happy@gmail.com', '2024-08-04 02:11:51', 0),
(25, 'happy@gmail.com', '2024-08-04 02:13:15', 0),
(26, 'happy@gmail.com', '2024-08-04 02:46:24', 0),
(27, 'happy@gmail.com', '2024-08-04 05:14:12', 0),
(28, 'happy@gmail.com', '2024-08-04 05:25:41', 0);

-- --------------------------------------------------------

--
-- Structure de la table `operateur`
--

CREATE TABLE `operateur` (
  `Opid` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `postnom` varchar(100) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `image_path` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `operateur`
--

INSERT INTO `operateur` (`Opid`, `nom`, `postnom`, `prenom`, `email`, `image_path`) VALUES
(1, 'furaha ', 'luvagho ', 'happy ', 'happyluvagho@gmail.com', 'uploads/IMG-20240801-WA0021.jpg'),
(6, 'moise', 'muhindo', 'moses', 'moisemusa@gmail.com', 'uploads/IMG-20240801-WA0019.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `police`
--

CREATE TABLE `police` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `postnom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `sexe` varchar(250) NOT NULL,
  `locations` point NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `police`
--

INSERT INTO `police` (`id`, `nom`, `postnom`, `prenom`, `sexe`, `locations`, `created_at`) VALUES
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x000000000101000000c2bb010b0551fabf6592ec6c233f3d40, '2024-08-03 23:27:10'),
(2, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x000000000101000000c2bb010b0551fabf6592ec6c233f3d40, '2024-08-03 23:27:10');

--
-- Déclencheurs `police`
--
DELIMITER $$
CREATE TRIGGER `after_insert_police` AFTER INSERT ON `police` FOR EACH ROW BEGIN
    DECLARE table_exists INT;
    
    -- Vérifie si une entrée pour 'ambulance' existe déjà dans la table states
    SELECT COUNT(*) INTO table_exists 
    FROM states 
    WHERE table_names = 'police';
    
    IF table_exists > 0 THEN
        -- Si une entrée existe, incrémente le compteur d'enregistrements
        UPDATE states 
        SET record_count = record_count + 1 
        WHERE table_names = 'police';
    ELSE
        -- Si aucune entrée n'existe, insère une nouvelle ligne avec un compteur de 1
        INSERT INTO states (table_names, record_count) 
        VALUES ('police', 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `pompier`
--

CREATE TABLE `pompier` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `postnom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `sexe` varchar(250) NOT NULL,
  `locations` point NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `pompier`
--

INSERT INTO `pompier` (`id`, `nom`, `postnom`, `prenom`, `sexe`, `locations`, `created_at`) VALUES
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x0000000001010000002b31cf4a5a51fabfcf70b9b0243f3d40, '2024-08-03 23:26:50');

--
-- Déclencheurs `pompier`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pompier` AFTER INSERT ON `pompier` FOR EACH ROW BEGIN
    DECLARE table_exists INT;
    
    -- Vérifie si une entrée pour 'pompier' existe déjà dans la table states
    SELECT COUNT(*) INTO table_exists 
    FROM states 
    WHERE table_names = 'pompier';
    
    IF table_exists > 0 THEN
        -- Si une entrée existe, incrémente le compteur d'enregistrements
        UPDATE states 
        SET record_count = record_count + 1 
        WHERE table_names = 'pompier';
    ELSE
        -- Si aucune entrée n'existe, insère une nouvelle ligne avec un compteur de 1
        INSERT INTO states (table_names, record_count) 
        VALUES ('pompier', 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `table_names` varchar(100) NOT NULL,
  `record_count` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `postnom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `passwords` varchar(100) NOT NULL,
  `roles` varchar(100) NOT NULL,
  `profil` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`userId`, `nom`, `postnom`, `prenom`, `email`, `passwords`, `roles`, `profil`) VALUES
(1, 'happy', 'luvagho', 'furaha', 'happy@gmail.com', '$2y$10$/AGj4U8vS2NbfwBSr8zgRuL9dZgTyTXzSen04nnM0cYMRWaFkFrDO', 'admin', 'uploads/image.jpg'),
(4, 'moise', 'moses', 'musa', 'moise@gmail.com', '$2y$10$/bRKHgsYYBasjpjMNf7Cguz.BKUNGeFQSQZTJAvk6NB8iRWJk2EzO', 'admin', 'uploads/image.jpg'),
(5, 'martin', 'musa', 'happy', 'martin@gmail.com', '$2y$10$21Wk59xgDrKzFGmK5MkhLuFWKS4r.V/xAe1hzOvuApBWWz.yrTHXK', 'utilisateur', 'uploads/image.jpg'),
(6, 'jaen', 'martin', 'papy', 'jean@gmail.com', '$2y$10$q8xPirwVMSLXYMG87uszV.Z00fXdK/Vh4hwvpYDXZDyCEM0Iu5Ljy', 'operateur', 'uploads/image.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `Userid` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `postnom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `sexe` varchar(10) NOT NULL,
  `Date_naissance` date NOT NULL,
  `Adresse` varchar(255) NOT NULL,
  `Etat_civil` varchar(20) NOT NULL,
  `nombre_enfant` int(11) DEFAULT NULL,
  `Etat_sanitaire` varchar(255) NOT NULL,
  `allergie` varchar(255) NOT NULL,
  `Taille` decimal(10,0) NOT NULL,
  `Poids` float NOT NULL,
  `Numero` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `image_path` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`Userid`, `nom`, `postnom`, `prenom`, `sexe`, `Date_naissance`, `Adresse`, `Etat_civil`, `nombre_enfant`, `Etat_sanitaire`, `allergie`, `Taille`, `Poids`, `Numero`, `email`, `mot_de_passe`, `image_path`) VALUES
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', '2024-08-02', 'majengo ', 'Célibataire', NULL, 'saine ', 'aucune ', 1, 80, '0999582152', 'happyluvagho@gmail.com', '$2y$10$GoxQ1y1M3ydRKpx5nZQ2EeXmLW2FV/s3jkFDmDJR17KV2p/eFBuKK', 'uploads/20240802_164654.jpg');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ambulance`
--
ALTER TABLE `ambulance`
  ADD PRIMARY KEY (`id`),
  ADD SPATIAL KEY `locations` (`locations`);

--
-- Index pour la table `calls`
--
ALTER TABLE `calls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `historique_appel`
--
ALTER TABLE `historique_appel`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `historique_travail`
--
ALTER TABLE `historique_travail`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `operateur`
--
ALTER TABLE `operateur`
  ADD PRIMARY KEY (`Opid`);

--
-- Index pour la table `police`
--
ALTER TABLE `police`
  ADD PRIMARY KEY (`id`),
  ADD SPATIAL KEY `locations` (`locations`);

--
-- Index pour la table `pompier`
--
ALTER TABLE `pompier`
  ADD PRIMARY KEY (`id`),
  ADD SPATIAL KEY `locations` (`locations`);

--
-- Index pour la table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`Userid`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ambulance`
--
ALTER TABLE `ambulance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `calls`
--
ALTER TABLE `calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_appel`
--
ALTER TABLE `historique_appel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_travail`
--
ALTER TABLE `historique_travail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `operateur`
--
ALTER TABLE `operateur`
  MODIFY `Opid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `police`
--
ALTER TABLE `police`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `pompier`
--
ALTER TABLE `pompier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `Userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
