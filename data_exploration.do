*===============================================================================
*PAPER 1: Household nutritional status and health outcome in the context of the urban poor
*===============================================================================

*Environment
set autotabgraphs on
// graph query, schemes
set scheme white_w3d

*Required package installations
// 	ssc install kobo2stata, replace
//  ssc install zscore06 , repalce
//	net install dm0004_1, from("http://www.stata-journal.com/software/sj13-2/") replace
	*This is for zanthro

*Working directory (bqelleni2014)
// gl wdrctry 	"G:\.shortcut-targets-by-id\1vJl8DqxohHaKzvtFC2054_uA9GI_rUQu\XLS_form_bqelleni2014" 
// gl rslts	"G:\.shortcut-targets-by-id\1vJl8DqxohHaKzvtFC2054_uA9GI_rUQu\XLS_form_bqelleni2014\code and results"
// cd "$wdrctry"

*Working directory (yambs4)
gl wdrctry 	"G:\My Drive\XLS_form_bqelleni2014" 
gl rslts	"G:\My Drive\XLS_form_bqelleni2014\code and results"
cd "$wdrctry"

*Data labeling for NEW and OLD data()Variables labelling using kobo2stata module (NEW DATA))
	*NEW
	kobo2stata using "rawdata_20220710\Household_Survey_new_20220710.xlsx" 		 , xlsform("forms\household survey new.xlsx" ) surveylabel("label::english") choiceslabel("label::english")
	kobo2stata using "rawdata_20220710\Anthropometric_survey_new_20220710.xlsx"  , xlsform("forms\anthropometry new.xlsx"    ) surveylabel("label::english") choiceslabel("label::english")
	kobo2stata using "rawdata_20220710\Food_composition_table_new_20220710.xlsx" , xlsform("forms\food composition new.xlsx" ) surveylabel("label::english") choiceslabel("label::english")

	*OLD
	kobo2stata using "rawdata_20220710\Household_Survey_old_20220710.xlsx" 		 , xlsform("forms\household survey new.xlsx" ) surveylabel("label::english") choiceslabel("label::english")
	kobo2stata using "rawdata_20220710\Anthropometric_survey_old_20220710.xlsx"  , xlsform("forms\anthropometry new.xlsx"    ) surveylabel("label::english") choiceslabel("label::english")
	kobo2stata using "rawdata_20220710\Food_composition_table_old_20220710.xlsx" , xlsform("forms\food composition new.xlsx" ) surveylabel("label::english") choiceslabel("label::english")

*Data management

	*1. Merging old and new data - Household Survey
	use "rawdata_20220710\Household_Survey_new_20220710-Household Survey New.dta" 	   , clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Household_Survey_old_20220710-Household Survey.dta" , force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\hhsvy.dta" , replace
		
	forval i=1/6 {
		use "rawdata_20220710\Household_Survey_new_20220710-grp`i'.dta" , clear
		gen oldnew = .
		label define oldnew 0 "Old" 1 "New" 
		label var oldnew "Old or new data"
		label val oldnew oldnew
		replace oldnew = 1 if oldnew==.
		append using "rawdata_20220710\Household_Survey_old_20220710-grp`i'.dta" , force		
		replace oldnew = 0 if oldnew==.
		save "rawdata_20220710\hhsvy_grp`i'.dta" , replace
	}
	
	foreach i in 1 2 2a 2b 2c {
		use "rawdata_20220710\Household_Survey_new_20220710-mdl_`i'.dta" , clear
		gen oldnew = .
		label define oldnew 0 "Old" 1 "New" 
		label var oldnew "Old or new data"
		label val oldnew oldnew
		replace oldnew = 1 if oldnew==.
		append using "rawdata_20220710\Household_Survey_old_20220710-mdl_`i'.dta" , force
		replace oldnew = 0 if oldnew==.
		save "rawdata_20220710\hhsvy_mdl`i'.dta" , replace
	}

	*2. Merging old and new data - Anthropometric_survey
	use "rawdata_20220710\Anthropometric_survey_new_20220710-Anthropometric survey New.dta" 	, clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Anthropometric_survey_old_20220710-Anthropometric survey.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\anthr_svy.dta", replace
		
	use "rawdata_20220710\Anthropometric_survey_new_20220710-child.dta" 	    , clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 1 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	append using "rawdata_20220710\Anthropometric_survey_old_20220710-child.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\anthr_chld.dta", replace
	
	use "rawdata_20220710\Anthropometric_survey_new_20220710-hh_roster.dta" 	    , clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Anthropometric_survey_old_20220710-hh_roster.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\anthr_rstr.dta", replace
	
	use "rawdata_20220710\Anthropometric_survey_new_20220710-random_measure.dta" 	     , clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Anthropometric_survey_old_20220710-random_measure.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\anthr_rndmmsr.dta", replace
	
	use "rawdata_20220710\Anthropometric_survey_new_20220710-woman.dta" 	    , clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Anthropometric_survey_old_20220710-woman.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\anthr_wmn.dta", replace
	
	*3. Merging old and new data - Food_composition_table
	use "rawdata_20220710\Food_composition_table_new_20220710-Food composition table NEW.dta" 	, clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 1 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	append using "rawdata_20220710\Food_composition_table_old_20220710-Food composition table.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\fdcmp_tbl.dta", replace
	
	use "rawdata_20220710\Food_composition_table_new_20220710-grp1.dta" 	, clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Food_composition_table_old_20220710-grp1.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\fdcmp_grp1.dta", replace
	
	use "rawdata_20220710\Food_composition_table_new_20220710-grp11.dta" 	, clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Food_composition_table_old_20220710-grp11.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\fdcmp_grp11.dta", replace
	
	use "rawdata_20220710\Food_composition_table_new_20220710-itm_wgt_grp.dta" 	, clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	label var oldnew "Old or new data"
	label val oldnew oldnew
	replace oldnew = 1 if oldnew==.
	append using "rawdata_20220710\Food_composition_table_old_20220710-itm_wgt_grp.dta", force
	replace oldnew = 0 if oldnew==.
	save "rawdata_20220710\fdcmp_itmwgtgrp.dta", replace
	
