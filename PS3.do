*______________________________________________________________________
*Data Management in Stata
*Kate Cruz, Fall 2017
*Problem Set 3 due: October 24th  
*Stata Version 15/IC

/*Building upon previous assignements, I will merge 4 additional datasets to the exisiting data listed below. It is my hope to add more of the environmental data to this dataset.
I have a great amount of data about education, family type, poverty, and health but not much detail about environmental variables like pollution or hunger. 
For this reason I chose to add data about the release of toxins into the environment, measures of pollution and the use of food stamps as well as population counts for multiple years.

Exisiting Data:
1- NJ County Health Rankings Data (http://www.countyhealthrankings.org/rankings/data/nj)
2- New Jersey Behavioral Risk Factor Survey http://nj.gov/health/shad 
3- U.S. Census Bureau, 2016 American Community Survey 

New Data: 
4- The first new dataset is from the Center for Disease Control and Prevention and is a list of the number of toxic releases by County in 2007:this could be interesting to look for counties with more toxic releases and health data.  
Centers for Disease Control and Prevention. Environmental Public Health Tracking Network. Acute Toxic Substance Releases. Accessed From Environmental Public Health Tracking Network: www.cdc.gov/ephtracking. Accessed on 10/14/2017
note: I would love to have data from 2015 since most of my other datasets are from this year but this was the most recent I could find. This would be good to research further. 
5- The second new data set is from the EPA and it shows pollution levels by County for 2015- I will need to analyze this data further to understand what levels are safe/unsafe but it will be great for comparison 
https://www.epa.gov/outdoor-air-quality-data/air-quality-statistics-report
6- The third dataset is from the Food Access and Research Center (FARC) and it is County SNAP (food stamp) usage from 2011-2015 and simply shows the use of the Supplemental Nutrition Assistance Program. 
7- The fourth dataset is from the US Census Bureau and it contains population counts by County for 2010-2016 https://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?src=bkmk
*/ 


/*_________________________________________________________________________

                  STEP 1: SETTING THE STAGE FROM PROBLEM SET 2
___________________________________________________________________________*/ 

local worDir "C:\Users\kathr\Desktop\combinereshape"
 
capture mkdir ps3 
cd ps3 

use "https://docs.google.com/uc?id=0B1opnkI-LLCiVVdTS3hDX0ZsUUE&export=download", clear //I saved my completed dataset from PS2 on my google drive and made public so that I did not have to run the problem set again here. I tried the use do file command but did not work.
clear 

/*__________________________________________________________________

                   STEP 2: Preparing the new datasets 
__________________________________________________________________*/ 

//Toxic Release Data
import excel "https://docs.google.com/uc?id=0B1opnkI-LLCianducmRLbl84dzQ&export=download", clear firstrow 
drop stateFIPS State countyFIPS Year Stability 
generate region=0
 //region==0 means north 
 //region==1 means south 
replace region=1 if County=="Burlington" | County=="Camden" | County=="Gloucester" | County=="Salem" | County=="Cumberland" | County=="Atlantic" | County=="Cape May" 
 //region==2 means central
replace region=2 if County=="Hunterdon" | County=="Somerset" | County=="Middlesex" | County=="Monmouth" | County=="Ocean" | County=="Mercer" 
move region County 
save kate_ps3toxic, replace 

//EPA air pollution Data
import excel "https://docs.google.com/uc?id=0B1opnkI-LLCic1lHUUxUZHhvZGs&export=download", clear firstrow 
drop CountyCode 
//Dr. Adam gave the code to generate a new variable to lessen the error but I wasn't sure if I could create a new variable such as mycounty and still use it for merging on "County" 
replace County = "Atlantic" in 1
replace County = "Bergen" in 2 
replace County = "Camden" in 3
replace County = "Cumberland" in 4
replace County = "Essex" in 5
replace County = "Gloucester" in 6
replace County = "Hudson" in 7
replace County = "Hunterdon" in 8
replace County = "Mercer" in 9
replace County = "Middlesex" in 10
replace County = "Monmouth" in 11
replace County = "Morris" in 12
replace County = "Ocean" in 13
replace County = "Passaic" in 14
replace County = "Union" in 15
replace County = "Warren" in 16

generate region=0
 //region==0 means north 
 //region==1 means south 
replace region=1 if County=="Camden" | County=="Gloucester" | County=="Cumberland" | County=="Atlantic"  
 //region==2 means central
