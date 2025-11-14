# Dataset Overview - Device Fingerprint Analysis

## Executive Summary
This document provides a comprehensive overview of datasets used in the Device Fingerprint Analysis project, including data sources, scale, purposes, and key statistics.

---

## 1. Dataset Inventory

### Available Datasets

| Dataset Name | Period | Records | Devices | Purpose |
|--------------|--------|---------|---------|---------|
| `1nFP_Per_Device_v14.csv` | v14 | - | - | Baseline stability analysis |
| `1nFP_Per_Device_10271029.csv` | 10/27-10/29 | - | - | Short-term stability |
| `1nFP_Per_Device_1024_1102.csv` | 10/24-11/02 | - | - | Extended period analysis |
| `1nFP_Per_Device_10301102.csv` | 10/30-11/02 | **112,884 FPs** | **107,511 devices** | Latest stability analysis |
| `evo_attribute_details_10241026.csv` | 10/24-10/26 | - | - | Evolution tracking |
| `evo_attribute_details_10241102.csv` | 10/24-11/02 | - | - | Extended evolution |
| `evo_attribute_details_10271029.csv` | 10/27-10/29 | - | - | Short-term evolution |
| `evo_attribute_details_10301102.csv` | 10/30-11/02 | **112,884 FPs** | - | Latest evolution data |

**Current Version:** v1.0.7 (10/30 - 11/02)

---

## 2. Dataset Types

### Type A: Stability Analysis Dataset (`1nFP_Per_Device_*.csv`)

**Purpose:** Evaluate the stability of fingerprint attributes

**Structure:**
- 1 row = 1 device
- Columns: DeviceCodeID + 5 groups + 32 individual attributes + metadata
- Data: Unique count of each attribute per device

**Key Metrics:**
- **Instability Rate**: % of devices with attribute changes (UniqueCount > 1)
- **Stability Score**: 100% - Instability Rate
- **Group Stability**: Aggregated from individual attributes

**Use Cases:**
1. Analyze which attributes are most stable
2. Identify suitable attributes for device identification
3. Assess impact of anti-fingerprinting measures
4. Calculate weights for device matching

### Type B: Device Evolution Dataset (`evo_attribute_details_*.csv`)

**Purpose:** Track device fingerprint changes over time

**Structure:**
- 1 row = 1 fingerprint snapshot
- Columns: DeviceCodeID + AccountID + 5 attribute codes
- Data: Hash codes of attribute groups

**Key Metrics:**
- **Match Rate**: % of fingerprints matching by threshold
- **Similarity Score**: Weighted sum of matching codes
- **Evolution Tracking**: Code changes over time

**Use Cases:**
1. Device matching/identification
2. Tracking device changes over time
3. Testing thresholds for "same device" decisions
4. Account-device relationship analysis

---

## 3. Data Statistics (v1.0.7)

### Overall Statistics

```
Total Fingerprints:       112,884
Total Devices:            107,511  
Total Accounts:           3,644 (in test subset)
Average FPs per Device:   ~1.05
Date Range:               10/30/2024 - 11/02/2024
```

### Group-Level Instability Rates

| Group | Instability Rate | Unstable Devices | Rank |
|-------|-----------------|------------------|------|
| **Hardware** | 0.08% | 82 | 🥇 Most Stable |
| **Preferences** | 0.48% | 514 | 🥈 |
| **Audio** | 0.84% | 901 | 🥉 |
| **Browser** | 1.12% | 1,208 | 4th |
| **Graphic** | 2.04% | 2,191 | ⚠️ Least Stable |

**Average Group Instability:** 0.9%

### Top 10 Most Unstable Individual Attributes

| Rank | Attribute | Category | Instability Rate | Unstable Devices |
|------|-----------|----------|-----------------|------------------|
| 1 | `Browser_userAgent` | Browser | 2.12% | 1,059 |
| 2 | `Graphic_webglExtensions` | Graphic | 1.95% | 974 |
| 3 | `Audio_audioBaseLatency` | Audio | 1.50% | 750 |
| 4 | `Graphic_fontPreferences` | Graphic | 0.83% | 414 |
| 5 | `Graphic_screenFrame` | Graphic | 0.56% | 280 |
| 6 | `Graphic_colorGamut` | Graphic | 0.45% | 225 |
| 7 | `Preferences_timezone` | Preferences | 0.42% | 208 |
| 8 | `Graphic_screenResolution` | Graphic | 0.44% | 218 |
| 9 | `Preferences_indexedDB` | Preferences | 0.30% | 148 |
| 10 | `Graphic_canvas` | Graphic | 0.27% | 134 |

### Stability Classification Distribution

| Classification | Range | Attributes | Percentage |
|----------------|-------|------------|------------|
| 🟢 Highly Stable | < 2% | 31 | 96.9% |
| 🟡 Moderately Stable | 2-10% | 1 | 3.1% |
| 🟠 Unstable | 10-30% | 0 | 0% |
| 🔴 Highly Unstable | > 30% | 0 | 0% |

---

## 4. OS-Browser Distribution

### Top OS Platforms
1. **Android** - Mobile dominant platform
2. **iOS** - Second mobile platform
3. **Windows** - Desktop dominant
4. **Mac OS X** - Desktop secondary