capture {
	*For the legacy data for food composition table

	import excel "rawdata_20220710\legacy\food_composition_new_corrected.xlsx" , sheet("amEkuiY9W2FbTDPdib9pPp") firstrow clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 1 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename _index _index1
	save "rawdata_20220710\fd_cmptn_new_main.dta" , replace

	import excel "rawdata_20220710\legacy\food_composition_new_corrected.xlsx" , sheet("grp1") firstrow clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 1 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename _index _index2
	rename _parent_index _index1
	save "rawdata_20220710\fd_cmptn_new_grp1.dta" , replace	
	
// 	import delimited "rawdata_20220710\legacy\ai6qBwzmF85b6iLAH9kwiM_2022_08_07_14_14_47.csv" , clear
	import excel "rawdata_20220710\legacy\food_composition_new_corrected.xlsx" , sheet("grp1_grp11") firstrow clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 1 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename grp1grp11grp111* *
	rename containert_wgh containert_wght
	rename _index _index3
	rename _parent_index _index2
	save "rawdata_20220710\fd_cmptn_new1.dta" , replace
	
	import excel "rawdata_20220710\legacy\food_composition_new_corrected.xlsx" , sheet("grp1_grp11_grp111_itm_wgt_grp") firstrow clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 1 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename grp1grp11grp111itm_wgt_grpit itm_nm
	rename B itm_wgt
	rename _index _index4
	rename _parent_index _index3
	save "rawdata_20220710\fd_cmptn_new2.dta" , replace
	
	*Merge
	use "rawdata_20220710\fd_cmptn_new2.dta" , clear
	merge m:1 _index3 using "rawdata_20220710\fd_cmptn_new1.dta" 	 , nogen
	merge m:1 _index2 using "rawdata_20220710\fd_cmptn_new_grp1.dta" , nogen
	merge m:1 _index1 using "rawdata_20220710\fd_cmptn_new_main.dta" , nogen force
	save "rawdata_20220710\fd_cmptn_new.dta" , replace

// 	import delimited "rawdata_20220710\legacy\amEkuiY9W2FbTDPdib9pPp_2022_08_07_12_43_25.csv" , clear
	import excel "rawdata_20220710\legacy\food_composition_old_corrected.xlsx" , firstrow sheet("Food composition table") clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 0 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename _index _index1
	save "rawdata_20220710\fd_cmptn_old_main.dta" , replace
	
	import excel "rawdata_20220710\legacy\food_composition_old_corrected.xlsx" , firstrow sheet("grp1") clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 0 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename _index _index2
	rename _parent_index _index1
	save "rawdata_20220710\fd_cmptn_old_grp1.dta" , replace

	import excel "rawdata_20220710\legacy\food_composition_old_corrected.xlsx" , firstrow sheet("grp11") clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 0 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename Is_this_member_an_under_five_o 	Is_this_member	
	rename Is_this_mother_pregnant_or_lacta Is_this_mother
	rename _index _index3
	rename _parent_index _index2
	save "rawdata_20220710\fd_cmptn_old1.dta" , replace
	
	import excel "rawdata_20220710\legacy\food_composition_old_corrected.xlsx" , firstrow sheet("itm_wgt_grp") clear
	gen oldnew = .
	label define oldnew 0 "Old" 1 "New" 
	replace oldnew = 0 if oldnew==.
	label var oldnew "Old or new data"
	label val oldnew oldnew
	rename _index _index4
	rename _parent_index _index3
	rename item_wght itm_wgt
	drop fd_name
// 	bys _index3 : gen fd_cnt = _n
// 	drop _parent_table_name _submission__id _submission__notes _submission__status _submission__submission_time _submission__submitted_by _submission__tags _submission__uuid _submission__validation_status fd_name _index4
// 	reshape wide itm_nm itm_wgt , i(_index3) j(fd_cnt)
	save "rawdata_20220710\fd_cmptn_old2.dta" , replace

	*Merge
	use "rawdata_20220710\fd_cmptn_old2.dta" , clear
	merge m:1 _index3 using "rawdata_20220710\fd_cmptn_old1.dta" , nogen
	merge m:1 _index2 using "rawdata_20220710\fd_cmptn_old_grp1.dta" , nogen
	merge m:1 _index1 using "rawdata_20220710\fd_cmptn_old_main.dta" , nogen
	order _index1 _index2 _index3 _index4 fd_name itm_nm 
	save "rawdata_20220710\fd_cmptn_old.dta" , replace 
	
	*Append old and new
	use 		 "rawdata_20220710\fd_cmptn_new.dta" , clear
	append using "rawdata_20220710\fd_cmptn_old.dta" , force
	
	save "rawdata_20220710\fdcmp_tbl.dta" , replace
	
// 	old 	Is_this_member_an_under_five_o 	Is_this_mother_pregnant_or_lacta 	Age_1 fd_name containert_wght item_number preserve_mthd Prep_mthd ingredient_list
//	new 	Is_this_member 					Is_this_mother 						Age_1 fd_name containert_wgh  item_number 											itm_wgt_grp_co

//	old 	fd_name itm_nm item_wght
//	new 	itm_nm itm_wgt

	*Changing n/a values to 
// 	destring *, ignore("n/a") 
}

*Descriptive exploration of variables

*===============================================================================
*** 							 MAIN SURVEY								 ***
								 ***=====***
	*Part I: Socio-demographics
		
		*Woreda
		use "rawdata_20220710\hhsvy.dta" , clear
		recode woreda (9=8) (2=1) (311=1)
		tab woreda 
		
		*Household size
		use "rawdata_20220710\hhsvy_mdl1.dta" , clear
		bys oldnew _parent_index : gen hhsz = _N
		collapse (mean) hhsz , by(oldnew _parent_index)
		label var hhsz "Household size"
		tab hhsz
		sum hhsz
		
		*Relationship to the household
		use "rawdata_20220710\hhsvy_mdl1.dta" , clear
		tab chld_mthr 
		tab mthr_type 
		tab relation
		
		*Sex
		tab sex
		
		*Age
		tabstat age , stat(count mean sd min p1 p5 p25 median p75 p95 p99 max)
		sum age
		bys sex : sum age 
		hist age , frequency by(sex)
		
		*Marital status
		tab marital
				
		*Education 
		tab educ_lvl , plot //for household members
		tab educ_lvl //for household members
		tab educ_lvl if relation == 1, plot 
		tab educ_lvl if relation == 1
		tab in_schl 
		tabstat educ_yrs, stat(count mean sd min p1 p5 p25 median p75 p95 p99 max)
		
		*Religion
		tab religion
		tab religion , plot
				
		*Employment and occupation 
		tab employ
		tab employ , plot
		tab	specify_employment_status
		tab	specify_employment_status , plot 
		
		tab occup
		tab occup , plot
		tab specify_occupation_type , plot
	
	*Part II: Household health
	
	*Questions for the child
	use "rawdata_20220710\hhsvy_mdl2a.dta" , clear	
	
		*Ill in the past 7 days
		tab ill_week
