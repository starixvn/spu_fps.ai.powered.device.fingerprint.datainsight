# Device Fingerprint Attributes Instruction Guide

## Overview

This document provides comprehensive instructions for understanding and working with device fingerprint attributes. The fingerprint system consists of **32 core attributes** organized into **4 main groups**, plus additional metadata attributes.

## Core Architecture

### FP01 vs FP02 Structure

- **FP01**: Represents the **4 main groups** that constitute the primary fingerprint:
  - Hardware
  - Audio
  - Browser
  - Preferences

- **FP02**: Contains the **32 individual attributes** that make up the FP01 groups, providing granular fingerprint data

## The 4 Main Groups (FP01)

### Group A - Hardware
**Stability**: Almost Impossible to Change
**Purpose**: Core hardware characteristics that rarely change

| Attribute | Alias | Description | Special Values |
|-----------|-------|-------------|----------------|
| platform | plf | Operating system platform | UNDEFINED = -1, ERROR = -3 |
| cpuClass | ccl | CPU class information | UNDEFINED = -1, ERROR = -3 |
| architecture | arc | System architecture | ERROR = -3 |
| oscpu | osc | OS CPU information | UNDEFINED = -1, ERROR = -3 |
| hardwareConcurrency | hwc | Number of CPU cores | UNDEFINED = -1, ANTI_FINGERPRINTED = -2, ERROR = -3, TIMEOUT = -4 |
| deviceMemory | dvm | Device memory information | UNDEFINED = -1, ANTI_FINGERPRINTED = -2, ERROR = -3, TIMEOUT = -4 |
| canvas | cnv | Canvas fingerprinting data | ANTI_FINGERPRINTED = -2, ERROR = -3, TIMEOUT = -4 |
| webglBasics | wgb | WebGL basic information | UNDEFINED = -1, ERROR = -3 |
| webglExtensions | wgx | WebGL extensions hash | UNDEFINED = -1, ERROR = -3 |
| fonts | fnt | Available system fonts | ERROR = -3 |
| fontPreferences | fpr | Font rendering preferences | ERROR = -3 |
| screenResolution | scr | Screen resolution | UNDEFINED = -1 |
| screenFrame | sfr | Screen frame dimensions | UNDEFINED = -1 |
| colorDepthclg | cld | Color depth | UNDEFINED = -1, ERROR = -3 |
| colorGamut | clg | Color gamut support | UNDEFINED = -1, ERROR = -3 |

**Example FP01 Hardware Group**:
```json
{
  "plf": "Win32",
  "ccl": -1,
  "arc": 255,
  "osc": -1,
  "hwc": 20,
  "dvm": 8,
  "cnv": ["d94f8b4dd25c54593ff4fdf2bd8a7d87", 0],
  "wgb": ["WebGL 1.0 (OpenGL ES 2.0 Chromium)", "WebKit", "Google Inc. (Intel)", "WebKit WebGL", "ANGLE (Intel, Intel(R) UHD Graphics 770 (0x00004680) Direct3D11 vs_5_0 ps_5_0, D3D11)", "WebGL GLSL ES 1.0 (OpenGL ES GLSL ES 1.0 Chromium)"],
  "wgx": "dcd475d39d7bd77a3bc2b4c1fdbd3ebb",
  "fnt": ["Calibri", "Franklin Gothic", "MS UI Gothic", "Marlett", "Segoe UI Light"],
  "fpr": {"default": 149.3125, "apple": 149.3125, "serif": 149.3125, "sans": 144.015625, "mono": 121.515625, "min": 9.34375, "system": 147.859375},
  "scr": [1920, 1080],
  "sfr": [0, 0, 50, 0],
  "cld": 24,
  "clg": "srgb"
}
```

### Group B - Audio
**Stability**: Hard to Change
**Purpose**: Audio system characteristics and capabilities

| Attribute | Alias | Description | Special Values |
|-----------|-------|-------------|----------------|
| audio | aud | Audio fingerprinting data | UNDEFINED = -1, ANTI_FINGERPRINTED = -2, ERROR = -3, TIMEOUT = -4 |
| audioBaseLatency | abl | Audio base latency | UNDEFINED = -1, ERROR = -3, DISABLED = -5, NOT_FINITE = -6 |

**Example FP01 Audio Group**:
```json
{
  "aud": 272.1373456071087,
  "abl": -5
}
```

### Group C - Browser
**Stability**: Mixed (Hard to Easy to Change)
**Purpose**: Browser identification and capabilities

| Attribute | Alias | Description | Special Values |
|-----------|-------|-------------|----------------|
| browserName | brn | Browser name | UNDEFINED = -1, ERROR = -3 |
| osName | osn | Operating system name | UNDEFINED = -1, ERROR = -3 |
| userAgent | uag | User agent string | UNDEFINED = -1, ERROR = -3 |
| vendor | vdr | Browser vendor | UNDEFINED = -1, ERROR = -3 |
| vendorFlavors | vfl | Vendor flavor information | ERROR = -3 |
| plugins | plg | Installed plugins | UNDEFINED = -1, ERROR = -3 |
| pdfViewerEnabled | pve | PDF viewer status | UNDEFINED = -1, ERROR = -3 |

