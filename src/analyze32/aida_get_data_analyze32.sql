SELECT 
    t.DeviceCodeID,
    COUNT(DISTINCT HardwareDetails) AS Hardware_UniqueCount,
    COUNT(DISTINCT GraphicDetails) AS Graphic_UniqueCount,
    COUNT(DISTINCT AudioDetails) AS Audio_UniqueCount,
    COUNT(DISTINCT BrowserDetails) AS Browser_UniqueCount,
    COUNT(DISTINCT PreferencesDetails) AS Preferences_UniqueCount
    -- COUNT(DISTINCT HardwareDetails->>'$.plf') AS Hardware_platformUniqueCount,
--     COUNT(DISTINCT HardwareDetails->>'$.ccl') AS Hardware_cpuClassUniqueCount,
--     COUNT(DISTINCT HardwareDetails->>'$.arc') AS Hardware_architectureUniqueCount,
--     COUNT(DISTINCT HardwareDetails->>'$.hwc') AS Hardware_hardwareConcurrencyUniqueCount,
--     COUNT(DISTINCT HardwareDetails->>'$.osc') AS Hardware_oscpuUniqueCount,
--     COUNT(DISTINCT HardwareDetails->>'$.dvm') AS Hardware_DeviceMemoryUniqueCount,

--     COUNT(DISTINCT GraphicDetails->>'$.cnv') AS Graphic_CanvasUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.wgb') AS Graphic_WebGLBasicUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.wgx') AS Graphic_WebGLExtensionUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.fnt') AS Graphic_FontSetUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.fpr') AS Graphic_FontPreferenceUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.scr') AS Graphic_ScreenResolutionUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.sfr') AS Graphic_ScreenFrameRateUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.cld') AS Graphic_ColorDepthUniqueCount,
--     COUNT(DISTINCT GraphicDetails->>'$.clg') AS Graphic_ColorGamutUniqueCount,

--     COUNT(DISTINCT AudioDetails->>'$.aud') AS Audio_ContextUniqueCount,
--     COUNT(DISTINCT AudioDetails->>'$.abl') AS Audio_BaseLatencyUniqueCount,

--     COUNT(DISTINCT BrowserDetails->>'$.brn') AS Browser_NameUniqueCount,
--     COUNT(DISTINCT BrowserDetails->>'$.osn') AS Browser_OSNameUniqueCount,
--     COUNT(DISTINCT BrowserDetails->>'$.uag') AS Browser_UserAgentUniqueCount,
--     COUNT(DISTINCT BrowserDetails->>'$.vdr') AS Browser_VendorUniqueCount,
--     COUNT(DISTINCT BrowserDetails->>'$.vfl') AS Browser_VendorFlavorUniqueCount,
--     COUNT(DISTINCT BrowserDetails->>'$.plg') AS Browser_PluginUniqueCount,
--     COUNT(DISTINCT BrowserDetails->>'$.pve') AS Browser_PDFViewerUniqueCount,

--     COUNT(DISTINCT PreferencesDetails->>'$.lng') AS Pref_LanguageUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.tze') AS Pref_TimezoneUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.tsp') AS Pref_TouchSupportUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.ssg') AS Pref_SessionStorageUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.odb') AS Pref_OpenDatabaseUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.lst') AS Pref_LocalStorageUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.idb') AS Pref_IndexedDBUniqueCount,
--     COUNT(DISTINCT PreferencesDetails->>'$.cke') AS Pref_CookiesEnabledUniqueCount

FROM DCS_DataCenter.Casey_10241102_Tran07Details AS t
LEFT JOIN `Jonathan_FPGroupHardware` AS hw
    ON t.FPGroupHardwareID = hw.FPGroupHardwareID

-- Graphic group
LEFT JOIN `Jonathan_FPGroupGraphic` AS gh
    ON t.FPGroupGraphicID = gh.FPGroupGraphicID

-- Audio group
LEFT JOIN `Jonathan_FPGroupAudio` AS ad
    ON t.FPGroupAudioID = ad.FPGroupAudioID

-- Browser group
LEFT JOIN `Jonathan_FPGroupBrowser` AS br
    ON t.FPGroupBrowserID = br.FPGroupBrowserID

-- Preferences group

LEFT JOIN `Jonathan_FPGroupPreferences` AS pf
    ON t.FPGroupPreferencesID = pf.FPGroupPreferencesID 
WHERE t.CreatedDate >= '2025-11-02'
		AND t.CreatedDate < '2025-11-03'
        AND t.FP02Total > 0
        AND Flagged = 1
		AND FingerprintVersionID = 14
GROUP BY  
    t.DeviceCodeID
ORDER BY  
    t.DeviceCodeID
LIMIT 50000
OFFSET 0;