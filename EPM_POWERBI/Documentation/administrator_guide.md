# Oracle EPM Power BI Connector - Administrator Guide

This guide is for the internal champion/developer managing the deployment of the Oracle EPM Power BI Connector.

## 1. Choosing Your Architecture
Review `architecture_overview.md` to decide which engine to embed into your `.pbit` template.
*   **For External/Commercial Distribution:** Use `power_query_engine.m` (The Python Hybrid). It enforces the uncrackable 180-day limitation.
*   **For Internal/Enterprise Distribution:** Use `pure_m_query_engine.m` (The Native Microsoft Engine). It masks user typing with `••••••••` entirely securely using Power BI Data Source Credentials.

## 2. Generating the Golden Template (.pbit)
You must prepare the initial template that you will distribute to your users:
1. Open Power BI Desktop.
2. Follow the steps in `powerbi_template_guide.md` to create the UI Parameters and paste your chosen `M-Query` text.
3. Save the result as `EPM_Connector_Master.pbit`.

## 3. Managing Cryptographic Trial Licenses (Python Route Only)
If you chose the Python Hybrid architecture, your `.pbit` file has a hardcoded, unchangeable countdown clock (180 days from the moment you compile it). 

If a user complains that their dashboard stopped refreshing:

![EPM License Administrator](file:///C:/Users/Sandeep%20Singh/.gemini/antigravity/brain/fa69a55a-a3b5-47d4-861c-4649c6c35ab3/license_admin_gui_1774220028377.png)

1. Open `license_administrator_gui.exe` (Keep this file strictly on your personal machine).
2. Enter the user's name (e.g., "John_Marketing").
3. Set the duration extension (e.g., another `180` days).
4. Click **Generate Cryptographic License**.
5. Copy the Base64 key that appears.
6. Email this exact key to the user.

*(Note: They do not need a new `.pbit` file. They simply paste that key into their existing Power BI `LICENSE_KEY` Parameter).*

## 4. Troubleshooting
**"Connection Error 401"**
The user inputted the wrong EPM credentials. Tell them to double check their URL and Network connectivity.

**"Expression.Error: We cannot convert null to Text"**
This happens if the user leaves a parameter completely blank during `.pbit` setup in older Power BI versions. Ensure they type *something* (even just a space) or tell them to update Power BI Desktop. We have applied `if UserVar = null then ""` fixes internally to mitigate this.
