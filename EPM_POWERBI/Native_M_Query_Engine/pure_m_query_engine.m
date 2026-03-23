let
    // 1. Capture Optional User Inputs (Non-Credential)
    UserApp = if APP_NAME = null then "" else APP_NAME,
    UserCube = if CUBE_NAME = null then "" else CUBE_NAME,
    UserAPI = if API_VERSION = null then "" else API_VERSION,
    UserURL = if EPM_URL = null then "" else EPM_URL,
    UserPOVDims = if POV_DIMENSIONS = null then "[]" else POV_DIMENSIONS,
    UserPOVMems = if POV_MEMBERS = null then "[]" else POV_MEMBERS,

    // 2. Build the exact JSON REST Payload for Oracle EPM
    // Note: M-Query constructs JSON manually here to bypass Python.
    UrlStr = UserURL & "/HyperionPlanning/rest/" & UserAPI & "/applications/" & UserApp & "/plantypes/" & UserCube & "/exportdataslice",
    
    // We parse the string Arrays passed in by the user into native M lists for JSON serialization
    POVDimList = Json.Document(UserPOVDims),
    POVMemList = Json.Document(UserPOVMems),
    
    PayloadRecord = [
        exportPlanningData = false,
        gridDefinition = [
            suppressMissingBlocks = true,
            suppressMissingRows = true,
            suppressMissingColumns = true,
            pov = [
                dimensions = POVDimList,
                members = POVMemList
            ],
            rows = { [
                dimensions = {"Account", "Segment", "Venture"},
                members = { {"@IDescendants(A_LossProfAT)"}, {"@IDescendants(TotalSegments)"}, {"@IDescendants(TotalVentures)"} }
            ] },
            columns = { [
                dimensions = {"Period"},
                members = { {"Jan", "Feb", "Mar", "Apr", "May", "Jun"} }
            ] }
        ]
    ],
    
    // 3. Native Power Query API Call
    // NOTE: Because we don't pass Basic Auth headers manually here,
    // Power BI will inherently natively ask the user for "Data Source Credentials"
    // masking their password completely securely!
    JsonResponse = Web.Contents(UrlStr, [
        Headers = [#"Content-Type"="application/json"],
        Content = Json.FromValue(PayloadRecord)
    ]),
    
    // 4. Transform JSON bytes into Table
    Source = Json.Document(JsonResponse),
    
    // Convert the EPM nested arrays into rows
    Rows = Source[rows],
    ToTable = Table.FromList(Rows, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandedRows = Table.ExpandRecordColumn(ToTable, "Column1", {"headers", "data"}, {"headers", "data"}),
    
    // This provides the raw extracted values in M natively without Python.
    // (Additional M steps would pivot 'headers' into row labels and 'data' into columns)
    FinalData = ExpandedRows
in
    FinalData