// 		tab ill_week //For under-five, mothers, heads (bring age data)
		
		*Type illness
		forval i=1/15 {
			tab ill_type1`i'
		}
		
		tab ill_drtn1  , plot
		
		tab ill_hcntr1 
		
		tab hcntr_typ1
		
		forval i=1/10 {
			tab med_prsnnl1`i'
		}
		
		tab visit_frq1
		
		*Ill in the past month
		tab ill_mnth 
		tab ill_mnth //For under-five, mothers, heads (bring age data)
		
		*Type illness
		forval i=1/15 {
			tab ill_type2`i'
		}
		
		tab ill_drtn2  , plot
		tab ill_drtn2 		
	
		tab ill_hcntr2 
		
		tab hcntr_typ2
		
		forval i=1/10 {
			tab med_prsnnl2`i'
		}
		
		tab visit_frq2

		*Ill in the past 3 month
		tab ill_3mnth 
		tab ill_3mnth //For under-five, mothers, heads (bring age data)
		
		*Type illness
		forval i=1/15 {
			tab ill_type3`i'
		}
		
		tab ill_drtn3  , plot
		tab ill_drtn3  
		
		tab ill_hcntr3 
		
		tab hcntr_typ3
		
		forval i=1/10 {
			tab med_prsnnl3`i'
		}
		
		tab visit_frq3
	
		*Ill in the past 6 month
		tab ill_6mnth 
		tab ill_6mnth //For under-five, mothers, heads (bring age data)
		
		*Type illness
		forval i=1/15 {
			tab ill_type4`i'
		}
		
		tab ill_drtn4 , plot
		
		tab ill_hcntr4 
		
		tab hcntr_typ4
		
		forval i=1/10 {
			tab med_prsnnl4`i'
		}
		
		tab visit_frq4

		*Generating the reporting tables
	use "rawdata_20220710\hhsvy_mdl2a.dta" , clear	
		
		*Illness reference period
		local tm week mnth 3mnth 6mnth
		tempname illness
		postfile `illness' str60 sick_in_the_past_  share N using "$rslts\sickness1" , replace
			foreach v in `tm' {
				sum ill_`v'
				loc a = r(mean)
				loc b = r(N)
			post `illness' ("`:var label ill_`v''") (`a') (`b')
		}
		postclose `illness'
		
		*Illness type by each reference period
		tempname illness
		postfile `illness' time_prd  str60(Illness_type_) share N using "$rslts\sickness2" , replace
			forval i=1/4 {
				forval j=1/15 {
					sum ill_type`i'`j'
					loc a = r(mean)
					loc b = r(N)
			post `illness' (`i') ("`:var label ill_type`i'`j''") (`a') (`b')
				}
			}
		postclose `illness'
		
		*Duration of illness by reference period
		tempname illness
		postfile `illness' sick_in_the_past_ duration_ N using "$rslts\sickness3" , replace
			forval i=1/4 {
				sum ill_drtn`i'
				loc a = r(mean)
				loc b = r(N)
			post `illness' (`i') (`a') (`b') 
			}
		postclose `illness'
		
		*===
		*Did the person visit a health care provider? 
		tempname illness
		postfile `illness' time_prd  str60(visited_hctr_) share N using "$rslts\sickness4" , replace
			forval i=1/4 {
				sum ill_hcntr`i'
				loc a = r(mean)
				loc b = r(N)
			post `illness' (`i') ("`:var label ill_type`i''") (`a') (`b') 
			}
		postclose `illness'
	
		*What type of health center if visited, by reference period
		tempname illness
		postfile `illness' time_prd str60(hctr_typ_) share N using "$rslts\sickness5" , replace
			forval i=1/4 {
				forval j=1/10 {
					sum hcntr_typ`i' if hcntr_typ`i'==`j'
					loc a = r(N)
					sum hcntr_typ`i'
					loc b = r(N)
					loc c = `a' / `b'
			post `illness' (`i') ("`:label hcenter_type `j''") (`c') (`a')
				}
			}
		postclose `illness'
		
		*What type of health personnel, if visited , by reference period
		tempname illness
		postfile `illness' time_prd str60(prsnl_type_) share N using "$rslts\sickness6" , replace
			forval i=1/4 {
				forval j=1/10 {
					sum ill_type`i'`j'
					loc a = r(mean)
					loc b = r(N)
			post `illness' (`i') ("`:var label med_prsnnl`i'`j''") (`a') (`b')
				}
			}
		postclose `illness'

		*Maternal and newborn health
	use "rawdata_20220710\hhsvy_mdl2b.dta" , clear

		tab antntl
		
		forval i=1/8 {
			tab antntl_rsn`i'
		}
		
		forval i=1/7 {
			tab antntl_who`i'
		}

		tab antntl_mnths
		
		tab antntl_frq
		
		forval i=1/7 {
			tab brth_who`i'
		}

		forval i=1/14 {
			tab brth_where`i'
		}
		
		tab bby_wghtd
		tab bby_wghtd antntl //all babies who had antenatal followup were weighed
		
		tab bby_wght
		hist bby_wght , kdensity
		tab wght_srce
		
		tab pstntl
		
		tab frst_brst_fd
		
		tab othr_drnk
		forval i=1/12 {
			tab drnk_typ`i'
		}
		tab grwthmntr_frq
		hist grwthmntr_frq , kdensity
	
	*Questions for the mother
	use "rawdata_20220710\hhsvy_mdl2c.dta"	, clear 
		
		tab hf_take

		tab hf_frq
		hist hf_frq
		
		tab mcrntrnt
		tab intstn_worms
		
		*Diarrhoea
		tab diarrhoea 
		tab drrh_drnk 
		tab drrh_drnk_lss 
		tab trtmnt 
		forval i=1/14 {
			tab trtmnt_where`i'
		}
		tab lemlem 
		tab mitin 
		tab zink
		tab trt_drrh
		forval i=1/10 {
			tab trt_what`i'
		}
		
		*Cough
		tab cough 
		tab cough_shrtbrth 
		tab shrtbrth_chst 
		tab trt_advc 
		tab trt_whr_chst 
		
		*Fever
		tab fever 
		tab fever_trt 
		forval i=1/14 {
			tab trt_whr_fvr`i'
		}		
		
		*Child treatment expenses
		
			
	*Part III Household food consumption
	
	*===
	*Module IIIA. Household food consumption (for children under the age of 2)
	
	*Group 1: Grains, roots and tubers
	
	use "rawdata_20220710\hhsvy_grp1.dta" , clear
		
	loc chldfd 	fd_grain fd_root
	tempname food
	postfile `food' str50 food_grp share N using  "$rslts\food_grps1" , replace
		foreach v of local chldfd {
			sum `v' 
			loc a = r(mean)
			loc b = r(N)
			post `food' ("`:var label `v''") (`a') (`b')
		}
	postclose `food'
	
		tab fd_grain 
		tab fd_root
		
	*Group 2: Legumes and nuts, infant formula, mily, yoghurt, and cheese and diary products
	use "rawdata_20220710\hhsvy_grp2.dta" , clear

	loc chldfd 	fd_legumes2 ///
				fd_formula fd_milk fd_yoghurt fd_cheese
	tempname food
	postfile `food' str50 food_grp share N using  "$rslts\food_grps2" , replace
		foreach v of local chldfd {
			sum `v' 
			loc a = r(mean)
			loc b = r(N)
			post `food' ("`:var label `v''") (`a') (`b')
		}
	postclose `food'
		
		tab fd_legumes2 
		
		tab fd_formula 
		sum frq_formula //how many times per day
		
		tab fd_milk 
		sum frq_milk 	//how many times per day
		
		tab fd_yoghurt 
		sum frq_yoghurt //how many times per day
		
		tab fd_cheese		
	
	*Group 3: Flesh foods
	use "rawdata_20220710\hhsvy_grp3.dta" , clear

	loc chldfd 	fd_organ fd_meat fd_fish fd_insect
	tempname food
	postfile `food' str50 food_grp share N using  "$rslts\food_grps3" , replace
		foreach v of local chldfd {
			sum `v' 
			loc a = r(mean)
			loc b = r(N)
			post `food' ("`:var label `v''") (`a') (`b')
		}
	postclose `food'
		
		tab fd_organ 
		tab fd_meat 
		tab fd_fish 
		tab fd_insect
	
	*Group 4: Eggs
	use "rawdata_20220710\hhsvy_grp4.dta" , clear

	loc chldfd 	fd_eggs
	tempname food
	postfile `food' str50 food_grp share N using  "$rslts\food_grps4" , replace
		foreach v of local chldfd {
			sum `v' 
			loc a = r(mean)
			loc b = r(N)
			post `food' ("`:var label `v''") (`a') (`b')
		}
	postclose `food'
	
		tab fd_eggs
	
	*Group 5: Vitamin A fruits and vegetables
	use "rawdata_20220710\hhsvy_grp5.dta" , clear

	loc chldfd 	fd_pumpkin fd_dglv fd_orngfruit fd_palm
	tempname food
	postfile `food' str50 food_grp share N using  "$rslts\food_grps5" , replace
		foreach v of local chldfd {
			sum `v' 
			loc a = r(mean)
			loc b = r(N)
			post `food' ("`:var label `v''") (`a') (`b')
		}
	postclose `food'
	
		tab fd_pumpkin 
		tab fd_dglv 
		tab fd_pumpkin 
		tab fd_dglv 
		tab fd_orngfruit 
		tab fd_palm
		
	*Group 6: Other fruits and vegetables
	use "rawdata_20220710\hhsvy_grp6.dta" , clear

	loc chldfd 	fd_othrfruit food_grp_othr fd_carbs fd_sugary fd_condiment
	tempname food
	postfile `food' str50 food_grp share N using  "$rslts\food_grps6" , replace
		foreach v of local chldfd {
			sum `v' 
			loc a = r(mean)
			loc b = r(N)
			post `food' ("`:var label `v''") (`a') (`b')
		}
	postclose `food'	
	
	foreach v of varlist fd_othrfruit food_grp_othr fd_carbs fd_sugary fd_condiment {
			tab `v'
		}
		
	*Append the grp files	
	use "$rslts\food_grps1.dta" , clear
	append using "$rslts\food_grps2.dta"
	append using "$rslts\food_grps3.dta"
	append using "$rslts\food_grps4.dta"
	append using "$rslts\food_grps5.dta"
	append using "$rslts\food_grps6.dta"
	save 		 "$rslts\food_grps.dta" , replace
	
	use "$rslts\food_grps.dta" , clear
	export excel using "$rslts\results_table" , sheet(food_grps, replace) firstrow(var)

	forval i = 1/6 {
		erase "$rslts\food_grps`i'.dta"
	}

	*Merge the grp files
	use "rawdata_20220710\hhsvy_grp1.dta" , clear
	merge 1:1 _index oldnew using "rawdata_20220710\hhsvy_grp2.dta" , nogen	
	merge 1:1 _index oldnew using "rawdata_20220710\hhsvy_grp3.dta" , nogen 	
	merge 1:1 _index oldnew using "rawdata_20220710\hhsvy_grp4.dta" , nogen 	
	merge 1:1 _index oldnew using "rawdata_20220710\hhsvy_grp5.dta" , nogen 	
	merge 1:1 _index oldnew using "rawdata_20220710\hhsvy_grp6.dta" , nogen
	
	order _index _parent_table_name _parent_index _submission__id _submission__uuid ///
		  _submission__submission_time _submission__validation_status _submission__notes ///
		  _submission__status _submission__submitted_by _submission__tags oldnew
		  
	save "rawdata_20220710\hhsvy_grp.dta" , replace
	
	*Construction of Food Consumption Score (FCS) = a proxy measure of nutritional adequecy
		*Data collected for the past 24 hrs
		*Based on WFP / FAO approach
		**Categories and corresponding importance weights out of 16
		
		***Grp							Weight	Variables
		***====================================================================================
		***Grp 1 Cereals and tubers 	= 2.0 ==> fd_grain fd_root
		***Grp 2 Pulses 				= 3.0 ==> fd_legumes2
		***Grp 3 Vegetables and leaves	= 1.0 ==> fd_dglv fd_pumpkin
		***Grp 4 Fruits					= 1.0 ==> fd_orngfruit fd_othrfruit
		***Grp 5 Meat and fish			= 4.0 ==> fd_organ fd_meat fd_fish fd_insect fd_eggs
		***Grp 6 Milk					= 4.0 ==> fd_milk fd_yoghurt fd_cheese
		***Grp 7 Sugar					= 0.5 ==> fd_sugary
		***Grp 8 Oil					= 0.5 ==> fd_palm fd_carbs
		***Grp 9 Condiments				= 0.0 ==> fd_condiment

	use "rawdata_20220710\hhsvy_grp.dta" , clear

	forval i = 1/9 {
		gen fdgrp_`i' = .
	}
	
	forval i = 0/1 {
		replace fdgrp_1 = `i' if fd_grain==`i' | fd_root==`i'
		replace fdgrp_2 = `i' if fd_legumes2 ==`i'
		replace fdgrp_3 = `i' if fd_dglv==`i' | fd_pumpkin==`i'
		replace fdgrp_4 = `i' if fd_orngfruit==`i' | fd_othrfruit==`i'
		replace fdgrp_5 = `i' if fd_organ==`i' | fd_meat==`i' | fd_fish==`i' | fd_insect==`i' | fd_eggs==`i'
		replace fdgrp_6 = `i' if fd_milk==`i' | fd_yoghurt==`i' | fd_cheese==`i'
		replace fdgrp_7 = `i' if fd_sugary==`i'
		replace fdgrp_8 = `i' if fd_palm==`i' | fd_carbs==`i'
		replace fdgrp_9 = `i' if fd_condiment==`i'
	}
	
	gen fcs_u5 = 	 ( /// The children are assumed to eat once if they eat any of the food items in the food group
				  fdgrp_1*2 ///
				+ fdgrp_2*3 ///
				+ fdgrp_3*1 ///
				+ fdgrp_4*1 ///
				+ fdgrp_5*4 ///
				+ fdgrp_6*4 ///
				+ fdgrp_7*.5 ///
				+ fdgrp_8*.5 ///
				+ fdgrp_9*0 ///
				  )
	label var fcs_u5 "Under-five Food Consumption Score, FCS"
	tab fcs_u5 , miss
	
	*Thresholds
	gen fcs_thr = .
	replace fcs_thr = 1 if fcs_u5>=0 & fcs_u5<=4 // Poor food consumption
	replace fcs_thr = 2 if fcs_u5>4  & fcs_u5<=6 // Borderline food consumption
	replace fcs_thr = 3 if fcs_u5>6  & fcs_u5< . // Acceptable food consumption
	label define fcs_thr 1 "Poor" 2 "Borderline" 3 "Acceptable"
	label val fcs_thr fcs_thr
	label var fcs_thr "Food Consumption Score thresholds"
	
	tab fcs_thr
		
	hist fcs_u5 , freq xline(4 6) text(120 2 "Poor", place(w)) text( 120 5 "Borderline" , place(c)) text(120 10 "Acceptable" , place(e)) text()
	
	save "$rslts\fcs_u5.dta" , replace
	
	*Module IIIB. household food consumption KAP questions (for children 2 yrs or younger)
	use "rawdata_20220710\hhsvy.dta" , clear
		tab baby_eat 
		tab breast_recom 
		tab wean 
		tab wean_imprt
		
		forval i=1/8 {
			tab feeding_encour`i'
		}
	
		*Confidence
		tab how_confident
		tab not_confid 
		
		*Feeding variety food
		tab childfeeding_varity 
		tab childfeeding_notgood 
		
		tab childfeeding_difficult 
		tab feedingdifficult_why 
		
		*Feeding several times
		tab feeding_frequency 
		tab frequency_why 
		
		tab feedingfrequency_diffi 
		tab difficultfreq_why 
		
		*Breast feeding
		tab brstfd_gd 
		tab brstfd_rsn 
		tab brstfd_dffclt 
		tab brstfd_dffclt_why
		
	*Module IIIC. Household food consumption (during pregnancy and lactation)
	use "rawdata_20220710\hhsvy.dta" , clear
		*Eating cf. of pregnant vs non-pregnant 
		tab pregnant_feeding
		forval i=1/7 {
			tab pregnant_feeding`i'
		}
		tab feeding_list
		
		*Eating habit of lactating mother
		tab lactating_feeding
		forval i=1/7 {
			tab lactating_feeding`i'
		}
		
		*Pregnancy suppliments
		tab lactating_feeding
		forval i=1/4 {
			tab lactating_feeding`i'
		}
		
		*Taking folic acid during pregnancy
		tab pregnancy_folicacid
		forval i=1/4 {
			tab pregnancy_folicacid`i'
		}
			
		*Risks of low birth
		tab lowbirthweight_risk
		foreach i in 1 2 3 4 5 7 8 {
			tab lowbirthweight_risk`i'
		}
		
		*Low birth weight seriousness
		tab lowweight_damage 
		tab lowweight_noharm
		
		*Eating more food during pregnancy good?
		tab morefood_pregnancy 
		tab morefood_notgood
		tab morefood_difficult 
		tab morefood_why
		
	*Module IIID. Household food consumption (undernutrition)
	use "rawdata_20220710\hhsvy.dta" , clear
		*Recognizing hh member does not have enough food
		tab undrntrtn 
		
		*Signs of under nutrition
		tab undr_sgn
		forval i= 0/5 {
			tab undr_sgn`i'
		}
		
		*Undernutrition reasons
		tab undr_rsn
		forval i= 0/4 {
			tab undr_rsn`i'
		}
		
		*Reasons for not getting enough food
		tab enghfd_rsn
		forval i= 0/3 {
			tab enghfd_rsn`i'
		}
			
		*How to know the baby is growing well
		tab grw_well
		
		tab grw_hlp
		forval i=0/2 {
			tab grw_hlp`i'
		}
		
		tab baby_wght 
		tab baby_cause
		forval i=0/3 {
			tab baby_cause`i'
		}
		
		*About anemia (heard, recognize)
		tab anemia_hear
		tab anemia_rec
		forval i=0/5 {
			tab anemia_rec`i'
		}
		
		tab anemia_inf
		forval i=0/2 {
			tab anemia_inf`i'
		}
			
		tab anemia_preg
		forval i=0/3 {
			tab anemia_preg`i'
		}
		
		*Iron
		tab iron_def
		tab If_Not_likely_can_y_why_it_is_no
		tab How_serious_do_you_think_iron_
		tab iron_df_rsn
		
		tab iron_rch
		tab iron_rch_nt 
		tab iron_rch_dft 
		tab iron_rch_rn 
		tab iron_rch_cnf 
		tab iron_rch_crn
		tab iron_tst
		
		*Vitamin rich
		tab vit_c_rich_lst
		tab fruit_ys 
		tab fruit_evry 
		tab fruit_whn
		
		*Coffee
		tab cff_tea1 
		tab cff_tea_ys 
		tab cff_tea_whn
		
		*Vitamin A deficiency
		tab vitA_hear 
		tab vitA_recg 
		forval i=0/4 { //recognizing VitA deficiency
			tab vitA_recg`i'
		}
		
		*Causes of vitA deficiency
		tab vitA_cs
		forval i=0/3 {
			tab vitA_cs`i'
		}
		
		*VitA deficiency prevention
		tab vitA_prev
		forval i=0/4 {
			tab vitA_prev`i'
		}
		
		*VitA rich food examples
		tab vitA_fd
		tab vitA_src
		tab anml1
		forval i=1/5 {
			tab anml1`i'
		}
		
		*Orange colored VitA rich foods
		tab orng_veg
		forval i=1/4 {
			tab orng_veg`i'
		}
		
		*Green vegetables rich in VitA
		tab grn_veg
		forval i=1/5 {
			tab grn_veg`i'
		}
	
		*Fruits (orange or yellow, non-citrus) rich in VitA
		tab orng_frt
		forval i=1/7 {
			tab orng_frt`i'
		}

		*Other fruit
		tab vitA_othr
		forval i=0/2 {
			tab vitA_othr`i'
		}
		
		*Likelihood of lacking vitA
		tab vitA_rec
		tab vitA_rec_nt
		
		tab vitAsrs 
		tab vitAsrs_nt
		
		tab vitA_prp 
		tab vitA_rsn 
		tab vitA_dfclt 
		tab vitA_dfclt_rsn
		
		tab vitA_cnf 
		tab vitA_cnf_nt
		tab vitA_tst_lk 
		tab vitA_salt 
		tab vitA_salt_ys
		
		tab  idn_hear 
		tab idn_hr_ys 
		tab idn_sgn
		forval i=0/4 {
			tab idn_sgn`i'
		}
		
		tab idn_cnsq
		forval i=0/3 {
			tab idn_cnsq`i'
		}
		
		tab idn_cs
		forval i=0/2 {
			tab idn_cs`i'
		}		
		
		tab idn_prev
		forval i=0/2 {
			tab idn_prev`i'
		}		

		tab idn_lack 
		tab idn_lack_nt
		
		tab idn_srs 
		tab idn_srs_nt
		
		tab idn_prp 
		tab idn_prp_rsn 
		tab idn_dffclt_nt 
		tab idn_rsn
		
	**Food safety practice questions

		*Cleaning utencils
		tab cleaning_utencils 
		forval i=0/3 {
			tab cleaning_utencils`i'
		}		
		
		*Perishable food storage
		tab store_purish
		forval i=0/4 {
			tab store_purish`i'
		}		
		
		*Leftover storage
		tab leftover_store
		forval i=0/4 {
			tab leftover_store`i'
		}				
		
		*Raw fruits cleaning
		tab beforet_raw    
		tab spoil_effect 
		
		*spoiled food caused sickness
		tab spoil_serious 
		
		*Refrigeration
		tab perish_goodstr 
		tab notgood_reasn 
		tab storediffc 
		tab reasn_diffic 
		
		*Re-heating food
		tab good_reheat 
		tab reasn_ntgood 
		tab diffic_reheat 
		tab reasn_diffic1
		
		*Washing fruits and vegetables
		tab wash_raw 
		tab ntgud_reasn 
		tab wash_vegfrut 
		tab wash_unlikely
		
	*Module IIIE. Household diet diversity score (past 7 days; 24hr window is recommended)
	use "rawdata_20220710\hhsvy.dta" , clear
		*Consumed food category
		tab food1 
		forval i=1/6 {
			tab food1`i'
		}				
		
		*Consumed food sub-category (amount consumed by source)

			*Cereals	
			forval i=1/7 {
				tab cereals1`i'
				sum purchased1`i' 
				sum own_prdctn1`i' 
				sum gifts_n_othr1`i' 
	// 			sum food_tot1`i' 
				sum tot_consumed1`i'
			}
			
			*Pulses
			forval i=1/7 {
				tab pulses1`i'
				sum purchased2`i' 
				sum own_prdctn2`i' 
				sum gifts_n_othr2`i' 
	// 			sum food_tot2`i' 
				sum tot_consumed2`i'
			}
			
			*Meat
			forval i=1/5 {
				tab  meat1`i'
				sum purchased3`i' 
				sum own_prdctn3`i' 
				sum gifts_n_othr3`i' 
	// 			sum food_tot3`i' 
				sum tot_consumed3`i'
			}
			
			*Other foods
			forval i=1/7 {
				tab otherfd1`i'
				sum purchased4`i' 
				sum own_prdctn4`i' 
				sum gifts_n_othr4`i' 
	// 			sum food_tot4`i' 
				sum tot_consumed4`i'
			}
			
			*Beverages
			forval i=1/6 {
				tab beverages1`i'
				sum purchased5`i' 
				sum own_prdctn5`i' 
				sum gifts_n_othr5`i' 
	// 			sum food_tot5`i' 
				sum tot_consumed5`i'
			}
			
			*Prepared foods
			forval i=1/4 {
				tab prepd_fd1`i'
				sum purchased6`i' 
				sum own_prdctn6`i' 
				sum gifts_n_othr6`i' 
	// 			sum food_tot6`i' 
				sum tot_consumed6`i'
			}
			
// 	merge 1:1  _index oldnew using "rawdata_20220710\hhsvy_grp.dta"
			
	*Calculating Household Diet Diversity Score (HDDS) for 1 week window

		***Grp							Weight	Variables
		***====================================================================================
		***Grp A Cereals 				= 1.0 ==> cereals11 cereals12 cereals13 cereals14 cereals15 cereals16 prepd_fd11 prepd_fd12 prepd_fd13 prepd_fd14
		***Grp B Roots & tubers			= 1.0 ==> cereals17
		***Grp C Vegetables and leaves	= 1.0 ==> orng_veg1 orng_veg2 orng_veg3 orng_veg4 grn_veg5
		***Grp D Fruits					= 1.0 ==> orng_frt1 orng_frt2 orng_frt3 orng_frt4 orng_frt5 orng_frt6
		***Grp E Meat		 			= 1.0 ==> meat11 meat12 meat13 meat15
		***Grp F Eggs					= 1.0 ==> otherfd15
		***Grp G Fish and shellfish		= 1.0 ==> meat14 
		***Grp H Pulses 				= 1.0 ==> pulses11 pulses12 pulses13 pulses14 pulses15 pulses16 pulses17 purchased27
		***Grp I Milk & products		= 1.0 ==> otherfd11 otherfd12 
		***Grp J Oil, fat, or butter	= 1.0 ==> otherfd13 otherfd14
		***Grp K Sugar or honey			= 1.0 ==> otherfd16 
		***Grp L Condiments				= 1.0 ==> otherfd17 beverages11 beverages12 beverages13 beverages14 beverages15 beverages16 
	
	foreach i in a b c d e f g h i j k l {
		gen hdds_`i' = .
	}
	
	forval i = 0/1 {
		replace hdds_a = `i' if cereals11==`i' | cereals12==`i' | cereals13==`i' | cereals14==`i' | cereals15==`i' | cereals16==`i' | prepd_fd11==`i' | prepd_fd12==`i' | prepd_fd13==`i' | prepd_fd14==`i'
		replace hdds_b = `i' if cereals17==`i' 
		replace hdds_c = `i' if orng_veg1==`i' | orng_veg2==`i' | orng_veg3==`i' | orng_veg4==`i' | grn_veg5==`i'
		replace hdds_d = `i' if orng_frt1==`i' | orng_frt2==`i' | orng_frt3==`i' | orng_frt4==`i' | orng_frt5==`i' | orng_frt6==`i'
		replace hdds_e = `i' if meat11==`i' | meat12==`i' | meat13==`i' | meat15==`i'
		replace hdds_f = `i' if otherfd15==`i'
		replace hdds_g = `i' if meat14==`i' 
		replace hdds_h = `i' if pulses11==`i' | pulses12==`i' | pulses13==`i' | pulses14==`i' | pulses15==`i' | pulses16==`i' | pulses17==`i' | purchased27==`i'
		replace hdds_i = `i' if otherfd11==`i' | otherfd12==`i'  
		replace hdds_j = `i' if otherfd13==`i' | otherfd14==`i' 
		replace hdds_k = `i' if otherfd16==`i' 
		replace hdds_l = `i' if otherfd17==`i' | beverages11==`i' | beverages12==`i' | beverages13==`i' | beverages14==`i' | beverages15==`i' | beverages16==`i' 
	}
	
	egen hdds = rowtotal(hdds_a hdds_b hdds_c hdds_d hdds_e hdds_f hdds_g hdds_h hdds_i hdds_k hdds_l), m			
	label var hdds "Household Diet Diversity Score, HDDS"
	tab hdds	
		
	*Food Consumption Score (FCS)
	use "rawdata_20220710\hhsvy.dta" , clear
		
	*Construction of Food Consumption Score (FCS) = a proxy measure of nutritional adequecy
		*Based on WFP / FAO approach
		**Categories and corresponding importance weights out of 16
		
		***Grp							Weight	Variables
		***====================================================================================
		***Grp 1 Cereals and tubers 	= 2.0 ==> cereals11 cereals12 cereals13 cereals14 cereals15 cereals16 cereals17 prepd_fd11 prepd_fd13
		***Grp 2 Pulses 				= 3.0 ==> pulses11 pulses12 pulses13 pulses14 pulses15 pulses16 pulses17
		***Grp 3 Vegetables and leaves	= 1.0 ==> orng_frt1 orng_frt2 orng_frt3 orng_frt4 orng_frt5 orng_frt6
		***Grp 4 Fruits					= 1.0 ==> orng_veg1 orng_veg2 orng_veg3 orng_veg4 grn_veg5
		***Grp 5 Meat and fish			= 4.0 ==> meat11 meat12 meat13 meat14 meat15 otherfd15
		***Grp 6 Milk					= 4.0 ==> otherfd11 otherfd12
		***Grp 7 Sugar					= 0.5 ==> otherfd16 prepd_fd12
		***Grp 8 Oil					= 0.5 ==> otherfd13 otherfd14
		***Grp 9 Condiments				= 0.0 ==> otherfd17 beverages11 beverages12 beverages13 beverages14 beverages15 beverages16
		
	forval i = 1/9 {
		gen hhfdgrp_`i' = .
	}
	
	forval i = 0/1 {
		replace hhfdgrp_1 = `i' if cereals11==`i' | cereals12==`i' | cereals13==`i' | cereals14==`i' | cereals15==`i' | cereals16==`i' | cereals17==`i' | prepd_fd11==`i' | prepd_fd13==`i'
		replace hhfdgrp_2 = `i' if pulses11==`i' | pulses12==`i' | pulses13==`i' | pulses14==`i' | pulses15==`i' | pulses16==`i' | pulses17==`i'
		replace hhfdgrp_3 = `i' if orng_frt1==`i' | orng_frt2==`i' | orng_frt3==`i' | orng_frt4==`i' | orng_frt5==`i' | orng_frt6==`i'
		replace hhfdgrp_4 = `i' if orng_veg1==`i' | orng_veg2==`i' | orng_veg3==`i' | orng_veg4==`i' | grn_veg5==`i'
		replace hhfdgrp_5 = `i' if meat11==`i' | meat12==`i' | meat13==`i' | meat14==`i' | meat15==`i' | otherfd15==`i'
		replace hhfdgrp_6 = `i' if otherfd11==`i' | otherfd12==`i'
		replace hhfdgrp_7 = `i' if otherfd16==`i' | prepd_fd12==`i'
		replace hhfdgrp_8 = `i' if otherfd13==`i' | otherfd14==`i'
		replace hhfdgrp_9 = `i' if otherfd17==`i' | beverages11==`i' | beverages12==`i' | beverages13==`i' | beverages14==`i' | beverages15==`i' | beverages16==`i' 
	}
	
	replace	hhfdgrp_1 = hhfdgrp_1*2 
	replace	hhfdgrp_2 = hhfdgrp_2*3  
	replace hhfdgrp_3 = hhfdgrp_3*1  
	replace hhfdgrp_4 = hhfdgrp_4*1  
	replace hhfdgrp_5 = hhfdgrp_5*4  
	replace hhfdgrp_6 = hhfdgrp_6*4  
	replace hhfdgrp_7 = hhfdgrp_7*.5 
	replace hhfdgrp_8 = hhfdgrp_8*.5 
	replace hhfdgrp_9 = hhfdgrp_9*0
	
	egen hhfcs = rowtotal(hhfdgrp_1 hhfdgrp_2 hhfdgrp_3 hhfdgrp_4 hhfdgrp_5 hhfdgrp_6 hhfdgrp_7 hhfdgrp_8 hhfdgrp_9) , m
	label var hhfcs "Household Food Consumption Score, HHFCS"
	tab hhfcs
	
	*Module IIIF. Household Food insecurity access scale
	use "rawdata_20220710\hhsvy.dta" , clear

	*Calculate HFIAS (Households Food Insecurity Access Scale) (0 to 27)

	// Generating the intensity variables (sometimes (==2) is taken as aintensity level)	
	gen 	q10a = 1
	gen 	q9a  = .
	replace q9a  = 3 if q10 == 1
	replace q9a  = 2 if q10 == 0

	gen 	q8a  = .
	replace q8a  = 3 if q9 == 1
	replace q8a  = 2 if q9 == 0
	
	gen 	q7a  = .
	replace q7a  = 3 if q8 == 1
	replace q7a  = 2 if q8 == 0

	gen 	q6a  = .
	replace q6a  = 3 if q7 == 1
	replace q6a  = 2 if q7 == 0

	gen 	q5a  = .
	replace q5a  = 3 if q6 == 1
	replace q5a  = 2 if q6 == 0
	
	gen 	q4a  = .
	replace q4a  = 3 if q5 == 1
	replace q4a  = 2 if q5 == 0

	gen 	q3a  = .
	replace q3a  = 3 if q4 == 1
	replace q3a  = 2 if q4 == 0

	gen 	q2a  = .
	replace q2a  = 3 if q3 == 1
	replace q2a  = 2 if q3 == 0

	forval i=2/10 {
		gen wq`i' = q`i'*q`i'a 
	}
	
	egen hfias = rowtotal(wq2 wq3 wq4 wq5 wq6 wq7 wq8 wq9 wq10) , m
	label var hfias "Household Food Insecurity Access Scale"
	tab hfias
	
	*Module IV. Household food safety and WASH
	use "rawdata_20220710\hhsvy.dta" , clear

		*Module IVA. Personal hygiene
		
		*Hand washing
		tab washhand_step
	
		*Avoid germs by doing ...
		tab avoid_germs
		forval i=1/4 {
			tab avoid_germs`i'
		}
		
		*When to wash hands
		tab washing_keymoment
		forval i=1/8 {
			tab washing_keymoment`i'
		}
		
		*Likelihood of being sick from lack of hygiene
		tab lesshygiene_sick 
		tab childsick_lesshygiene 
		tab hygiene_unlikely 
		tab sick_howserious 
		
		tab diarrhea_serious 
		tab baby_diarrhea 
		tab diarrhea_nswhy 
		
		
		tab washing_important 
		tab Wash_feeding 
		tab washing_ntgood 
		tab washing_difficlt 
		
		tab washing_bfeeding 
		tab why_washdiffic 
		tab wash_confid 
		tab why_ntconfident
		
		*Water source
		tab water_source
		forval i=1/17 {
			tab water_source`i'
		}
		
		*Water use
		tab water_duse
		tab item_type
		tab item_hygiene
		tab cleaning_how
		
		*water storage
		tab water_store 
		
		*Water safety
		tab water_treat 
		tab water_safe 
		tab Safety_water 
		tab notsafe_water
		
		*Diarrhoea from unsafe water
		tab diarrhea_unsafe 
		tab child_diarrhea 
		
		tab sick_unsafewat
		tab boil_water
		tab ntgood_boiling
		tab boil_difficult
		tab boil_wdifficult
		tab boil_confidence
		tab boil_notconfi	
			
	*Module IVE. Food safety KAP
	
		*Food safety protocols
		tab fprep_gown 
		tab hcover_food 
		tab ornament_prep
		tab cook_veget
		tab diarrhea_fprep
		tab clean_area
		tab washhnd_prep
		tab washing_atoilet
		tab dirt_wash
		tab cut_nail
	
	*Module V. Power relations household questionnaire

	*Module VA. Household members power relations
	use "rawdata_20220710\hhsvy.dta" , clear
		*Areas od decision making vis-a-vis 9 different decision makers in the household
		forval i=0/9 {
			tab chld_dspln`i'
			tab	fd_pur`i'
			tab	cnsmbls_pur`i'
			tab	mkt_pur`i'
			tab	asst_pur`i'
			tab	fd_prdn`i'
			tab grdng`i'
			tab	power_rel`i'
			tab	fd_bf`i'
			tab	fd_lnch`i'
			tab	fd_sppr`i'
			tab	fd_lnddd`i'
			tab	ftr_pln`i'
			tab	pblc_wrk`i'
			tab	rspn_hm`i'
			tab	crdt`i'
			tab	asst_own`i'
		}
		
	*Module VB. Household food distribution and gender relations
	use "rawdata_20220710\hhsvy.dta" , clear
		*Role of men and women in food production
		forval i=1/8 {
			di "Womens role"
			tab wmn_prdc`i'
			di "Mens role"
			tab mn_prdc`i'
		}
		
		*Intrahousehold food allocation decision criteria
		forval i=1/6 {
			tab fd_allc`i'
		}
	
		*Food shortage time remedies
		forval i=1/5 {
			tab fd_shrtge`i'
		}
			
	*Module VI. Household income and wealth

	*Module VIA. Household expenditures
		
		*Non-permanent expenditures
		ren matches match
		ren prsnl_cr prsnlcr
		foreach v of varlist match battery candle soap soap2 prsnlcr charcoal ///
							 firewood kerosene cigarette transport rent {
			di ""
			di "`:var label `v''"
			tab `v'
			gen val_`v' = qty_`v' * prc_`v'
			sum qty_`v' prc_`v' val_`v' 
// 			drop val_`v'
		}
			
		*Permanent expenditures
		foreach v of varlist cloth_ml cloth_fml cloth_boy cloth_girl utensils ///
							 linen furniture lamp ceremony iddir donation tax {
			di ""
			di "`:var label `v''"
			tab `v'
			gen val_`v' = qty_`v' * prc_`v'
			sum qty_`v' prc_`v' val_`v' 
// 			drop val_`v'
		}
				
	*Module VIB. Household assets
		loc asset k_stove cy_stove el_stove blanket bed watch telephone mobile ///
			 radio tv cd_plyr dish sofa bicycle motor pushed_cart animal_cart ///
			 sewing weaving mitad lakech fridge car gold silver wardrobe shelf ///
			 biogas water_pit sickle axe pick_axe plough_t plough_m water_pump
		foreach v of local asset {
			tab `v'
		}
	
	*Module VII. COVID-19
	
		*Knowledge
		tab hear_covid
		
		tab measr_covid
		forval i=1/7 {
			tab measr_covid`i'
		}
		
		tab stp_covid
		forval i=1/7 {
			tab stp_covid`i'
		}

		*Behavioural ans social distancing
		tab wash_why 
		tab sanitize 
		tab sanit_why 
		tab mask
		tab mask_why
		tab handshk
		tab hand_why
		tab gather
		tab gthr_why
		
		
		*Government response
		tab assstnce
		
		tab ass_srce
		forval i=1/6 {
			tab ass_srce`i'
		}
		
		tab ass_fair
		tab ass_grvnce
		tab vaccine_advc
		tab vaccintd
		tab vaccin_why
		tab vaccin_bstr
	
