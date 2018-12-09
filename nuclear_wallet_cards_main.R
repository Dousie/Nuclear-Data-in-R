# Reads the Nuclear Wallet Cards into R.
# References:
# Data provided by: Nuclear Wallet Cards, J.K. Tuli, 2011, National Nuclear Data Center, Brookhaven National Laboratory.
# Reading these cards using Python: https://github.com/jhykes/nuclide-data

# Initalising folders and functions ----
path_main <- getwd()
file_data <- "nuclear-wallet-cards.txt"
source("nuclear_wallet_cards_functions.R")

# Read nuclear wallet cards, clean the data. ----
tab_nuc <- get_tab_nuc(path_main, file_data)
tab_nuc <- clean_tab_nuc(tab_nuc)

# Add neutron numbers ----
tab_nuc$N <- tab_nuc$A - tab_nuc$Z

# Examples:
# Subset isotopes with Z = 10: 
# subset_Z10 <- tab_nuc[ which( tab_nuc$Z == 10) , ]

# Subset elements with A = 10: 
# vector_elements <- unique( tab_nuc$Element[which( tab_nuc$A == 10)] )