#!/bin/bash

# DATABASE CONNECTION CONFIGURATION

# replace with your local database credentials
DB_USER="root"
DB_PASS="your_password_here"
DB_NAME="THEELITEDB"

# Text formatting colors for clear terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${BLUE}          RUNNING SYSTEM DIAGNOSTIC QUERIES         ${NC}"

# QUERY 1: INHERITANCE ANALYSIS (USER + SUBSCRIBER)
echo -e "\n${GREEN}[1/5] Fetching All Registered Subscribers Profile Info...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    SELECT 
        u.user_id, 
        u.name, 
        u.email, 
        s.subscription_date
    FROM USER u
    INNER JOIN SUBSCRIBER s ON u.user_id = s.user_id;
"

# QUERY 2: WEAK ENTITY LOGS (PROJECT + BUG_REPORT)
echo -e "\n${GREEN}[2/5] Compiling Bug Reports Scoped by Project...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    SELECT 
        p.id AS project_id, 
        p.status AS project_status,
        b.bug_id, 
        b.description AS bug_description
    FROM PROJECT p
    INNER JOIN BUG_REPORT b ON p.id = b.project_id
    ORDER BY p.id, b.bug_id;
"

# QUERY 3: MANY-TO-MANY INTERACTIONS (DOWNLOAD_RECORD)
echo -e "\n${GREEN}[3/5] Ranking Projects by Total User Downloads...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    SELECT 
        u.name AS downloader_name, 
        p.id AS downloaded_project, 
        d.download_count
    FROM DOWNLOAD_RECORD d
    INNER JOIN USER u ON d.user_id = u.user_id
    INNER JOIN PROJECT p ON d.project_id = p.id
    ORDER BY d.download_count DESC;
"

# QUERY 4: TRANSACTION AUDIT TRAIL (TRANSACTION + PROJECT_UPDATE)
echo -e "\n${GREEN}[4/5] Pulling Transaction Log (Including Initial Uploads)...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    SELECT 
        t.project_id,
        t.transaction_id,
        t.transaction_date,
        up.name AS update_patch_name
    FROM TRANSACTION t
    LEFT JOIN PROJECT_UPDATE up ON t.update_id = up.update_id
    ORDER BY t.transaction_date DESC;
"

# QUERY 5: SELF-REFERENCING DEPENDENCIES (PROJECT_DEPENDENCY)
echo -e "\n${GREEN}[5/5] Mapping Codebase Inter-Dependencies (Self-Join)...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    SELECT 
        p1.id AS main_project,
        p2.id AS required_prerequisite_project
    FROM PROJECT_DEPENDENCY pd
    INNER JOIN PROJECT p1 ON pd.project_id = p1.id
    INNER JOIN PROJECT p2 ON pd.depends_on_project_id = p2.id;
"

echo -e "\n${BLUE}====================================================${NC}"
echo -e "${BLUE}             ALL QUERIES EXECUTED CLEANLY           ${NC}"
echo -e "${BLUE}====================================================${NC}"