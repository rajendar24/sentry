--Licensed to the Apache Software Foundation (ASF) under one or more
--contributor license agreements.  See the NOTICE file distributed with
--this work for additional information regarding copyright ownership.
--The ASF licenses this file to You under the Apache License, Version 2.0
--(the "License"); you may not use this file except in compliance with
--the License.  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.

CREATE TABLE "SENTRY_DB_PRIVILEGE" (
  "DB_PRIVILEGE_ID" NUMBER NOT NULL,
  "PRIVILEGE_SCOPE" VARCHAR2(32) NOT NULL,
  "SERVER_NAME" VARCHAR2(128) NOT NULL,
  "DB_NAME" VARCHAR2(128) DEFAULT '__NULL__',
  "TABLE_NAME" VARCHAR2(128) DEFAULT '__NULL__',
  "COLUMN_NAME" VARCHAR2(128) DEFAULT '__NULL__',
  "URI" VARCHAR2(4000) DEFAULT '__NULL__',
  "ACTION" VARCHAR2(128) NOT NULL,
  "CREATE_TIME" NUMBER NOT NULL,
  "WITH_GRANT_OPTION" CHAR(1) DEFAULT 'N' NOT NULL
);

CREATE TABLE "SENTRY_ROLE" (
  "ROLE_ID" NUMBER  NOT NULL,
  "ROLE_NAME" VARCHAR2(128) NOT NULL,
  "CREATE_TIME" NUMBER NOT NULL
);

CREATE TABLE "SENTRY_GROUP" (
  "GROUP_ID" NUMBER  NOT NULL,
  "GROUP_NAME" VARCHAR2(128) NOT NULL,
  "CREATE_TIME" NUMBER NOT NULL
);

CREATE TABLE "SENTRY_ROLE_DB_PRIVILEGE_MAP" (
  "ROLE_ID" NUMBER NOT NULL,
  "DB_PRIVILEGE_ID" NUMBER NOT NULL,
  "GRANTOR_PRINCIPAL" VARCHAR2(128)
);

CREATE TABLE "SENTRY_ROLE_GROUP_MAP" (
  "ROLE_ID" NUMBER NOT NULL,
  "GROUP_ID" NUMBER NOT NULL,
  "GRANTOR_PRINCIPAL" VARCHAR2(128)
);

CREATE TABLE "SENTRY_VERSION" (
  "VER_ID" NUMBER NOT NULL,
  "SCHEMA_VERSION" VARCHAR(127) NOT NULL,
  "VERSION_COMMENT" VARCHAR(255) NOT NULL
);

ALTER TABLE "SENTRY_DB_PRIVILEGE"
  ADD CONSTRAINT "SENTRY_DB_PRIV_PK" PRIMARY KEY ("DB_PRIVILEGE_ID");

ALTER TABLE "SENTRY_ROLE"
  ADD CONSTRAINT "SENTRY_ROLE_PK" PRIMARY KEY ("ROLE_ID");

ALTER TABLE "SENTRY_GROUP"
  ADD CONSTRAINT "SENTRY_GROUP_PK" PRIMARY KEY ("GROUP_ID");

ALTER TABLE "SENTRY_VERSION" ADD CONSTRAINT "SENTRY_VERSION_PK" PRIMARY KEY ("VER_ID");

ALTER TABLE "SENTRY_DB_PRIVILEGE"
  ADD CONSTRAINT "SENTRY_DB_PRIV_PRIV_NAME_UNIQ" UNIQUE ("SERVER_NAME","DB_NAME","TABLE_NAME","COLUMN_NAME","URI","ACTION","WITH_GRANT_OPTION");

CREATE INDEX "SENTRY_SERV_PRIV_IDX" ON "SENTRY_DB_PRIVILEGE" ("SERVER_NAME");

CREATE INDEX "SENTRY_DB_PRIV_IDX" ON "SENTRY_DB_PRIVILEGE" ("DB_NAME");

CREATE INDEX "SENTRY_TBL_PRIV_IDX" ON "SENTRY_DB_PRIVILEGE" ("TABLE_NAME");

CREATE INDEX "SENTRY_COL_PRIV_IDX" ON "SENTRY_DB_PRIVILEGE" ("COLUMN_NAME");

CREATE INDEX "SENTRY_URI_PRIV_IDX" ON "SENTRY_DB_PRIVILEGE" ("URI");

ALTER TABLE "SENTRY_ROLE"
  ADD CONSTRAINT "SENTRY_ROLE_ROLE_NAME_UNIQUE" UNIQUE ("ROLE_NAME");

