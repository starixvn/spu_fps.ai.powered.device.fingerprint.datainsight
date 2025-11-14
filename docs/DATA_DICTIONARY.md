# Data Dictionary - Device Fingerprint Dataset

## Overview
This document provides detailed descriptions of data structure and field meanings in the Device Fingerprint datasets.

---

## 1. Fingerprint Stability Dataset (`1nFP_Per_Device_*.csv`)

### Purpose
Analyze the stability of fingerprint attributes across devices. The dataset records the number of unique values for each attribute per device.

### Data Structure

#### Core Fields
| Field Name | Data Type | Description |
|------------|-----------|-------------|
| `DeviceCodeID` | String | Unique device identifier |

#### Group-Level Fields (5 groups)
| Field Name | Data Type | Description | Stable Range |
|------------|-----------|-------------|--------------|
| `Hardware_UniqueCount` | Integer | Number of unique values for Hardware group | 1 (stable) |
| `Graphic_UniqueCount` | Integer | Number of unique values for Graphic group | 1 (stable) |
| `Audio_UniqueCount` | Integer | Number of unique values for Audio group | 1 (stable) |
| `Browser_UniqueCount` | Integer | Number of unique values for Browser group | 1 (stable) |
| `Preferences_UniqueCount` | Integer | Number of unique values for Preferences group | 1 (stable) |

**Interpretation:** 
- Value = 1: Attribute is stable (no changes)
- Value > 1: Attribute is unstable (has changes)

#### Individual Attribute Fields (32 attributes)

##### A. Hardware Attributes (6 attributes)
| Field Name | Description | Examples |
|------------|-------------|----------|
| `Hardware_platformUniqueCount` | Operating system platform | Win32, Linux x86_64 |
| `Hardware_cpuClassUniqueCount` | CPU class information | x86, ARM |
| `Hardware_architectureUniqueCount` | CPU architecture | 32, 64 |
| `Hardware_hardwareConcurrencyUniqueCount` | Number of logical CPU cores | 4, 8, 12 |
| `Hardware_oscpuUniqueCount` | OS CPU details | Windows NT 10.0 |
| `Hardware_DeviceMemoryUniqueCount` | RAM capacity (GB) | 4, 8, 16 |

##### B. Graphic Attributes (9 attributes)
| Field Name | Description | Stability |
|------------|-------------|-----------|
| `Graphic_CanvasUniqueCount` | Canvas fingerprint hash | Medium |
| `Graphic_WebGLBasicUniqueCount` | WebGL renderer info | High |
| `Graphic_WebGLExtensionUniqueCount` | WebGL extensions list | Low |
| `Graphic_FontSetUniqueCount` | Installed font set | Medium |
| `Graphic_FontPreferenceUniqueCount` | Font rendering preferences | Low |
| `Graphic_ScreenResolutionUniqueCount` | Screen resolution | Medium |
| `Graphic_ScreenFrameRateUniqueCount` | Screen refresh rate | Medium |
| `Graphic_ColorDepthUniqueCount` | Color depth | High |
| `Graphic_ColorGamutUniqueCount` | Supported color gamut | Medium |

##### C. Audio Attributes (2 attributes)
| Field Name | Description | Stability |
|------------|-------------|-----------|
| `Audio_ContextUniqueCount` | Audio context fingerprint | High |
| `Audio_BaseLatencyUniqueCount` | Audio base latency | Medium |

##### D. Browser Attributes (7 attributes)
| Field Name | Description | Stability |
|------------|-------------|-----------|
| `Browser_NameUniqueCount` | Browser name | High |
| `Browser_OSNameUniqueCount` | Operating system name | High |
| `Browser_UserAgentUniqueCount` | User agent string | Medium |
| `Browser_VendorUniqueCount` | Browser vendor | High |
| `Browser_VendorFlavorUniqueCount` | Browser version/flavor | High |
| `Browser_PluginUniqueCount` | Plugin list | High |
| `Browser_PDFViewerUniqueCount` | PDF viewer enabled | High |

