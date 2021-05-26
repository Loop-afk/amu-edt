-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le : mer. 26 mai 2021 à 15:31
-- Version du serveur :  8.0.25
-- Version de PHP : 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `amu_edt`
--

-- --------------------------------------------------------

--
-- Structure de la table `Campus`
--

CREATE TABLE `Campus` (
  `campusId` int NOT NULL,
  `campusName` varchar(50) NOT NULL,
  `campusAdress` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Campus`
--

INSERT INTO `Campus` (`campusId`, `campusName`, `campusAdress`) VALUES
(1, 'Luminy', '3 rue luminy'),
(2, 'Aix', '8 avenue Aix en provence');

-- --------------------------------------------------------

--
-- Structure de la table `Course`
--

CREATE TABLE `Course` (
  `courseId` int NOT NULL,
  `courseDate` date NOT NULL,
  `roomId` int NOT NULL,
  `subjectId` int NOT NULL,
  `courseStart` time NOT NULL,
  `courseEnd` time NOT NULL,
  `gradeId` int NOT NULL,
  `teacherId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Course`
--

INSERT INTO `Course` (`courseId`, `courseDate`, `roomId`, `subjectId`, `courseStart`, `courseEnd`, `gradeId`, `teacherId`) VALUES
(5, '2021-05-18', 1, 1, '07:45:00', '10:00:00', 2, 2),
(53, '2021-05-25', 1, 1, '07:00:00', '10:00:00', 1, 1),
(238, '2021-05-26', 1, 1, '07:00:00', '10:00:00', 1, 1),
(239, '2021-05-25', 1, 1, '14:00:00', '16:00:00', 1, 1),
(240, '2021-05-25', 1, 1, '10:15:00', '12:00:00', 1, 1),
(241, '2021-05-25', 1, 1, '10:15:00', '12:00:00', 1, 1),
(246, '2021-05-26', 1, 1, '14:00:00', '17:00:00', 1, 1),
(253, '2021-05-27', 1, 1, '07:00:00', '10:00:00', 1, 1),
(255, '2021-06-04', 1, 1, '10:15:00', '12:00:00', 1, 1),
(256, '2021-05-27', 1, 1, '11:00:00', '12:00:00', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `CourseGrade`
--

CREATE TABLE `CourseGrade` (
  `courseId` int NOT NULL,
  `gradeId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Faculty`
--

CREATE TABLE `Faculty` (
  `facultyId` int NOT NULL,
  `facultyName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Faculty`
--

INSERT INTO `Faculty` (`facultyId`, `facultyName`) VALUES
(1, 'l1 Descartes'),
(2, 'l2 info'),
(3, 'l3info');

-- --------------------------------------------------------

--
-- Structure de la table `Grade`
--

CREATE TABLE `Grade` (
  `gradeId` int NOT NULL,
  `gradeName` varchar(50) NOT NULL,
  `facultyId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Grade`
--

INSERT INTO `Grade` (`gradeId`, `gradeName`, `facultyId`) VALUES
(1, 'l3info AIX', 3),
(2, 'l3info 1 LUMINY', 3),
(3, 'l3info 2 LUMINY', 3),
(4, 'Portail DESCARTES Aix', 1),
(5, 'Portail DESCARTES Luminy', 1),
(6, 'l2info AIX', 2),
(7, 'l2info LUMINY', 2);

-- --------------------------------------------------------

--
-- Structure de la table `Room`
--

CREATE TABLE `Room` (
  `roomId` int NOT NULL,
  `roomType` varchar(50) NOT NULL,
  `roomSlots` int NOT NULL,
  `roomName` varchar(50) NOT NULL,
  `campusId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Room`
--

INSERT INTO `Room` (`roomId`, `roomType`, `roomSlots`, `roomName`, `campusId`) VALUES
(1, 'Amphi', 200, 'Amphi 1', 1),
(2, 'Salle de TD', 35, 'Salle TD1', 1),
(3, 'Salle de TP', 20, 'Salle Info 1', 1),
(4, 'Amphi', 100, 'Amphi boulan', 2),
(5, 'Salle de TD', 35, 'Salle TD4', 2),
(6, 'Salle de TP', 20, 'Salle Info 2', 2);

-- --------------------------------------------------------

--
-- Structure de la table `StudentGrade`
--

CREATE TABLE `StudentGrade` (
  `userId` int NOT NULL,
  `gradeId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `StudentGrade`
--

INSERT INTO `StudentGrade` (`userId`, `gradeId`) VALUES
(1, 1),
(2, 2),
(10, 4),
(9, 5),
(7, 6),
(5, 7),
(6, 3),
(8, 2),
(4, 1);

-- --------------------------------------------------------

--
-- Structure de la table `Subject`
--

CREATE TABLE `Subject` (
  `subjectId` int NOT NULL,
  `subjectName` varchar(50) NOT NULL,
  `facultyId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Subject`
--

INSERT INTO `Subject` (`subjectId`, `subjectName`, `facultyId`) VALUES
(1, 'Compilation', 3),
(2, 'Web AIX', 3),
(3, 'Web LUMINY', 3),
(4, 'Outils Mathématiques', 1),
(5, 'BDR 1', 2);

-- --------------------------------------------------------

--
-- Structure de la table `User`
--

CREATE TABLE `User` (
  `userId` int NOT NULL,
  `userLastName` varchar(50) NOT NULL,
  `userFirstName` varchar(50) NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  `userPassword` varchar(50) NOT NULL,
  `Role` int DEFAULT NULL COMMENT '1 = Student\r\n2 = Teacher\r\n3 = Moderator\r\n4 = Admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `User`
--

INSERT INTO `User` (`userId`, `userLastName`, `userFirstName`, `userEmail`, `userPassword`, `Role`) VALUES
(1, 'Lascoutounas', 'Mickael', 'mickael.lascoutounas@etu.univ-amu.fr', 'mickael', 1),
(2, 'XX', 'Baptiste', 'xx.baptiste@etu.univ-amu.fr', 'baptiste', 4),
(3, 'YY', 'Kevin', 'YY.kevin@etu.univ-amu.fr', 'Kevin', 2),
(4, 'ZZ', 'Florian', 'ZZ.florian@etu.univ-amu.fr', 'florian', 3),
(5, 'XX', 'Jean', 'xx.jean@etu.univ-amu.fr', 'jean', 1),
(6, 'XX', 'Paul', 'xx.paul@etu.univ-amu.fr', 'paul', 1),
(7, 'XX', 'Jacques', 'xx.jacques@etu.univ-amu.fr', 'jacques', 1),
(8, 'XX', 'xavier', 'xx.xavier@etu.univ-amu.fr', 'xavier', 1),
(9, 'XX', 'elise', 'xx.elise@etu.univ-amu.fr', 'elise', 1),
(10, 'XX', 'chloé', 'xx.chloé@etu.univ-amu.fr', 'chloé', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Campus`
--
ALTER TABLE `Campus`
  ADD PRIMARY KEY (`campusId`);

--
-- Index pour la table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`courseId`),
  ADD KEY `Course_Room_FK` (`roomId`),
  ADD KEY `Course_Subject0_FK` (`subjectId`),
  ADD KEY `courseGradeId` (`gradeId`),
  ADD KEY `COURSE_TEACHER_ID` (`teacherId`);

--
-- Index pour la table `CourseGrade`
--
ALTER TABLE `CourseGrade`
  ADD KEY `COURSE_ID_CG_FK` (`courseId`),
  ADD KEY `GRADE_ID_CG_FK` (`gradeId`);

--
-- Index pour la table `Faculty`
--
ALTER TABLE `Faculty`
  ADD PRIMARY KEY (`facultyId`);

--
-- Index pour la table `Grade`
--
ALTER TABLE `Grade`
  ADD PRIMARY KEY (`gradeId`),
  ADD KEY `Grade_Faculty_FK` (`facultyId`);

--
-- Index pour la table `Room`
--
ALTER TABLE `Room`
  ADD PRIMARY KEY (`roomId`),
  ADD KEY `Room_Campus_FK` (`campusId`);

--
-- Index pour la table `StudentGrade`
--
ALTER TABLE `StudentGrade`
  ADD KEY `USER_ID_FK` (`userId`),
  ADD KEY `GRADE_ID_FK` (`gradeId`);

--
-- Index pour la table `Subject`
--
ALTER TABLE `Subject`
  ADD PRIMARY KEY (`subjectId`),
  ADD KEY `Subject_Faculty_FK` (`facultyId`);

--
-- Index pour la table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Campus`
--
ALTER TABLE `Campus`
  MODIFY `campusId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `Course`
--
ALTER TABLE `Course`
  MODIFY `courseId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=257;

--
-- AUTO_INCREMENT pour la table `Faculty`
--
ALTER TABLE `Faculty`
  MODIFY `facultyId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Grade`
--
ALTER TABLE `Grade`
  MODIFY `gradeId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `Room`
--
ALTER TABLE `Room`
  MODIFY `roomId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `Subject`
--
ALTER TABLE `Subject`
  MODIFY `subjectId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `User`
--
ALTER TABLE `User`
  MODIFY `userId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Course`
--
ALTER TABLE `Course`
  ADD CONSTRAINT `Course_Room_FK` FOREIGN KEY (`roomId`) REFERENCES `Room` (`roomId`),
  ADD CONSTRAINT `Course_Subject0_FK` FOREIGN KEY (`subjectId`) REFERENCES `Subject` (`subjectId`),
  ADD CONSTRAINT `COURSE_TEACHER_ID` FOREIGN KEY (`teacherId`) REFERENCES `User` (`userId`),
  ADD CONSTRAINT `courseGradeId` FOREIGN KEY (`gradeId`) REFERENCES `Grade` (`gradeId`);

--
-- Contraintes pour la table `CourseGrade`
--
ALTER TABLE `CourseGrade`
  ADD CONSTRAINT `COURSE_ID_CG_FK` FOREIGN KEY (`courseId`) REFERENCES `Course` (`courseId`) ON DELETE CASCADE,
  ADD CONSTRAINT `GRADE_ID_CG_FK` FOREIGN KEY (`gradeId`) REFERENCES `Grade` (`gradeId`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Grade`
--
ALTER TABLE `Grade`
  ADD CONSTRAINT `Grade_Faculty_FK` FOREIGN KEY (`facultyId`) REFERENCES `Faculty` (`facultyId`);

--
-- Contraintes pour la table `Room`
--
ALTER TABLE `Room`
  ADD CONSTRAINT `Room_Campus_FK` FOREIGN KEY (`campusId`) REFERENCES `Campus` (`campusId`);

--
-- Contraintes pour la table `StudentGrade`
--
ALTER TABLE `StudentGrade`
  ADD CONSTRAINT `GRADE_ID_FK` FOREIGN KEY (`gradeId`) REFERENCES `Grade` (`gradeId`) ON DELETE CASCADE,
  ADD CONSTRAINT `USER_ID_FK` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Subject`
--
ALTER TABLE `Subject`
  ADD CONSTRAINT `Subject_Faculty_FK` FOREIGN KEY (`facultyId`) REFERENCES `Faculty` (`facultyId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