ALTER TABLE "SENTRY_GROUP"
  ADD CONSTRAINT "SENTRY_GRP_GRP_NAME_UNIQUE" UNIQUE ("GROUP_NAME");

ALTER TABLE "SENTRY_ROLE_DB_PRIVILEGE_MAP"
  ADD CONSTRAINT "SEN_RLE_PRIV_MAP_PK" PRIMARY KEY ("ROLE_ID","DB_PRIVILEGE_ID");

ALTER TABLE "SENTRY_ROLE_GROUP_MAP"
  ADD CONSTRAINT "SENTRY_ROLE_GROUP_MAP_PK" PRIMARY KEY ("ROLE_ID","GROUP_ID");

ALTER TABLE "SENTRY_ROLE_DB_PRIVILEGE_MAP"
  ADD CONSTRAINT "SEN_RLE_DB_PRV_MAP_SN_RLE_FK"
  FOREIGN KEY ("ROLE_ID") REFERENCES "SENTRY_ROLE"("ROLE_ID") INITIALLY DEFERRED;

ALTER TABLE "SENTRY_ROLE_DB_PRIVILEGE_MAP"
  ADD CONSTRAINT "SEN_RL_DB_PRV_MAP_SN_DB_PRV_FK"
  FOREIGN KEY ("DB_PRIVILEGE_ID") REFERENCES "SENTRY_DB_PRIVILEGE"("DB_PRIVILEGE_ID") INITIALLY DEFERRED;

ALTER TABLE "SENTRY_ROLE_GROUP_MAP"
  ADD CONSTRAINT "SEN_ROLE_GROUP_MAP_SEN_ROLE_FK"
  FOREIGN KEY ("ROLE_ID") REFERENCES "SENTRY_ROLE"("ROLE_ID") INITIALLY DEFERRED;

ALTER TABLE "SENTRY_ROLE_GROUP_MAP"
  ADD CONSTRAINT "SEN_ROLE_GROUP_MAP_SEN_GRP_FK"
  FOREIGN KEY ("GROUP_ID") REFERENCES "SENTRY_GROUP"("GROUP_ID") INITIALLY DEFERRED;

INSERT INTO SENTRY_VERSION (VER_ID, SCHEMA_VERSION, VERSION_COMMENT) VALUES (1, '2.0.0', 'Sentry release version 2.0.0');

-- Generic Model
-- Table SENTRY_GM_PRIVILEGE for classes [org.apache.sentry.provider.db.service.model.MSentryGMPrivilege]
CREATE TABLE "SENTRY_GM_PRIVILEGE" (
  "GM_PRIVILEGE_ID" NUMBER NOT NULL,
  "COMPONENT_NAME" VARCHAR2(32) NOT NULL,
  "SERVICE_NAME" VARCHAR2(64) NOT NULL,
  "RESOURCE_NAME_0" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_NAME_1" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_NAME_2" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_NAME_3" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_TYPE_0" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_TYPE_1" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_TYPE_2" VARCHAR2(64) DEFAULT '__NULL__',
  "RESOURCE_TYPE_3" VARCHAR2(64) DEFAULT '__NULL__',
  "ACTION" VARCHAR2(32) NOT NULL,
  "SCOPE" VARCHAR2(128) NOT NULL,
  "CREATE_TIME" NUMBER NOT NULL,
  "WITH_GRANT_OPTION" CHAR(1) DEFAULT 'N' NOT NULL
);

ALTER TABLE "SENTRY_GM_PRIVILEGE"
  ADD CONSTRAINT "SENTRY_GM_PRIV_PK" PRIMARY KEY ("GM_PRIVILEGE_ID");
-- Constraints for table SENTRY_GM_PRIVILEGE for class(es) [org.apache.sentry.provider.db.service.model.MSentryGMPrivilege]
ALTER TABLE "SENTRY_GM_PRIVILEGE"
  ADD CONSTRAINT "SENTRY_GM_PRIV_PRIV_NAME_UNIQ" UNIQUE ("COMPONENT_NAME","SERVICE_NAME","RESOURCE_NAME_0","RESOURCE_NAME_1","RESOURCE_NAME_2",
  "RESOURCE_NAME_3","RESOURCE_TYPE_0","RESOURCE_TYPE_1","RESOURCE_TYPE_2","RESOURCE_TYPE_3","ACTION","WITH_GRANT_OPTION");

