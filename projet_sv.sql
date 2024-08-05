-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 05 août 2024 à 22:44
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
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x000000000101000000138dff4cce3e3d40fd99e6c2ed55fabf, '2024-08-04 17:47:15'),
(2, 'moise', 'MUHINDO ', 'furaha ', 'Féminin', 0x000000000101000000890f47b2a2393d40a7a32df87e94fabf, '2024-08-05 13:32:55'),
(3, 'moise', 'MUHINDO ', 'furaha ', 'Féminin', 0x0000000001010000001a80b2ce9d393d40d29ad5f14e94fabf, '2024-08-05 15:59:25'),
(4, 'moise', 'MUHINDO ', 'furaha ', 'Féminin', 0x0000000001010000001a80b2ce9d393d40d29ad5f14e94fabf, '2024-08-05 15:59:26');

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
(28, 'happy@gmail.com', '2024-08-04 05:25:41', 0),
(29, 'happy@gmail.com', '2024-08-04 15:19:55', 0),
(30, 'jean@gmail.com', '2024-08-04 15:25:26', 0),
(31, 'happy@gmail.com', '2024-08-04 15:29:44', 0),
(32, 'happy@gmail.com', '2024-08-04 15:33:22', 0),
(33, 'happy@gmail.com', '2024-08-04 15:36:04', 0),
(34, 'happy@gmail.com', '2024-08-04 15:41:44', 0),
(35, 'happy@gmail.com', '2024-08-04 15:50:28', 0),
(36, 'happy@gmail.com', '2024-08-04 15:55:54', 0),
(37, 'happy@gmail.com', '2024-08-04 16:07:21', 0),
(38, 'happy@gmail.com', '2024-08-04 16:11:16', 0),
(39, 'happy@gmail.com', '2024-08-04 16:18:14', 0),
(40, 'happy@gmail.com', '2024-08-04 16:22:35', 0),
(41, 'happy@gmail.com', '2024-08-04 16:50:20', 0),
(42, 'happy@gmail.com', '2024-08-04 16:52:18', 0),
(43, 'happy@gmail.com', '2024-08-04 16:53:31', 0),
(44, 'happy@gmail.com', '2024-08-04 18:14:23', 0),
(45, 'happy@gmail.com', '2024-08-04 18:23:24', 0),
(46, 'happy@gmail.com', '2024-08-04 18:32:32', 0),
(47, 'happy@gmail.com', '2024-08-04 18:51:13', 0),
(48, 'happy@gmail.com', '2024-08-04 19:00:07', 0),
(49, 'happy@gmail.com', '2024-08-04 19:02:43', 0),
(50, 'happy@gmail.com', '2024-08-04 19:04:38', 0),
(51, 'happy@gmail.com', '2024-08-04 19:09:46', 0),
(52, 'happy@gmail.com', '2024-08-04 19:12:58', 0),
(53, 'happy@gmail.com', '2024-08-04 19:18:02', 0),
(54, 'happy@gmail.com', '2024-08-04 19:20:46', 0),
(55, 'happy@gmail.com', '2024-08-05 12:55:28', 0),
(56, 'happy@gmail.com', '2024-08-05 13:15:02', 0),
(57, 'happy@gmail.com', '2024-08-05 13:34:28', 0),
(58, 'happy@gmail.com', '2024-08-05 15:22:40', 0),
(59, 'happy@gmail.com', '2024-08-05 15:55:21', 0);

-- --------------------------------------------------------

--
-- Structure de la table `numero_urgence`
--

CREATE TABLE `numero_urgence` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `postnom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `numero1` int(20) NOT NULL,
  `numero2` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `numero_urgence`
--

INSERT INTO `numero_urgence` (`id`, `nom`, `postnom`, `prenom`, `numero1`, `numero2`) VALUES
(1, 'moise', 'MUHINDO ', 'furaha ', 999582152, 842407351);

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
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x000000000101000000138dff4cce3e3d40fd99e6c2ed55fabf, '2024-08-04 17:47:25'),
(2, 'moise', 'MUHINDO ', 'furaha ', 'Féminin', 0x0000000001010000001a80b2ce9d393d40d29ad5f14e94fabf, '2024-08-05 15:59:25'),
(3, 'moise', 'MUHINDO ', 'furaha ', 'Féminin', 0x000000000101000000e9375d60a0393d4094597336d393fabf, '2024-08-05 16:01:05');

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
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', 0x00000000010100000003441c469c393d4009d51753fa93fabf, '2024-08-05 13:14:22'),
(2, 'MUHINDO ', 'NDAGHANE ', 'Moise', 'Masculin', 0x00000000010100000029649de051393d40e3c85e4ab88bfabf, '2024-08-05 15:19:38'),
(3, 'MUHINDO ', 'NDAGHANE ', 'Moise', 'Masculin', 0x00000000010100000029649de051393d40e3c85e4ab88bfabf, '2024-08-05 15:19:52');

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

--
-- Déchargement des données de la table `states`
--

INSERT INTO `states` (`id`, `table_names`, `record_count`) VALUES
(1, 'ambulance', 4),
(2, 'police', 3),
(3, 'pompier', 3);

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
(6, 'jaen', 'martin', 'papy', 'jean@gmail.com', '$2y$10$q8xPirwVMSLXYMG87uszV.Z00fXdK/Vh4hwvpYDXZDyCEM0Iu5Ljy', 'operateur', 'uploads/image.jpg'),
(7, 'moises', 'musa', 'moses', 'moses@gmail.com', '$2y$10$7g/gUVcjfQtuc8osEqu2kupMOrunwNAb49E4nYX7Qic8oB4SvnOCW', 'operateur', 'uploads/image.jpg');

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
  `Taille` float NOT NULL,
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
(1, 'happy ', 'luvagho ', 'furaha ', 'Féminin', '2024-08-04', 'majengo ', 'Célibataire', NULL, 'saine ', 'aucune ', 2, 90, '0999582152', 'happyluvagho@gmail.com', '$2y$10$kBPzY/sqiWmWDWzZuXcnp.DrLD7HFovOilsPipSCsYgKOGdws1LYW', 'uploads/20240802_113603.jpg'),
(2, 'MUHINDO ', 'NDAGHANE ', 'Moise', 'Masculin', '2001-05-10', 'Quartier KATOYI ', 'Célibataire', NULL, 'Problème de yeux ', 'Allergie aux poussières ', 1, 64, '0997110903', 'mosesmuhindo099@gmail.com', '$2y$10$tM54fFOOeCUNhpRhnhSq2.kVtIXZR0iJ/aVr2Qg3UuIF1lomrt1Ue', 'uploads/IMG-20240220-WA0039.jpg');

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
-- Index pour la table `numero_urgence`
--
ALTER TABLE `numero_urgence`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `numero_urgence`
--
ALTER TABLE `numero_urgence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `operateur`
--
ALTER TABLE `operateur`
  MODIFY `Opid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `police`
--
ALTER TABLE `police`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `pompier`
--
ALTER TABLE `pompier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `Userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