*===============================================================================
*Correcting cross questionnaire household ID
	import excel "matching ID for all questionnaires.xlsx" , firstrow clear

	label var HH_srvy_indx_anthr "_index in the Household Survey data for athropometry"
	label var HH_srvy_indx_fct   "_index in the Household Survey for Food Consumption Table"
	
	*Generate matching _index variables for food composition and anthropometry
	gen _index_anthr = _n
	label var _index_anthr "_index for anthropometry data"
	gen _index_fct   = _n
	label var _index_fct "_index for food composition table data"
	
	*Rename household_ID variables
	rename	anthro  		 hh_id_anth
	label var hh_id_anth "Household ID for anthropometry data"
	rename 	food_composition hh_id_fct
	label var hh_id_fct "Household ID for food composition table data"
	
	drop if hh_id_fct == ""
	drop hh_id_anth HH_srvy_indx_anthr oldnew_anth _index_anthr
	
	save "matching_id_fct", replace
	
*Calling household member's data and retain only households included in the food composition table
	use "rawdata_20220710\hhsvy.dta" , clear
// 	gen hh_id_fct 		 = household
	clonevar HH_srvy_indx_fct = _index
	clonevar oldnew_fct 	  = oldnew  	
	merge 1:1 HH_srvy_indx_fct oldnew_fct using "matching_id_fct"
