# Oracle EPM Custom Connector - Power BI Template Guide

This guide will walk you through exactly how to embed the Python EPM engine directly into a native Power BI Template (`.pbit`). 

By following these instructions once, you will create a reusable Template file. When your users double-click this file, they will be greeted with native Power BI popups asking for their credentials, application specifics, and their 6-month license key.

## Step 1: Create Power BI Parameters
1. Open a blank **Power BI Desktop** file.
2. Go to **Home** > **Transform Data** (to open the Power Query Editor).
3. In the Home ribbon, click **Manage Parameters** > **New Parameter**.
4. Create the following 9 text parameters *exactly* as spelled below (ensure Type is set to `Text` for all):
   - `EPM_URL` (Current Value: e.g., `https://epm-domain.oraclecloud.com`)
   - `USERNAME` (Current Value: e.g., `demoadmin`)
   - `PASSWORD` (Current Value: your password)
   - `APP_NAME` (Current Value: e.g., `HC_PLAN`)
   - `CUBE_NAME` (Current Value: e.g., `HC_PLN`)
   - `API_VERSION` (Current Value: e.g., `v3`)
   - `LICENSE_KEY` (Current Value: leave blank if within 180 days, or enter a generated base64 key)
   - `POV_DIMENSIONS` (Current Value: e.g., `["Year", "Scenario", "Version"]`)
   - `POV_MEMBERS` (Current Value: e.g., `[["FY25"], ["Actual"], ["FirstPass"]]`)

*(Note: You can add ROWS and COLUMNS as additional parameters if you want the user to change those as well. For this architecture, we have parameterized the POV as the most common dynamic filter).*

## Step 2: Inject the M-Query Engine
1. Still in the Power Query Editor, right-click in the left "Queries" pane and select **New Query** > **Blank Query**.
2. Rename this new query to `EPM_Data_Export`.
3. In the Home ribbon, click **Advanced Editor**.
4. Delete everything inside the Advanced Editor window.
5. Open the `power_query_engine.m` file (located in this same folder) and copy its entire contents.
6. Paste the contents into the Advanced Editor and click **Done**.

### Security Warnings (One-Time Setup)
- Power BI will likely ask you for permission to run a native database query or a Python script.
- Click **Edit Permissions** and choose **Run**.
- If it asks for Credentials, simply select "Anonymous" (because our Python script handles the EPM Basic Auth internally).

## Step 3: Export the Template (.pbit)
1. Click **Close & Apply** to load the data into Power BI.
2. Save your `.pbix` file first.
3. Then, go to **File** > **Export** > **Power BI template**.
4. Add a description (e.g., "Oracle EPM Direct Connector") and save the file as `EPM_Connector_v1.pbit`.

## Distribution
You are done! You can now send `EPM_Connector_v1.pbit` to any user on your team. 

When they double-click it, Power BI will instantly launch a slick popup window demanding the `APP_NAME`, `USERNAME`, `PASSWORD`, and `LICENSE_KEY` before it even opens the canvas! The user never has to see or touch the Python code.

When they hit exactly 180 days out from today, the Python engine will crash their refresh, and they must come to you. You simply run `license_administrator_gui.exe`, enter their name, and give them the text key format string. They paste it into the `LICENSE_KEY` parameter box in Power BI, and the product is unlocked for another 6 months!
