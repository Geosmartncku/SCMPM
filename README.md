# SCMPM2.5
Spatial Calibration & Mapping of PM2.5 is an open source and efficient calibration and mapping approach based on real-time spatial model for calibration of low-cost sensor measurements in an environment with high relative humidity. The model provides spatial calibration of low cost PM 2.5 sensors using the regulatory air quality monitoring stations.

# Data
1. The "***Low-cost air box***" for low-cost PM 2.5 observations are available at https://pm25.lass-net.org/
2. The "***Automatic Monitoring Instrument***" for PM2.5 established by the Taiwanese Environmental Protection Agency (TWEPA) is available at https ://opend ata.epa.gov.tw/Data/Conte nts/ATM00 625/

# Main Steps for Use
**Step 1**: - ***run mainStep1.m***
  nonSpatial calibration using LR 
   Spatial calibration using GWR 

Step 2. run mainStep2.m

Plot GWR or LR result
  1: plot GWR maps
  0: plot LR maps

Input: 
(1) airbox.csv
https://pm25.lass-net.org/
(2) EPA.csv 

(3) gadm36_TWN_shp  
