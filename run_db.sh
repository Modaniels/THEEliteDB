#!/bin/bash

# DATABASE CONNECTION CONFIGURATION

# replace with your local database credentials
DB_USER="postgres" 
DB_PASS=" "
DB_NAME="THEELITEDB"


export PGPASSWORD="$DB_PASS"

# Text formatting colors for clear terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 


echo -e "${BLUE}          RUNNING SYSTEM DIAGNOSTIC QUERIES (POSTGRESQL)         ${NC}"


# READ (SELECT) QUERIES


echo -e "\n${GREEN}[1/7] Fetching All Registered Subscribers Profile Info...${NC}"
psql -U "$DB_USER" -d "$DB_NAME" -c "
    SELECT 
        u.id AS user_id, 
        u.name, 
        u.email, 
        s.subscription_date
    FROM \"USER\" u
    INNER JOIN SUBSCRIBER s ON u.id = s.user_id;
"

echo -e "\n${GREEN}[2/7] Compiling Bug Reports Scoped by Project...${NC}"
psql -U "$DB_USER" -d "$DB_NAME" -c "
    SELECT 
        p.id AS project_id, 
        p.status AS project_status,
        b.bug_id, 
        b.description AS bug_description
    FROM PROJECT p
    INNER JOIN BUG_REPORT b ON p.id = b.project_id
    ORDER BY p.id, b.bug_id;
"

echo -e "\n${GREEN}[3/7] Ranking Projects by Total User Downloads...${NC}"
psql -U "$DB_USER" -d "$DB_NAME" -c "
    SELECT 
        u.name AS downloader_name, 
        p.id AS downloaded_project, 
        d.download_count
    FROM DOWNLOAD_RECORD d
    INNER JOIN \"USER\" u ON d.user_id = u.id
    INNER JOIN PROJECT p ON d.project_id = p.id
    ORDER BY d.download_count DESC;
"

echo -e "\n${GREEN}[4/7] Pulling Transaction Log (Including Initial Uploads)...${NC}"
psql -U "$DB_USER" -d "$DB_NAME" -c "
    SELECT 
        t.project_id,
        t.transaction_id,
        t.transaction_date,
        up.name AS update_patch_name
    FROM TRANSACTION t
    LEFT JOIN PROJECT_UPDATE up ON t.update_id = up.update_id
    ORDER BY t.transaction_date DESC;
"

echo -e "\n${GREEN}[5/7] Mapping Codebase Inter-Dependencies (Self-Join)...${NC}"
psql -U "$DB_USER" -d "$DB_NAME" -c "
    SELECT 
        p1.id AS main_project,
        p2.id AS required_prerequisite_project
    FROM PROJECT_DEPENDENCY pd
    INNER JOIN PROJECT p1 ON pd.project_id = p1.id
    INNER JOIN PROJECT p2 ON pd.depends_on_project_id = p2.id;
"

# ==========================================
# CREATE, UPDATE, DELETE (CUD) QUERIES
# ==========================================

echo -e "\n${GREEN}[6/7] Performing UPDATE Operations...${NC}"
psql -U "$DB_USER" -d "$DB_NAME" -c "
    -- Update a specific User's Name
    UPDATE \"USER\" 
    SET name = 'JR' 
    WHERE id = 1;

    -- Promoting a project's status
    UPDATE PROJECT 
    SET status = 'Completed' 
    WHERE id = 2;
    
    SELECT id, name FROM \"USER\" WHERE id = 1;
    SELECT id, status FROM PROJECT WHERE id = 2;
"

echo -e "\n${GREEN}[7/7] Performing DELETE Operations...${NC}"
# Deleting an existing seeded record (Archived project id = 9)
psql -U "$DB_USER" -d "$DB_NAME" -c "
    -- Delete the archived migration script project
    DELETE FROM PROJECT 
    WHERE id = 9;
    
    -- Verify Deletion
    SELECT id, status FROM PROJECT WHERE id = 9;
"

echo -e "\n${BLUE}====================================================${NC}"
echo -e "${BLUE}             ALL QUERIES EXECUTED CLEANLY           ${NC}"
echo -e "${BLUE}====================================================${NC}"