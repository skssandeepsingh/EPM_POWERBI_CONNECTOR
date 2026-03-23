# Oracle EPM Power BI Connector - End User Quick Start

Welcome to the Oracle EPM Power BI Connector! This tool allows you to automatically pull your Oracle Cloud EPM slices directly into Power BI instantly seamlessly.

## 1. Setup Your Dashboard
You should have received an `EPM_Connector.pbit` file from your Administrator.

1. **Double-Click** the `EPM_Connector.pbit` file to open it in Power BI Desktop.
2. A native popup window will appear asking for exact parameters:

![Power BI Parameter Prompt](file:///C:/Users/Sandeep%20Singh/.gemini/antigravity/brain/fa69a55a-a3b5-47d4-861c-4649c6c35ab3/pbi_parameter_popup_1774220001368.png)

    *   **APP_NAME:** The target Oracle Planning Application name (e.g., `OEP_FS`).
    *   **CUBE_NAME:** The target plan type (e.g., `OEP_FIN`).
    *   **POV_DIMENSIONS / POV_MEMBERS:** Ask your Admin what slices to pull if you are unsure.
    *   **LICENSE_KEY:** Leave this completely blank unless your Administrator specifically gave you a key.
3. Click **Load**.

## 2. Authenticating (Pure M-Query Version Only)
If your administrator chose the Native Microsoft architecture:
1. Power BI will instantly prompt you with a **"Web Credentials"** or **"Data Source Credentials"** dialog.

![Power BI Basic Data Source Credentials](file:///C:/Users/Sandeep%20Singh/.gemini/antigravity/brain/fa69a55a-a3b5-47d4-861c-4649c6c35ab3/pbi_credentials_ui_1774220014123.png)

2. Select **Basic**.
3. Type in your standard Oracle EPM `Username` and `Password`. (Your typing will be securely masked as `••••••••`).
4. Click **Connect**. 
*(Power BI stores this token deeply in your Windows OS. You will never have to type your password again when refreshing).*

## 3. License Expiration 
If your dashboard suddenly stops refreshing and throws the error: 
`"EPM Connector Trial has expired. Please provide a valid License Key."`

Don't panic! Your 6-month product trial has simply ended. 
1. Contact your Administrator and request a License Extension.
2. They will give you a long string of text (e.g., `MjAyNi0wOS0yMnxKd...`).
3. In Power BI, go to **Home -> Transform Data -> Edit Parameters**.
4. Paste the key verbatim into the `LICENSE_KEY` box and hit **Apply Changes**. Your dashboard will instantly unlock!