##### E. Preferences Attributes (8 attributes)
| Field Name | Description | Stability |
|------------|-------------|-----------|
| `Pref_LanguageUniqueCount` | Language preferences | Medium |
| `Pref_TimezoneUniqueCount` | Timezone | Medium |
| `Pref_TouchSupportUniqueCount` | Touch screen support | High |
| `Pref_SessionStorageUniqueCount` | Session storage enabled | High |
| `Pref_OpenDatabaseUniqueCount` | OpenDatabase API enabled | High |
| `Pref_LocalStorageUniqueCount` | Local storage enabled | High |
| `Pref_IndexedDBUniqueCount` | IndexedDB enabled | Medium |
| `Pref_CookiesEnabledUniqueCount` | Cookies enabled | High |

#### Metadata Fields
| Field Name | Data Type | Description |
|------------|-----------|-------------|
| `OS_List` | String | List of OS used (comma-separated) |
| `Browser_List` | String | List of browsers used (comma-separated) |

---

## 2. Device Evolution Dataset (`evo_attribute_details_*.csv`)

### Purpose
Track the evolution of fingerprint attributes over time, supporting device matching analysis.

### Data Structure

#### Core Fields
| Field Name | Data Type | Description |
|------------|-----------|-------------|
| `DeviceCodeID` | String | Device identifier |
| `AccountID` | String | User account identifier |

#### Attribute Code Fields (5 groups)
| Field Name | Data Type | Description | Purpose |
|------------|-----------|-------------|---------|
| `HardwareCode` | String (Hash) | Hash code of Hardware attributes | Device matching |
| `GraphicCode` | String (Hash) | Hash code of Graphic attributes | Device matching |
| `AudioCode` | String (Hash) | Hash code of Audio attributes | Device matching |
| `BrowserCode` | String (Hash) | Hash code of Browser attributes | Device matching |
| `PreferencesCode` | String (Hash) | Hash code of Preferences attributes | Device matching |

**Explanation:**
- Each code is a hash of the attribute set in the group
- Used to compare similarity between fingerprints
- Supports device evolution tracking (when attributes change, code will differ)

---

## Data Quality Notes

### Missing Values
- UniqueCount fields: No null values, minimum = 0
- Code fields: May have empty strings if attributes were not collected

### Data Ranges
- **UniqueCount fields**: 0 to several dozen (typically ≤ 10)
- **DeviceCodeID**: Unique identifier, no duplicates
- **AccountID**: May have duplicates (1 user with multiple devices)

### Encoding
- File encoding: UTF-8 or Latin-1
- String encoding: Standard ASCII for codes, UTF-8 for text fields

---

## Naming Conventions

### Version Naming
Dataset files follow pattern: `{prefix}_{date_range}.csv`
- Example: `1nFP_Per_Device_10301102.csv` = Data from 10/30 to 11/02
- Example: `evo_attribute_details_10301102.csv` = Evolution data from 10/30 to 11/02

### Field Naming
- **Group level**: `{GroupName}_UniqueCount`
- **Individual attribute**: `{GroupName}_{AttributeName}UniqueCount`
- **Code fields**: `{GroupName}Code`

---

## Data Relationships

```
1nFP_Per_Device Dataset
├── DeviceCodeID (Primary Key)
├── Group Stability Metrics (5)
├── Individual Attribute Stability (32)
└── Metadata (OS, Browser lists)

evo_attribute_details Dataset
├── DeviceCodeID (Foreign Key)
├── AccountID (Foreign Key)
└── Attribute Codes (5 groups)
```

---

## Usage Examples

### Example 1: Calculate Group Instability
```python
# Instability = Number of devices with UniqueCount > 1 / Total devices
unstable_hardware = (df['Hardware_UniqueCount'] > 1).sum()
total_devices = len(df)
instability_rate = (unstable_hardware / total_devices) * 100
```

### Example 2: Device Matching Score
```python
# Calculate similarity score between 2 fingerprints
weights = {
    'HardwareCode': 15.8,
    'GraphicCode': 36.3,
    'AudioCode': 15.0,
    'BrowserCode': 14.3,
    'PreferencesCode': 18.7
}

score = sum(weight for group, weight in weights.items() 
           if fp1[group] == fp2[group])
```

---

## Version History
- **v1.0.7**: Latest version (10/30 - 11/02)
  - 107,511 devices
  - 32 individual attributes
  - 5 group-level metrics
  - OS and Browser metadata added

---

*Last Updated: November 2024*
