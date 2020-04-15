
--------------------------------------------------------------------------------------------------------------------------

  Code demo software for "Formant Tracking"

Paper referred: 
	A Mixture Model approach for Formant tracking and the robustness of student's-t Distribution
	Harshavardhan Sundar, Student Member, IEEE, Chandra Sekhar Seelamantula, Member, IEEE, and
	Thippur V. Sreenivas, Senior Member, IEEE
                                 
------------------------------------------------------------------------------------------------------------------------------------
 Contents
------------------------------------------------------------------------------------------------------------------------------------

All the programs are packed in the subfolder for each method.
please run Formant Demo.m for viewing the output
      This file calls Desa.m(Which gives out the AM-FM components by MDA)
                      Gabor1d_i.m(Which gives out the filter coefficients given the order and the center frequency)
                      intialize_kk(This is for intialize the parameters of the Mixture model TMM using K means)
                      student_t_mixture(This file is for Expectation Maximization of parameters of model fitting)
                       
Inputs:*)speech wave form
       *)fb file from VTR database,which contains the formant details(for comparison) 
Given these inputs this code will generate 
Output:*) we will get a pruned pyknogram with both the formant tracks our approach and the reference avaliable
       *) Mean square error with orginal one 



------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