CREATE INDEX "SENTRY_GM_PRIV_COMP_IDX" ON "SENTRY_GM_PRIVILEGE" ("COMPONENT_NAME");

CREATE INDEX "SENTRY_GM_PRIV_SERV_IDX" ON "SENTRY_GM_PRIVILEGE" ("SERVICE_NAME");

CREATE INDEX "SENTRY_GM_PRIV_RES0_IDX" ON "SENTRY_GM_PRIVILEGE" ("RESOURCE_NAME_0","RESOURCE_TYPE_0");

CREATE INDEX "SENTRY_GM_PRIV_RES1_IDX" ON "SENTRY_GM_PRIVILEGE" ("RESOURCE_NAME_1","RESOURCE_TYPE_1");

CREATE INDEX "SENTRY_GM_PRIV_RES2_IDX" ON "SENTRY_GM_PRIVILEGE" ("RESOURCE_NAME_2","RESOURCE_TYPE_2");

CREATE INDEX "SENTRY_GM_PRIV_RES3_IDX" ON "SENTRY_GM_PRIVILEGE" ("RESOURCE_NAME_3","RESOURCE_TYPE_3");

-- Table SENTRY_ROLE_GM_PRIVILEGE_MAP for join relationship
CREATE TABLE "SENTRY_ROLE_GM_PRIVILEGE_MAP" (
  "ROLE_ID" NUMBER NOT NULL,
  "GM_PRIVILEGE_ID" NUMBER NOT NULL
);

ALTER TABLE "SENTRY_ROLE_GM_PRIVILEGE_MAP"
  ADD CONSTRAINT "SEN_RLE_GM_PRIV_MAP_PK" PRIMARY KEY ("ROLE_ID","GM_PRIVILEGE_ID");

-- Constraints for table SENTRY_ROLE_GM_PRIVILEGE_MAP
ALTER TABLE "SENTRY_ROLE_GM_PRIVILEGE_MAP"
  ADD CONSTRAINT "SEN_RLE_GM_PRV_MAP_SN_RLE_FK"
  FOREIGN KEY ("ROLE_ID") REFERENCES "SENTRY_ROLE"("ROLE_ID") INITIALLY DEFERRED;

ALTER TABLE "SENTRY_ROLE_GM_PRIVILEGE_MAP"
  ADD CONSTRAINT "SEN_RL_GM_PRV_MAP_SN_DB_PRV_FK"
  FOREIGN KEY ("GM_PRIVILEGE_ID") REFERENCES "SENTRY_GM_PRIVILEGE"("GM_PRIVILEGE_ID") INITIALLY DEFERRED;

CREATE TABLE "SENTRY_USER" (
  "USER_ID" NUMBER  NOT NULL,
  "USER_NAME" VARCHAR2(128) NOT NULL,
  "CREATE_TIME" NUMBER NOT NULL
);

ALTER TABLE "SENTRY_USER"
  ADD CONSTRAINT "SENTRY_USER_PK" PRIMARY KEY ("USER_ID");

ALTER TABLE "SENTRY_USER"
  ADD CONSTRAINT "SENTRY_USER_USER_NAME_UNIQUE" UNIQUE ("USER_NAME");

CREATE TABLE "SENTRY_ROLE_USER_MAP" (
  "ROLE_ID" NUMBER NOT NULL,
  "USER_ID" NUMBER NOT NULL,
  "GRANTOR_PRINCIPAL" VARCHAR2(128)
);

ALTER TABLE "SENTRY_ROLE_USER_MAP"
  ADD CONSTRAINT "SENTRY_ROLE_USER_MAP_PK" PRIMARY KEY ("ROLE_ID","USER_ID");

ALTER TABLE "SENTRY_ROLE_USER_MAP"
  ADD CONSTRAINT "SEN_ROLE_USER_MAP_SEN_ROLE_FK"
  FOREIGN KEY ("ROLE_ID") REFERENCES "SENTRY_ROLE"("ROLE_ID") INITIALLY DEFERRED;

ALTER TABLE "SENTRY_ROLE_USER_MAP"
  ADD CONSTRAINT "SEN_ROLE_USER_MAP_SEN_USER_FK"
  FOREIGN KEY ("USER_ID") REFERENCES "SENTRY_USER"("USER_ID") INITIALLY DEFERRED;

-- Table AUTHZ_PATHS_SNAPSHOT_ID for class [org.apache.sentry.provider.db.service.model.MAuthzPathsSnapshotId]
CREATE TABLE "AUTHZ_PATHS_SNAPSHOT_ID"
(
    "AUTHZ_SNAPSHOT_ID" NUMBER NOT NULL
);

