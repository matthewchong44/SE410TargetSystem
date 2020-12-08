CREATE DATABASE `targetSystem`;

USE `targetSystem`;

CREATE TABLE `Users` (
  `userID` int NOT NULL,
  `submitterID` int DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `Locked` tinyint(1) DEFAULT NULL,
  `group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userID`)
);

CREATE TABLE `Materials` (
  `materialID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Content` varchar(255) DEFAULT NULL,
  `ReadableFileName` varchar(255) DEFAULT NULL,
  `AccessFlag` tinyint(1) DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `NumberOfRating` int DEFAULT NULL,
  PRIMARY KEY (`materialID`),
  UNIQUE KEY `id` (`materialID`)
);

CREATE TABLE `Module` (
  `ModuleID` int NOT NULL AUTO_INCREMENT,
  `DateTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `Description` varchar(255) DEFAULT NULL,
  `Language` varchar(255) NOT NULL,
  `Status` varchar(255) NOT NULL,
  `Version` int NOT NULL,
  `SubmitterUserID` int NOT NULL,
  `AuthorComments` varchar(255) DEFAULT NULL,
  `CheckInComments` varchar(255) DEFAULT NULL,
  `Lecture` varchar(255) DEFAULT NULL,
  `Lab` varchar(255) DEFAULT NULL,
  `Homework` varchar(255) DEFAULT NULL,
  `Restrictions` int DEFAULT NULL COMMENT 'int',
  `BaseID` int DEFAULT NULL,
  `EducationLevel` int DEFAULT NULL,
  `Rights` longtext,
  `PrerequisiteID` int DEFAULT NULL,
  PRIMARY KEY (`ModuleID`),
  UNIQUE KEY `id` (`ModuleID`),
  KEY `BaseID` (`BaseID`)
);

CREATE TABLE `moduleBases` (
  `baseID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `moduleIdentifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`baseID`),
  UNIQUE KEY `id` (`baseID`),
  FOREIGN KEY (`baseID`) REFERENCES `Module` (`BaseID`)
);

CREATE TABLE `categories` (
  `categoryID` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `id` (`categoryID`),
  FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`)
);

CREATE TABLE `currentLogIn` (
  `currentLoginID` int NOT NULL,
  `userID` int DEFAULT NULL,
  `authenticationToken` int DEFAULT NULL,
  `expires` date DEFAULT NULL,
  PRIMARY KEY (`currentLoginID`),
  KEY `userID` (`userID`),
  FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`)
);

CREATE TABLE `emails` (
  `emailID` int DEFAULT NULL,
  `moduleID` int DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `userID` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  KEY `moduleID` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `MaterialComments` (
  `materialID` int NOT NULL AUTO_INCREMENT,
  `comments` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `averageRating` int DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `ratingScore` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`materialID`),
  UNIQUE KEY `id` (`materialID`),
  FOREIGN KEY (`materialID`) REFERENCES `Materials` (`materialID`)
);

CREATE TABLE `materialRatings` (
  `materialID` int NOT NULL AUTO_INCREMENT,
  `rating` double DEFAULT NULL,
  `avgRatings` double DEFAULT NULL,
  `numRatings` int DEFAULT NULL,
  PRIMARY KEY (`materialID`),
  UNIQUE KEY `id` (`materialID`),
  FOREIGN KEY (`materialID`) REFERENCES `Materials` (`materialID`)
);

CREATE TABLE `moduleAuthors` (
  `moduleID` int NOT NULL AUTO_INCREMENT,
  `authorName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  UNIQUE KEY `id` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `moduleCategories` (
  `moduleID` int NOT NULL AUTO_INCREMENT,
  `categoryID` int DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  UNIQUE KEY `id` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `moduleHierarchy` (
  `moduleID` int NOT NULL AUTO_INCREMENT,
  `orderID` int DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  UNIQUE KEY `id` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `moduleLog` (
  `moduleID` int NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `userID` int DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  UNIQUE KEY `id` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `moduleRatings` (
  `moduleID` int NOT NULL AUTO_INCREMENT,
  `numRatings` int DEFAULT NULL,
  `avgRatings` double DEFAULT NULL,
  `rating` double DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  UNIQUE KEY `id` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `objectives` (
  `obectiveText` varchar(255) DEFAULT NULL,
  `moduleID` int DEFAULT NULL,
  `orderID` int DEFAULT NULL,
  `progress` int DEFAULT NULL,
  KEY `moduleID` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `otherResources` (
  `moduleID` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `resourceLink` varchar(255) DEFAULT NULL,
  `orderID` int DEFAULT NULL,
  PRIMARY KEY (`moduleID`),
  UNIQUE KEY `id` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `prerequisites` (
  `prerequisiteID` int NOT NULL AUTO_INCREMENT,
  `moduleID` int DEFAULT NULL,
  `orderID` int DEFAULT NULL,
  `prerequisiteText` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`prerequisiteID`),
  UNIQUE KEY `id` (`prerequisiteID`),
  KEY `moduleID` (`moduleID`),
  FOREIGN KEY (`moduleID`) REFERENCES `Module` (`ModuleID`)
);

CREATE TABLE `recovery` (
  `id` int NOT NULL,
  `userID` int DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expires` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`)
);

CREATE TABLE `seeAlso` (
  `description` varchar(255) DEFAULT NULL,
  `ModuleID` int DEFAULT NULL,
  `orderID` int DEFAULT NULL,
  KEY `moduleID` (`ModuleID`),
  FOREIGN KEY (`ModuleID`) REFERENCES `Module` (`ModuleID`)
);
