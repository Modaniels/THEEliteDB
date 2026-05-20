#!/bin/bash

# DATABASE CONNECTION CONFIGURATION

# replace with  your local database credentials
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
    -- ELVIN  DROP YOUR USER INHERITANCE QUERY BELOW
    SELECT 
        u.\`User ID\`, 
        u.Name, 
        u.Email, 
        s.\`Subscription Date\`
    FROM USER u
    INNER JOIN SUBSCRIBER s ON u.\`User ID\` = s.\`User ID\`;
"

# QUERY 2: WEAK ENTITY LOGS (PROJECT + BUG_REPORT)
echo -e "\n${GREEN}[2/5] Compiling Bug Reports Scoped by Project...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    -- ELVIN DROP YOUR WEAK ENTITY BUG REPORT QUERY BELOW
    SELECT 
        p.\`Project ID\`, 
        p.Status AS Project_Status,
        b.\`Bug ID\`, 
        b.Description AS Bug_Description
    FROM PROJECT p
    INNER JOIN BUG_REPORT b ON p.\`Project ID\` = b.\`Project ID\`
    ORDER BY p.\`Project ID\`, b.\`Bug ID\`;
"


# QUERY 3: MANY-TO-MANY INTERACTIONS (DOWNLOAD_RECORD)

echo -e "\n${GREEN}[3/5] Ranking Projects by Total User Downloads...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    -- ELVIN: DROP YOUR MANY-TO-MANY DOWNLOAD COUUNT QUERY BELOW
    SELECT 
        u.Name AS Downloader_Name, 
        p.\`Project ID\` AS Downloaded_Project, 
        d.\`Download Count\`
    FROM DOWNLOAD_RECORD d
    INNER JOIN USER u ON d.\`User ID\` = u.\`User ID\`
    INNER JOIN PROJECT p ON d.\`Project ID\` = p.\`Project ID\`
    ORDER BY d.\`Download Count\` DESC;
"


# QUERY 4: TRANSACTION AUDIT TRAIL (TRANSACTION + UPDATE)
echo -e "\n${GREEN}[4/5] Pulling Transaction Log (Including Initial Uploads)...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    -- ELVIN: DROP YOUR NULLABLE TRANSACTION LEFT JOIN QUERY BELOW
    SELECT 
        t.\`Project ID\`,
        t.\`Transaction ID\`,
        t.\`Transaction Date\`,
        up.Name AS Update_Patch_Name
    FROM TRANSACTION t
    LEFT JOIN UPDATE up ON t.\`Update_ID\` = up.\`Update ID\`
    ORDER BY t.\`Transaction Date\` DESC;
"


# QUERY 5: SELF-REFERENCING DEPENDENCIES (PROJECT_DEPENDENCY)

echo -e "\n${GREEN}[5/5] Mapping Codebase Inter-Dependencies (Self-Join)...${NC}"
mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    -- ELVIN: DROP YOUR PROJECT SELF-JOIN DEPENDENCY QUERY BELOW
    SELECT 
        p1.\`Project ID\` AS Main_Project,
        p2.\`Project ID\` AS Required_Prerequisite_Project
    FROM PROJECT_DEPENDENCY pd
    INNER JOIN PROJECT p1 ON pd.\`Project ID\` = p1.\`Project ID\`
    INNER JOIN PROJECT p2 ON pd.\`Depends_On_Project ID\` = p2.\`Project ID\`;
"

echo -e "\n${BLUE}====================================================${NC}"
echo -e "${BLUE}             ALL QUERIES EXECUTED CLEANLY           ${NC}"
echo -e "${BLUE}====================================================${NC}"