// 	keep if _m==3
	drop _m
	save "rawdata_20220710\hhsvy_fct_hh_lvl.dta" , replace // Household level data for Food consumption Table 
	
	rename _index _parent_index
	
	merge 1:m _parent_index oldnew using "rawdata_20220710\hhsvy_mdl1.dta"
	keep if _m == 3
	drop _m
	
	isid _index oldnew
	clonevar _index1 = _parent_index
	save "rawdata_20220710\hhsvy_fct_indvdl_lvl.dta" , replace // Individual level data for Food Consumption Table
	
*===============================================================================
*** 							FOOD COMPOSITION							 ***
								  ***=====***	
	*Call the food composition table by food items from prepared database
		**Data source:
			// EHNRI. (1997). Food Composition Table for Use in Ethiopia Part II and IV: Vol III. 		Ethiopian Health and Nutrition Institute.
			// EHNRI, & FAO. (1995). Food composition table for use in Ethiopia, Part IV. EHNRI.

	import excel "food_composition_table_ETH.xlsx" , firstrow clear
	drop if itm_nm==""
	replace CHO = CHO-Fiber // CHO includes fiber
// 	tab CHO
	save   		 "food_composition_table_ETH" , replace
	
	*FCT data is for individual level data for a mother or under-five child
	*Bring member characteristics data to food composition table data
	
	*Call the food composition data
	use "rawdata_20220710\fdcmp_tbl.dta" , clear
	
	sort oldnew _index1 _index2 _index3 _index4
	order oldnew _parent_index _index1 _index2 _index3 _index4 fd_name item_number itm_nm
	br  oldnew _parent_index _index1 _index2 _index3 _index4 fd_name item_number itm_nm
	compare _index1 _index2 // identical
	
	*Merge with Food Consumption Table
	tab itm_nm
	merge m:1 itm_nm using "food_composition_table_ETH" 
	
	*Check if all itm_nm values from the survey are matched
	br if _m==1	
	tab itm_nm if _m==1
	tab itm_nm if _m==2  //These are not necessary because theya re not in the households' consumption fd_name

	keep if _m==3
	drop _m
	
	*Calculate macro and micro nutritient content
	gl nutrient 	FoodEnergy /// 
					Moisture   /// 
					Nitrogen Protein Fat CHO Fiber Ash ///
					Calcium Phosphorus Iron Zinc Copper Sodium Potassium /// 
					Bcarotene Thiamine Riboflavin Niacin Tryptophan Ascorbicacid Refuse
	foreach v of global nutrient {
		gen `v'_ttl = itm_wgt * (`v'/100)
 	} 
	
	sort oldnew _index1 _index2 _index3 _index4
	order _parent_index _index1 _index2 _index3 _index4 oldnew item_number fd_name itm_nm *_ttl
	br _parent_index _index1 _index2 _index3 _index4 oldnew item_number  fd_name itm_nm *_ttl
	compare _index1 _index2 // identical
	
	*Drop cases where itm_nm (which is meal) has fewer non-missing observations than item_number (sub-parts of a meal)
	drop if FoodEnergy== .
