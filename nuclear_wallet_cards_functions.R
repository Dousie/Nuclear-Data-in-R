# Routines that are called from nuclear_wallet_cards_main.R.



# Trims leading and trailing whitespaces from strings.
trim <- function (x) gsub("^\\s+|\\s+$", "", x)


# Converts the second character in a string to lowercase.
second_down <- function(x) {
  substr(x, 2, 2) <- tolower(substr(x, 2, 2))
  x
}




get_tab_nuc <- function(path_data, file_data) {
  # Reads nuclear-wallet-cards.txt.
  # Leading and trailing whitespaces are removed. 
  temp <- readLines( paste(path_data, file_data, sep = "\\") )
  headers <- c("F indicates 235 U fission product", 
               "A", 
               "M indicates isomeric state",
               "Z", 
               "Element", 
               "J pi", 
               "decay mode", 
               "% Branch", 
               "excitation energy (MeV)", 
               "Q value (MeV)", 
               "T1/2", 
               "Abundance", 
               "Atomic mass (MeV)", 
               "Uncertain in mass (MeV)",
               "S if mass from systematics", 
               "Date (ignore)", 
               "T1/2 in seconds")
  tab_nuc <- data.frame(matrix(NA, end(temp)[1], length(headers)))
  colnames(tab_nuc) <- headers
  
  tab_nuc$`F indicates 235 U fission product` <- trim( substr(temp, 1, 1) )
  tab_nuc$A                                   <- trim( substr(temp, 2, 4) )
  tab_nuc$`M indicates isomeric state`        <- trim( substr(temp, 5, 5) )
  tab_nuc$Z                                   <- trim( substr(temp, 7, 9) )
  tab_nuc$Element                             <- trim( substr(temp, 11, 12) )
  tab_nuc$`J pi`                              <- trim( substr(temp, 17, 26) )
  tab_nuc$`decay mode`                        <- trim( substr(temp, 31, 34) )
  tab_nuc$`% Branch`                          <- trim( substr(temp, 35, 41) )
  tab_nuc$`excitation energy (MeV)`           <- trim( substr(temp, 43, 49) )
  tab_nuc$`Q value (MeV)`                     <- trim( substr(temp, 50, 56) )
  tab_nuc$`T1/2`                              <- trim( substr(temp, 64, 80) )
  tab_nuc$Abundance                           <- trim( substr(temp, 82, 96) )
  tab_nuc$`Atomic mass (MeV)`                 <- trim( substr(temp, 98, 105) )
  tab_nuc$`Uncertain in mass (MeV)`           <- trim( substr(temp, 106, 113) )
  tab_nuc$`S if mass from systematics`        <- trim( substr(temp, 115, 115) )
  tab_nuc$`Date (ignore)`                     <- trim( substr(temp, 118, 123) )
  tab_nuc$`T1/2 in seconds`                   <- trim( substr(temp, 125, 132) )

  tab_nuc[tab_nuc == ""] <- NA

  return(tab_nuc)
}


clean_tab_nuc <- function(tab_nuc) {
  # Converts a number of columns from string to numeric.
  # Moves second character in element name to lower case.
  col_names <- colnames(tab_nuc)
  index <- which( col_names == "A" | 
                    col_names == "Z" |
                    col_names == "excitation energy (MeV)" |
                    col_names == "Q value (MeV)" |
                    col_names == "Atomic mass (MeV)" |
                    col_names == "Uncertain in mass (MeV)"  |
                    col_names == "T1/2 in seconds"
                    )
  tab_nuc[index] <- lapply(tab_nuc[index], as.numeric)
  
  tab_nuc$Element <- second_down( tab_nuc$Element )
  
  return(tab_nuc)
}
