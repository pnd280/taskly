CREATE TABLE `Task` (
  `id` text PRIMARY KEY,
  `title` text,
  `richDescription` text COMMENT 'JSON/MD format',
  `createdAt` datetime,
  `updatedAt` datetime,
  `beginAt` datetime,
  `endAt` datetime,
  `repeat` boolean DEFAULT false,
  `priority` int DEFAULT 4,
  `isCompleted` boolean DEFAULT false,
  `projectId` text,
  `isVisible` boolean DEFAULT true
);

CREATE TABLE `Project` (
  `id` text PRIMARY KEY,
  `title` text,
  `description` text,
  `createdAt` datetime,
  `isVisible` boolean DEFAULT true
);

CREATE TABLE `Tag` (
  `id` text PRIMARY KEY,
  `title` text,
  `color` text COMMENT 'Hexadecimal format',
  `isVisible` boolean DEFAULT true
);

CREATE TABLE `TaggedTask` (
  `taskId` text,
  `tagId` text
);

CREATE TABLE `RepeatedTask` (
  `id` text PRIMARY KEY,
  `taskId` text,
  `repeatType` text,
  `interval` int
);

CREATE TABLE `Reminder` (
  `id` text PRIMARY KEY,
  `taskId` text,
  `time` datetime
);

ALTER TABLE `Task` ADD FOREIGN KEY (`projectId`) REFERENCES `Project` (`id`);

ALTER TABLE `TaggedTask` ADD FOREIGN KEY (`taskId`) REFERENCES `Task` (`id`);

ALTER TABLE `TaggedTask` ADD FOREIGN KEY (`tagId`) REFERENCES `Tag` (`id`);

ALTER TABLE `RepeatedTask` ADD FOREIGN KEY (`taskId`) REFERENCES `Task` (`id`);

ALTER TABLE `Reminder` ADD FOREIGN KEY (`taskId`) REFERENCES `Task` (`id`);
