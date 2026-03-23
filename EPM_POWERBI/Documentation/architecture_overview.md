# Oracle EPM Power BI Connector - Architecture Overview

This document outlines the dual-architecture approach of the EPM Power BI Connector product. We offer two distinct integration routes, allowing administrators to choose the balance between **Rapid Extensibility (Python)** and **Native Security (M-Query)**.

## 1. The Python Template Route (Hybrid Engine)
**File:** `power_query_engine.m` (Python Injected)

This architecture uses Power BI as a frontend to capture User Parameters and dynamically injects them into a highly secure, Base64 obfuscated Python script. Power BI then executes this Python script locally to fetch and transform data.

**Pros:**
* **Cryptographic Trial Licensing:** Because it runs Python, we can implement an uncrackable SHA-256 HMAC cryptographic 180-day trial clock that forces users back to the administrator for a key.
* **Complex Data Transformation:** `pandas` easily flattens severely nested JSON hierarchies that EPM produces.
* **Rapid Updates:** Administrators can regenerate the core engine completely independently.

**Cons:**
* **Credentials:** Power BI Parameters cannot mask "Password" fields, making them visible during the one-time template setup.
* **Dependency:** Requires the end-user to have Python installed on their machine with `pandas` and `requests`.

---

## 2. The Pure M-Query Route (Microsoft Native Engine)
**File:** `pure_m_query_engine.m`

This architecture discards Python entirely. The API payload, authentication, and JSON-to-Table transformations are coded 100% in Microsoft's proprietary `M` language using the `Web.Contents` function.

**Pros:**
* **Native Security Integration:** Bypasses Power BI Parameters for credentials. It securely triggers Microsoft's built-in "Data Source Credentials" popup, perfectly masking passwords as `••••••••` and caching the token deeply in the Windows OS Credential Manager.
* **Zero Dependencies:** Does not require the user to have Python installed. It runs seamlessly on any machine that has Power BI Desktop installed, and refreshes natively in the Power BI Cloud Service without Personal Gateways.

**Cons:**
* **No Local Trial Clock:** pure M-Query lacks the cryptographic libraries required to enforce an offline, uncrackable 180-day trial without complex online licensing servers. 
* **Complex Editing:** `M` language makes adapting to massive EPM hierarchy changes slightly more difficult than `pandas`.

## Conclusion
- Use the **Python Route** if you intend to commercially sell this script and absolutely require the Cryptographic Licensing System.
- Use the **Pure M-Query Route** if you are deploying internally to an enterprise, where native Microsoft Password credential management is the critical priority instead of licensing.