**Example FP01 Browser Group**:
```json
{
  "brn": "Chrome",
  "osn": "Windows",
  "uag": "Chromium/141 Google Chrome/141|Windows|0",
  "vdr": "Google Inc.",
  "vfl": ["chrome"],
  "plg": ["PDF Viewer", "Chrome PDF Viewer", "Chromium PDF Viewer", "Microsoft Edge PDF Viewer", "WebKit built-in PDF"],
  "pve": 1
}
```

### Group D - Preferences
**Stability**: Easy to Change
**Purpose**: User preferences and browser settings

| Attribute | Alias | Description | Special Values |
|-----------|-------|-------------|----------------|
| languages | lng | Preferred languages | ERROR = -3 |
| timezone | tze | Timezone information | ERROR = -3 |
| touchSupport | tsp | Touch support capabilities | ERROR = -3 |
| sessionStorage | ssg | Session storage support | UNDEFINED = -1, ERROR = -3 |
| openDatabase | odb | Open database support | UNDEFINED = -1, ERROR = -3 |
| localStorage | lst | Local storage support | UNDEFINED = -1, ERROR = -3 |
| indexedDB | idb | IndexedDB support | UNDEFINED = -1, ERROR = -3 |
| cookiesEnabled | cke | Cookie support status | UNDEFINED = -1, ERROR = -3 |

**Example FP01 Preferences Group**:
```json
{
  "lng": [["en-US"]],
  "tze": "Asia/Bangkok",
  "tsp": [0, 0, 0],
  "ssg": 1,
  "odb": 0,
  "lst": 1,
  "idb": 1,
  "cke": 1
}
```

## Additional Attributes

### IP (WebRTC)
**Purpose**: Network identification
- **rtc**: WebRTC IP address information
- **Example**: `"rtc": ";119.82.130.208"`

## Stability Classifications

### Almost Impossible to Change
- **Hardware Group**: Core system characteristics, graphics capabilities, and display properties that require hardware changes
- **Impact**: Highest fingerprinting reliability
- **Use Case**: Primary device identification

### Hard to Change  
- **Audio Group**: Audio system characteristics
- **Browser Group**: Core browser identification
- **Impact**: High fingerprinting reliability
- **Use Case**: Secondary device identification

### Easy to Change
- **Preferences Group**: User-configurable settings
- **Browser Group**: Some browser settings
- **Impact**: Lower fingerprinting reliability
- **Use Case**: Session tracking, user behavior analysis

## Special Value Codes

| Code | Meaning | Description |
|------|---------|-------------|
| -1 | UNDEFINED | Value could not be determined |
| -2 | ANTI_FINGERPRINTED | Anti-fingerprinting measures detected |
| -3 | ERROR | Error occurred during collection |
| -4 | TIMEOUT | Collection timed out |
| -5 | DISABLED | Feature is disabled |
| -6 | NOT_FINITE | Value is not finite |

## Implementation Guidelines

### For AI Systems

1. **Group Prioritization**: Always prioritize Hardware group for core identification (includes graphics and display capabilities)
2. **Stability Weighting**: Weight attributes by stability class when calculating fingerprint similarity
3. **Error Handling**: Properly handle special value codes (-1 to -6)
4. **Change Detection**: Monitor Easy to Change attributes for session tracking
5. **Anti-Fingerprinting**: Detect and handle anti-fingerprinting measures (code -2)

### Data Processing

1. **Validation**: Check for special values before processing
2. **Normalization**: Handle different data types (strings, arrays, objects, numbers)
3. **Hashing**: Use consistent hashing for complex data structures
4. **Comparison**: Implement appropriate comparison logic for each attribute type

### Fingerprint Generation

1. **FP01**: Combine all 4 groups into a single fingerprint
2. **FP02**: Use individual attributes for detailed analysis
3. **Versioning**: Track fingerprint version changes
4. **Persistence**: Store fingerprints with timestamps for stability analysis

## Use Cases

### Device Identification
- Use Hardware group for primary identification (includes core hardware + graphics capabilities)
- Cross-reference with Audio and Browser groups for verification

### Session Tracking
- Monitor Preferences group changes
- Track Browser group modifications

### Security Analysis
- Detect anti-fingerprinting attempts
- Monitor unusual attribute changes
- Identify potential device spoofing

### Analytics
- Analyze device distribution across groups
- Track stability patterns over time
- Identify common attribute combinations

## Best Practices

1. **Privacy Compliance**: Ensure compliance with privacy regulations
2. **Data Security**: Encrypt sensitive fingerprint data
3. **Regular Updates**: Keep attribute definitions current
4. **Testing**: Regularly test fingerprint collection accuracy
5. **Documentation**: Maintain detailed documentation of changes

This instruction guide provides the foundation for implementing robust device fingerprinting systems using the 32 attributes across 5 main groups.