// 	bys _index2 		oldnew : gen itm_nm_cnt  = _N  // For example Injera bewot and atikilt by a person in a household
// 	bys _index2 _index3 oldnew : gen fd_name_cnt = _N  // For example Ijera, wot in Enjera bewot
	
	sort oldnew _index1 _index2
	br   oldnew _index1 _index2 itm_nm //itm_nm_cnt fd_name fd_name_cnt item_number
	
	*Only keep those with a similar constructed count 
	// 	keep if itm_nm_cnt == item_number
	
	*Keep only cases from new questionnaire form
// 	drop if oldnew==0

	*Bring in more individual and household characteristics
	ren oldnew oldnew_fct
	ren _index2 _index
	merge m:1 oldnew_fct _index using "rawdata_20220710\hhsvy_fct_indvdl_lvl" , force
	drop if _m == 2
	drop _m
	merge m:1 oldnew_fct _index using "rawdata_20220710\hhsvy_fct_hh_lvl"     , force
	drop if oldnew == .
	
	destring sex_of_househo Is_this_member Is_this_mother Age_1, replace
		
	*collapse data by persons
	collapse (mean) item_number sex_of_househo Is_this_member Is_this_mother Age_1 (firstnm) resp_name fd_name (sum)  *_ttl , by(_index1 _index oldnew)
		//Note: _parent_index has been changed to _index and _index has been changed to _index2
	
	drop if item_number==.
	drop if sex==1.5
	
