# SCMPM
Spatial Calibration & Mapping of Particulate Matter (SCMPM) is an open source and efficient calibration and mapping approach based on real-time spatial model that calibrates measurements from low-cost sensor in an environment with high relative humidity. The model provides spatial calibration of low cost PM2.5 sensors using the regulatory air quality monitoring stations.


# Data
1. The "***Low-cost air box***" for low-cost PM 2.5 observations are available at https://pm25.lass-net.org/
2. The "***Automatic Monitoring Instrument***" for PM2.5 established by the Taiwanese Environmental Protection Agency (TWEPA) is available at https://data.epa.gov.tw/en

# Main Steps for Use
**Step 1**: - ***run mainStep1.m*** provides the non-spatial calibration using Linear Regression (LR) & spatial calibration using GWR 

**Step 2**: - ***run mainStep2.m*** Plot GWR or LR result; 1: plot GWR maps; 0: plot LR maps

**Input**: - (1) Data/Newcase/1/airbox.csv; (2) Data/Newcase/1/EPA.csv; (3) Data/TWN_shp/gadm36_TWN_shp  

# Software
All the codes are exclusively written for ***MATLAB*** environment.

# Credit
The main script and data are written & provided by: 

***Geosmart Lab***

Department of Geomatics, National Cheng Kung University, Tainan City, Taiwan (R.O.C)


# Important Reference
To support the use of this code and the data please cite the following publication:

Chu, H. J., Ali, M. Z., & He, Y. C. (2020). Spatial calibration and PM2.5 mapping of low-cost air quality sensors. Scientific reports, 10(1), 1-11. https://doi.org/10.1038/s41598-020-79064-w