### Top Browsers
1. **Chrome Mobile** - Mobile dominant
2. **Mobile Safari** - iOS dominant  
3. **Chrome** - Desktop dominant
4. **Firefox** - Desktop alternative
5. **Edge** - Windows default

### Top OS-Browser Combinations (by occurrences)
1. Android + Chrome Mobile: 1,256 occurrences
2. iOS + Mobile Safari: 1,150 occurrences
3. Windows + Chrome: 700 occurrences
4. iOS + Chrome Mobile iOS: 289 occurrences
5. Windows + Firefox: 169 occurrences

---

## 5. Device Matching Configuration

### Current Production Weights (Multiplicative Approach)

Based on geometric mean of Stability × Device Identifier:

| Group | Weight | Purpose |
|-------|--------|---------|
| **GraphicCode** | 36.3 | Highest identifier despite instability |
| **PreferencesCode** | 18.7 | Balanced stability-identifier |
| **HardwareCode** | 15.8 | Highly stable baseline |
| **AudioCode** | 15.0 | Moderate contribution |
| **BrowserCode** | 14.3 | Stable but low uniqueness |
| **TOTAL** | 100.0 | |

### Matching Thresholds

| Threshold Type | Score | Use Case |
|----------------|-------|----------|
| **Recommended** ⭐ | 61.8 | Production use - balanced |
| **Strict** | 62.8 | High precision needed |
| **Moderate** | 74.8 | Conservative matching |

### Threshold Testing Results

Performance metrics for Recommended Threshold (61.8):

```
Precision:      96.27%
Recall:         92.98%
F1-Score:       0.9459
Accuracy:       94.40%
False Positive: 4.02%
False Negative: 7.02%
```

---

## 6. Data Quality Assessment

### Completeness
✅ **Excellent** - No missing DeviceCodeID  
✅ **Good** - Minimal missing attribute codes  
⚠️ **Acceptable** - Some empty OS/Browser in older records

### Consistency
✅ **Consistent** - UniqueCount values logical (0 to ~10)  
✅ **Validated** - Code hashes follow expected pattern  
✅ **Verified** - Cross-validation between datasets

### Accuracy
✅ **High confidence** - Automated collection  
✅ **Validated** - Statistical checks passed  
⚠️ **Known issues** - Some anti-fingerprinting interference

---

## 7. Analysis Workflows

### Workflow 1: Stability Analysis
**Input:** `1nFP_Per_Device_10301102.csv`  
**Notebook:** `2n_v14_FP_Per_Device_Stability_Analysis.ipynb`  
**Output:** 
- Group instability rates
- Individual attribute stability rankings
- Visualization charts
- Category-based analysis

### Workflow 2: Weight Calculation
**Input:** `evo_attribute_details_10301102.csv`  
**Notebook:** `Group_Correlation_Analysis.ipynb`  
**Output:**
- Production weights (base 100)
- Optimal thresholds
- Config files (JSON/CSV)

### Workflow 3: Threshold Testing
**Input:** `evo_attribute_details_test_account.csv`  
**Notebook:** `Test_Device_Evolution_Thresholds.ipynb`  
**Output:**
- Performance metrics by threshold
- Confusion matrices
- Best threshold recommendation

---

## 8. Data Collection Notes

### Collection Frequency
- Continuous collection from production environment
- Aggregation periods: typically 3-10 days
- Latest snapshot: every 3-4 days

### Data Sources
- **Web SDK**: Browser-based fingerprint collection
- **Mobile SDK**: iOS/Android native collection
- **Server-side**: Device matching and tracking

### Privacy Considerations
- No PII (Personally Identifiable Information)
- Anonymized DeviceCodeID
- Hash-based attribute storage
- Compliant with privacy regulations

---

## 9. Known Limitations

### Browser Anti-Fingerprinting
- **Brave Browser**: Randomizes canvas, WebGL
- **Firefox**: Privacy settings affect attributes
- **Safari ITP**: Limits some APIs

**Impact:** Increased instability in Graphic attributes

### Mobile Specifics
- iOS: Restricted hardware access
- Android: Fragmentation affects consistency
- WebView: Different behavior than browsers

### Time-based Changes
- OS updates → Hardware attributes change
- Browser updates → Browser attributes change
- User settings → Preferences change

---

## 10. Future Improvements

### Data Collection
- [ ] Increase collection frequency
- [ ] Add device type classification
- [ ] Track browser version changes
- [ ] Capture timezone changes

### Analysis
- [ ] Longitudinal stability analysis (> 30 days)
- [ ] Cross-platform comparison
- [ ] Anti-fingerprinting detection
- [ ] Real-time monitoring dashboard

### Quality
- [ ] Automated data validation pipeline
- [ ] Anomaly detection system
- [ ] Data versioning system
- [ ] Comprehensive data lineage

---

## 11. Contact & Support

### Questions About Data
- **Structure/Schema**: Refer to `DATA_DICTIONARY.md`
- **Analysis Methods**: Check notebook comments
- **Data Issues**: Contact data team

### Requesting New Data
Please specify:
1. Date range needed
2. Specific attributes required
3. Aggregation level (device/account/fingerprint)
4. Use case description

---

*Last Updated: November 14, 2024*  
*Dataset Version: v1.0.7*  
*Documentation Version: 1.0*