// 	label define sex 2 "Male" 1 "Female"
	label val sex_of_househo sex
	
	label var Age_1  "Age of a household member"
	
	sort oldnew _index
	br _index oldnew item_number fd_name *_ttl

	*Visualizations
	graph bar FoodEnergy_ttl , over(sex) 
	
	gl nutrients 	FoodEnergy_ttl Moisture_ttl Nitrogen_ttl Protein_ttl Fat_ttl CHO_ttl /// 
					Fiber_ttl Ash_ttl ///
					Calcium_ttl Phosphorus_ttl Iron_ttl Zinc_ttl Copper_ttl Sodium_ttl ///
					Potassium_ttl Bcarotene_ttl Thiamine_ttl Riboflavin_ttl Niacin_ttl ///
					Tryptophan_ttl Ascorbicacid_ttl Refuse_ttl
**# Bookmark #4
					
	foreach v of global nutrients  {
		graph twoway scatter `v' Age_1 , xline(5) name(`v' , replace)
	}
	
	*Comparison of pregnant and lactating mothers	
	label define mother 1 "Pregnant" 2 "Lactating" 
	label val Is_this_mother mother 
	label var Is_this_mother "Mother"
	
	foreach v of global nutrients {
		graph bar `v' , over(Is_this_mother) name(bar_`v' , replace)
	}

	foreach v of global nutrients {
		graph twoway scatter `v' Age_1 if Is_this_mother==1, xline(5) name(psct_`v' , replace)
		graph twoway scatter `v' Age_1 if Is_this_mother==2, xline(5) name(lsct_`v' , replace)
		graph combine psct_`v' lsct_`v' , name(scttr_`v' , replace) xcomm ycomm
	}
	
	*====
	*Food Consumption Table for under-five children
	tab Age_1
				   
	foreach v of global nutrients {
		tab `v' if Age_1 < 5
	}
	
		
*===============================================================================
*** 							ANTHROPOMETRY (Only for c)							 ***
								  ***=====***
	
	*Family size
	use "rawdata_20220710\anthr_svy.dta" , clear
		
	tab numfamily 
	tab numchildren 
	tab numwomen 

	*Roaster
	use "rawdata_20220710\anthr_rstr.dta" , clear

	tab sex 
	sum age_years
	
	replace is_child = "0" if is_child=="false"
	replace is_child = "1" if is_child=="true"
	destring is_child , replace
// 	label drop is_child
	label define is_child 0 "No" 1 "Yes"
	label val is_child is_child
	tab is_child //child and under five == 1
	
	replace is_woman = "0" if is_woman=="false"
	replace is_woman = "1" if is_woman=="true"
	destring is_woman , replace
// 	label drop is_woman
	label define is_woman 0 "No" 1 "Yes"
	label val is_woman is_woman
	tab is_woman  // mother and pregnant | lactating ==1
	tab hh_position
		
	*Mother anthropometry
	use "rawdata_20220710\anthr_wmn.dta" , clear

	tab preg
	
	*Body Mass Index (BMI = wgt / (hgt^2))
	gen bmi = wom_wgt / (wom_hgt^2)
	label var bmi "Body Mass Index"
	
	loc wanthr woman_age_years wom_wgt wom_hgt wom_muac 
	foreach v of local wanthr {
		sum `v'
// 		tab `v'
		hist `v' , name(grph_`v', replace)
	}
	
	*Child anthropometry
	use "rawdata_20220710\anthr_chld.dta" , clear
	
	*Child position (order in age and birth respectively) in the hh and among siblings
	tab child_selected_position
	tab child_hh_position
	
	tab child_age_years
	tab months 
	hist child_age_years if child_age_years<=5 , name(child_age_years , replace)

	tab child_sex
	
	tab dob_known 
	tab birthdate 
	
	hist birthdate if birthdate>18263 
		
	tab edema 
	tab edema_confirm 

	tab measure  //Height measurement 

	loc canthr weight height muac_cm muac
	foreach v of local canthr {
		sum `v'
// 		tab `v'
		hist `v' if child_age_years<5, freq name(grph_`v', replace)
	}	
	
	*MUAC based malnutrition indicators
	tab sam_muac 
	tab mam_muac 
	tab sam
	
	*Additional malnutrition 
