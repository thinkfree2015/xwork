CREATE TABLE `xw_flow` (
`id`  char(16) NOT NULL ,
`title`  varchar(255) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_flow_activity` (
`id`  char(16) NOT NULL ,
`title`  varchar(255) NULL ,
`type`  varchar(16) NULL ,
`xw_user_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_role` (
`id`  char(16) NOT NULL ,
`name`  varchar(255) NULL ,
`c_name`  varchar(255) NULL ,
`basic_type`  varchar(8) NULL ,
`status`  char(2) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_user` (
`id`  char(16) NOT NULL ,
`username`  varchar(255) NULL ,
`name`  varchar(255) NULL ,
`password`  varchar(255) NULL ,
`role_id`  char(16) NULL ,
`status`  char(2) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_project` (
`id`  char(16) NOT NULL ,
`title`  varchar(255) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_task` (
`id`  char(16) NOT NULL ,
`task_group_id`  char(16) NULL ,
`content`  varchar(255) NULL ,
`user_id`  char(16) NULL ,
`author_id`  char(16) NULL ,
`create_datetime`  datetime NULL ,
`flow_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_task_activity_instance` (
`id`  char(16) NULL ,
`issue`  varchar(255) NULL ,
`status`  char(2) NULL ,
`content`  varchar(255) NULL ,
`excutor_id`  char(16) NULL ,
`create_datetime`  datetime NULL
)
;
CREATE TABLE `xw_task_attachment` (
`id`  char(16) NOT NULL ,
`task_id`  char(16) NULL ,
`type`  varchar(50) NULL ,
`fileName`  varchar(255) NULL ,
`url`  varchar(255) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_task_group` (
`id`  char(16) NOT NULL ,
`title`  varchar(255) NULL ,
`project_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_task_note` (
`id`  char(16) NOT NULL ,
`task_id`  char(16) NULL ,
`create_datetime`  datetime NULL ,
`content`  varchar(255) NULL ,
`creator_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `xw_message` (
  `id` char(16) NOT NULL,
  `creator_id` char(16) NOT NULL,
  `receiver_id` char(16) NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `type` varchar(2) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `createDatetime` DATE ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;