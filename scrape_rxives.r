# Author: Lars Hubatsch
# Scraping is largely taken from a blog post of Paul Hook at
# https://pwh124.github.io/blog/2018/04/17/2018-03-18-scraping-biorxiv-part-2-navigating-javascript-in-r/
# Major difference in scraping: phantomjs is deprecated, now using firefox instead
# Good to know: trailing or leading white spaces in links can cause issues
# Returns: -1 if no link in column
#          -2 if link exists but cannot be assigned, this is for debugging
#           0 not published yet
#           1 published/peer-reviewed

library(RSelenium)
library(rvest)
library(magrittr)
library(readxl)

# Read xlsx file
sheet <- read_excel("~/Desktop/Covid19_2.xlsx")

# Start browser session
driver<- rsDriver(browser="firefox")
# Sys.sleep(10) # Apparently not necessary
remDr <- driver[["client"]]
# remDr$open(silent = TRUE) # Also not necessary

x <- c()
for (n in seq(1, nrow(sheet), 1)){
 if (is.na(sheet[n,1])){
   print("No link.")
   x[n] <- -1
 } else{
# Navigate to link, extract static AND dynamic content
remDr$navigate(toString(sheet[n,1]))
hlink <- remDr$getPageSource()[[1]] %>% read_html()

# Get the element that contains the journal
pub_string <- hlink %>%
  html_nodes(".pub_jnl") %>%
  html_text() %>%
  extract(1) %>%
  strsplit(" ") %>%
  unlist()

# Check whether published
if("preprint" %in% pub_string & "article" %in% pub_string){
  pub_doi <- "NA"
  x[n] <- 0
} else if ("Now" %in% pub_string & "published" %in% pub_string){
  pub_doi <- tail(unlist(strsplit(pub_string, " ")),1)
  x[n] <- 1
} else{
  x[n] <- -2
}
print(x)
}
}

# Close connections/stop browser
remDr$close()
driver[["server"]]$stop()