// 	loc addtn 	whz_neg3_boy whz_neg3_girl flag_whz_neg3 ///
// 				haz_lower_boy haz_upper_boy flag_haz_boy ///
// 				haz_lower_girl haz_upper_girl flag_haz_girl ///
// 				whz_lower_boy whz_upper_boy flag_whz_boy ///
// 				whz_lower_girl whz_upper_girl flag_whz_girl ///
// 				waz_lower_boy waz_upper_boy flag_waz_boy ///
// 				waz_lower_girl waz_upper_girl flag_waz_girl ///
// 				muac_lower_boy muac_upper_boy flag_muac_boy ///
// 				muac_lower_girl muac_upper_girl flag_muac_girl ///
// 				flag 
// 	foreach v of local addtn {
// 		destring `v' , replace force
// 		sum  `v'
// 		hist `v' , name(grph_`v' , replace)  discrete
// 	}

**Drop the variables from the questionnaire based anthropometry calculations

	*Calculating z-scores using the zscore06 module
	br months child_sex height weight edema
	zscore06 , 	a(age) 										  /// 
				s(child_sex) male(1)   		  female(2) 		  ///
				h(height)    measure(measure) stand(1)  recum(2)  ///
				w(weight) 										  ///
				o(edema) 	 oyes(1) 		  ono(0)
				
	tabstat haz06 waz06 whz06 bmiz06 , stat(mean sd p5 p10 p25 p50 p75 p90 p95)
			   
	*Alternative z-scores calculated using the zanthro module (includes MUAC / ACA)
	
	egen acaz = zanthro(muac_cm, aca, WHO) , xvar(age) gender(child_sex) gencode(m=1, f=2) ageunit(month) nocutoff
	
	egen whz = zanthro(weight ,wh, WHO) if measure==1 , xvar(height) gender(child_sex) gencode(m=1, f=2) nocutoff 
	egen wlz = zanthro(weight ,wl, WHO) if measure==2 , xvar(height) gender(child_sex) gencode(m=1, f=2) nocutoff

	egen haz = zanthro(height, ha, WHO) , xvar(age) gender(child_sex) gencode(m=1, f=2) ageunit(month) nocutoff
	egen waz = zanthro(weight, wa, WHO) , xvar(age) gender(child_sex) gencode(m=1, f=2) ageunit(month) nocutoff
	
	*BMI for under-five children and thresholds
	gen bmi   = weight / ((height/100)^2)
	
	sum bmi
	loc sd   = `r(sd)'
	loc mean = `r(mean)'
	gen bmi_z = (bmi - `mean') / `sd'
	hist bmi_z if child_age_years<=5
	
		*The abnormal thresholds fall between -2 and +2 standard deviations of the standardized BMI according to 
			*Haftom Gebrehiwot Weldearegay1* , Tesfay Gebregzabher Gebrehiwot1 , Mulugeta Woldu Abrha2 and Afework Mulugeta1 (2019)
	
	gen 	mbi_thr = .
	replace mbi_thr = 1 if bmi_z<-2
	replace mbi_thr = 0 if bmi_z>-2 & bmi_z<2
	replace mbi_thr = 2 if (bmi_z>2 & bmi_z<.)
	
*===============================================================================
*Correcting cross questionnaire household ID
	import excel "matching ID for all questionnaires.xlsx" , firstrow clear

	label var HH_srvy_indx_anthr "Household Survey _index for athropometry"
	label var HH_srvy_indx_fct   "Household Survey _index for Food Consumption Table"
	
	*Generate matching _index variables for food composition and anthropometry
	gen _index_anthr = _n
	label var _index_anthr "_index for anthropometry data"
	gen _index_fct   = _n
	label var _index_fct "_index for food composition table data"
	
	*Rename household_ID variables
	rename	anthro  		 hh_id_anth
	label var hh_id_anth "Household ID for anthropometry data"
	rename 	food_composition hh_id_fct
	label var hh_id_fct "Household ID for food composition table data"
	
	drop if hh_id_anth == ""
	drop hh_id_fct HH_srvy_indx_fct oldnew_fct _index_fct
	
	save "matching_id_anth", replace
	
*Calling household member's data and retain only households included in the anthropometry dataset
	use "rawdata_20220710\hhsvy.dta" , clear
	gen hh_id_anth 		   = household
	gen HH_srvy_indx_anthr = _index
	gen oldnew_anth  	   = oldnew  	
	merge 1:1 HH_srvy_indx_anthr oldnew_anth using "matching_id_anth"
	drop if _m==1
	drop _m
	save "rawdata_20220710\hhsvy_anth_hh_lvl.dta" , replace // Household level data for Food consumption Table 
	
	rename _index _parent_index	
	
	merge 1:m _parent_index oldnew using "rawdata_20220710\hhsvy_mdl1.dta"
	drop if _m == 2
	drop _m
	
	isid _index oldnew
	gen _index1 = _parent_index
	save "rawdata_20220710\hhsvy_anth_indvdl_lvl.dta" , replace // Individual level data for Food Consumption Table

*===
*Merge the three datasets (Household survey, food composition, and anthropometry) to make the BIG dataset
	
	use "rawdata_20220710\hhsvy.dta" , clear
	
	merge 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	