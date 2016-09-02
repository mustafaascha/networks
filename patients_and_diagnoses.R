#One of the issues that I'm running into is the creation of an edge list (or adjacency matrix) from a list of patient identifiers and associated diagnoses. 

# For example, the data I have may look like this: 

pt_diags <- 
  data.frame(patient_id = rep(1:20, 5),
            diagnosis = round(runif(n = 100, min = 70, max = 100)))

# The goal with these data is to produce an edge list of which diagnoses co-occur, such as
# diag1 diag2
# 72    90
# 85    90
# 82    90
# 95    90

# You'll notice that all of these relate to the same second diagnosis. This would be an example of diagnoses in a single patient that co-occur with diagnosis code 90. 

# My initial thought would be to split the dataframe into a list of each patient, each containing a list of diagnosis codes. From there, I can examine combinations of diagnosis codes for each patient. 

# split by patient

pt_diags <- 
  split(pt_diags$patient_id, pt_diags$diagnosis)

# make combinations

pt_diags <- 
  lapply(pt_diags, combn, m = 2)

# each element now has the form of a 10 x 2 table. I'll have to transpose, convert to a data.frame, bind_rows, and I should be good to go

pt_diags <- 
  lapply(pt_diags, t)

pt_diags <- 
  lapply(pt_diags, data.frame)

pt_diags <- 
  dplyr::bind_rows(pt_diags)

# great, looks like this works. Now to make it work for gigabytes of data.....will probably use more dplyr and less base-r