-- Constraints for table AUTHZ_PATHS_SNAPSHOT_ID for class [org.apache.sentry.provider.db.service.model.MAuthzPathsSnapshotId]
ALTER TABLE "AUTHZ_PATHS_SNAPSHOT_ID" ADD CONSTRAINT "AUTHZ_SNAPSHOT_ID_PK" PRIMARY KEY ("AUTHZ_SNAPSHOT_ID");

-- Table AUTHZ_PATHS_MAPPING for classes [org.apache.sentry.provider.db.service.model.MAuthzPathsMapping]
CREATE TABLE AUTHZ_PATHS_MAPPING
(
    AUTHZ_OBJ_ID NUMBER NOT NULL,
    AUTHZ_OBJ_NAME VARCHAR2(384) NOT NULL,
    CREATE_TIME_MS NUMBER NOT NULL,
    "AUTHZ_SNAPSHOT_ID" NUMBER NOT NULL
);

ALTER TABLE AUTHZ_PATHS_MAPPING ADD CONSTRAINT AUTHZ_PATHS_MAPPING_PK PRIMARY KEY (AUTHZ_OBJ_ID);

-- Constraints for table AUTHZ_PATHS_MAPPING for class(es) [org.apache.sentry.provider.db.service.model.MAuthzPathsMapping]
CREATE INDEX AUTHZ_SNAPSHOT_ID_INDEX ON AUTHZ_PATHS_MAPPING (AUTHZ_SNAPSHOT_ID);

-- Table `AUTHZ_PATH` for classes [org.apache.sentry.provider.db.service.model.MPath]
CREATE TABLE AUTHZ_PATH
 (
    PATH_ID NUMBER NOT NULL,
    PATH_NAME VARCHAR(4000),
    AUTHZ_OBJ_ID NUMBER
);

-- Constraints for table `AUTHZ_PATH`
ALTER TABLE AUTHZ_PATH
  ADD CONSTRAINT AUTHZ_PATH_PK PRIMARY KEY (PATH_ID);

ALTER TABLE AUTHZ_PATH
  ADD CONSTRAINT AUTHZ_PATH_FK
  FOREIGN KEY (AUTHZ_OBJ_ID) REFERENCES AUTHZ_PATHS_MAPPING (AUTHZ_OBJ_ID);


-- Table "SENTRY_PERM_CHANGE" for classes [org.apache.sentry.provider.db.service.model.MSentryPermChange]
CREATE TABLE "SENTRY_PERM_CHANGE"
(
    "CHANGE_ID" NUMBER NOT NULL,
    "CREATE_TIME_MS" NUMBER NOT NULL,
    "PERM_CHANGE" VARCHAR2(4000) NOT NULL
);

ALTER TABLE "SENTRY_PERM_CHANGE" ADD CONSTRAINT "SENTRY_PERM_CHANGE_PK" PRIMARY KEY ("CHANGE_ID");

-- Table "SENTRY_PATH_CHANGE" for classes [org.apache.sentry.provider.db.service.model.MSentryPathChange]
CREATE TABLE "SENTRY_PATH_CHANGE"
(
    "CHANGE_ID" NUMBER NOT NULL,
    "NOTIFICATION_HASH" CHAR(40) NOT NULL,
    "CREATE_TIME_MS" NUMBER NOT NULL,
    "PATH_CHANGE" CLOB NOT NULL
);

-- Constraints for table SENTRY_PATH_CHANGE for class [org.apache.sentry.provider.db.service.model.MSentryPathChange]
CREATE UNIQUE INDEX "NOTIFICATION_HASH_INDEX" ON "SENTRY_PATH_CHANGE" ("NOTIFICATION_HASH");
ALTER TABLE "SENTRY_PATH_CHANGE" ADD CONSTRAINT SENTRY_PATH_CHANGE_PK PRIMARY KEY ("CHANGE_ID");

-- Table SENTRY_HMS_NOTIFICATION_ID for classes [org.apache.sentry.provider.db.service.model.MSentryHmsNotification]
CREATE TABLE "SENTRY_HMS_NOTIFICATION_ID"
(
    "NOTIFICATION_ID" NUMBER NOT NULL
);

CREATE INDEX "SENTRY_HMS_NOTIF_ID_INDEX" ON "SENTRY_HMS_NOTIFICATION_ID" ("NOTIFICATION_ID");