replace region=2 if County=="Hunterdon" | County=="Middlesex" | County=="Monmouth" | County=="Ocean" | County=="Mercer" 
move region County 

save kate_ps3pollution, replace 

//County SNAP usage
import excel "https://docs.google.com/uc?id=0B1opnkI-LLCicWZRS3c2MFhianM&export=download", clear firstrow 
replace County = "Passaic" in 1
replace County = "Cumberland" in 2 
replace County = "Essex" in 3
replace County = "Hudson" in 4
replace County = "Atlantic" in 5
replace County = "Camden" in 6
replace County = "Salem" in 7
replace County = "Mercer" in 8
replace County = "Union" in 9
replace County = "Ocean" in 10
replace County = "Gloucester" in 11
replace County = "Cape May" in 12
replace County = "Warren" in 13
replace County = "Middlesex" in 14
replace County = "Monmouth" in 15
replace County = "Burlington" in 16
replace County = "Bergen" in 17
replace County = "Sussex" in 18
replace County = "Morris" in 19
replace County = "Hunterdon" in 20
replace County = "Somerset" in 21

drop State
drop MetroSmallTownRuralStatus

generate region=0
 //region==0 means north 
 //region==1 means south 
replace region=1 if County=="Burlington" | County=="Camden" | County=="Gloucester" | County=="Salem" | County=="Cumberland" | County=="Atlantic" | County=="Cape May" 
 //region==2 means central
replace region=2 if County=="Hunterdon" | County=="Somerset" | County=="Middlesex" | County=="Monmouth" | County=="Ocean" | County=="Mercer" 
move region County 

save kate_ps3snap, replace 

//NJ County Census Data 2010-2016 

import excel "https://docs.google.com/uc?id=0B1opnkI-LLCiV2tGMjhfTTZjWkE&export=download", clear firstrow 
drop GEOid GEOid2 rescen42010 resbase42010 
drop in 1/1
rename GEOdisplaylabel County
replace County = "Atlantic" in 1
replace County = "Bergen" in 2 
replace County = "Burlington" in 3
replace County = "Camden" in 4
replace County = "Cape May" in 5
replace County = "Cumberland" in 6
replace County = "Essex" in 7
replace County = "Gloucester" in 8
replace County = "Hudson" in 9
replace County = "Hunterdon" in 10
replace County = "Mercer" in 11
replace County = "Middlesex" in 12
replace County = "Monmouth" in 13
replace County = "Morris" in 14
replace County = "Ocean" in 15
replace County = "Passaic" in 16
replace County = "Salem" in 17
replace County = "Somerset" in 18
replace County = "Sussex" in 19
replace County = "Union" in 20
replace County = "Warren" in 21

generate region=0
 //region==0 means north 
 //region==1 means south 
replace region=1 if County=="Burlington" | County=="Camden" | County=="Gloucester" | County=="Salem" | County=="Cumberland" | County=="Atlantic" | County=="Cape May" 
 //region==2 means central
replace region=2 if County=="Hunterdon" | County=="Somerset" | County=="Middlesex" | County=="Monmouth" | County=="Ocean" | County=="Mercer" 
move region County

save kate_ps3census, replace 


/*__________________________________________________________________________

                             STEP 3: MERGE NEW DATASETS
____________________________________________________________________________*/ 

use "https://docs.google.com/uc?id=0B1opnkI-LLCiVVdTS3hDX0ZsUUE&export=download"
drop _merge 
merge 1:1 County using kate_ps3toxic 
save kate_ps3, replace 

use kate_ps3
drop _merge 
merge 1:1 County using kate_ps3pollution
//note: 5 variables were not matched from the master because 5 states were mising from this dataset 
save kate_ps3, replace 

use kate_ps3
drop _merge 
merge 1:1 County using kate_ps3snap
save kate_ps3, replace 

use kate_ps3
drop _merge 
merge m:1 County using kate_ps3census 
drop _merge 
save kate_ps3, replace 



/*____________________________________________________________________________

                                   STEP 4: RESHAPE 
______________________________________________________________________________*/ 


use kate_ps3census 
reshape long respop, i (County) j(year)
//this was actually pretty cool! It created multiple lines for each County- this could be useful for viewing the data by County and year in a nice orderly row. 
reshape wide respop, i (County) j(year) //this moved the data back to its original wide format 



 
