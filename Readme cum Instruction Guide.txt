Title of the Manuscript:
QUANTIFICATION OF THE RESOLUTION OF DISPERSION IMAGE IN ACTIVE MASW SURVEY AND AUTOMATED EXTRACTION OF DISPERSION CURVE

Authors:
Jumrik Taipodia, Arindam Dey, Sibaji Gaj, Dipjyoti Baglari


Associated Program Codes

There are two MATLAB codes associated with this manuscript:

1. DISPBANDJASD.m - This code automatically identifies the dispersion band from a given dispersion image, and counts the numbers of pixels present in the dispersion band, thereby providing the resolution of the dispersion band.

2. DISPEXJASD.m - This code automatically extracts the accurate dispersion curve from the dispersion image space, based on locally concentrated highest energy signatures.

In order to apply both these codes in practice, the dispersion image obtained by any MASW processing software (e.g. Surfseis, Parkseis, Geopsy, EASYMASW etc.) needs to be provided as an input to these codes, in the form of a .JPS file. A sample file is provided along wih (Sample_Disp_File.JPG). The filename needs to be read into the codes, as indicated in the appropriate place. 

Further, in the code DISPEXJASD.m, the maximum frequency is to be fed in the variable 'omega'. The maximum frequency should be the same as that indicated in the actual Dispersion image file (Actual_Disp_File.JPG). The image to be used as an input to the codes should be a cropped form of the actual dispersion image file, as shown in Sample_Disp_Image.JPG file