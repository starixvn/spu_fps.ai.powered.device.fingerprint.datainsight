SELECT DISTINCT
	t.AccountID,
    t.DeviceCodeID,
    hw.HardwareCode,
    gh.GraphicCode,
    ad.AudioCode,
    br.BrowserCode,
    pf.PreferencesCode
FROM `DCS_DataCenter`.`Casey_10241102_Tran07Details` AS t
-- Hardware group
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
WHERE t.CreatedDate >= '2025-10-28'
		AND t.CreatedDate < '2025-11-03'
        AND t.FP02Total > 0
        AND Flagged = 1
		AND FingerprintVersionID = 14
        AND hw.HardwareCode IS NOT NULL
ORDER BY     t.DeviceCodeID
LIMIT 5000
OFFSET 0;