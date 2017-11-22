-- Table AUTHZ_PATHS_MAPPING for classes [org.apache.sentry.provider.db.service.model.MAuthzPathsMapping]
CREATE TABLE AUTHZ_PATHS_MAPPING
(
    AUTHZ_OBJ_ID NUMBER NOT NULL,
    AUTHZ_OBJ_NAME VARCHAR2(384) NOT NULL,
    CREATE_TIME_MS NUMBER NOT NULL,
    AUTHZ_SNAPSHOT_ID NUMBER NOT NULL
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
------------------------------------------------------------------
-- Sequences and SequenceTables