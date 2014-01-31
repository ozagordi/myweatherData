IsDateInvalid <- function (date) {
  # d <- try( as.Date( date, format= "%d-%m-%Y %H:%M:%S" ) ) #original
  d <- try( as.Date( date) )
  if( class( d ) == "try-error" || is.na( d ) )  {
    print(paste( "Invalid date supplied", date ))
    return(1)
  }
  #TODO:
  #If a date in the future is supplied, print an error message
  
  return(0) #is okay
}

#' @title Check if the station type is airportCode or id
#' @description We are checking if a valid station type was given to the function.
#' @param station_type can be \code{airportCode} which is the default, or it
#'  can be \code{id} which is a weather-station ID
#'  @seealso getStationCode
IsStationTypeInvalid <- function (station_type) {
    if(station_type != "airportcode" && 
         station_type != "id")  {
      warning(paste( "Invalid station_type supplied", station_type ))
      return(1)
    }
    return(0) #is okay
  }
  

readUrl <- function(final_url) {
  out <- tryCatch({
    #if you want to use more than one R expression in the "try" part use {}
    # 'tryCatch()' will return the last evaluated expression 
    # in case the "try" part was completed successfully  
    #message("This is the 'try' part")  
    u <- url(final_url)  
    # readLines(u, warn=FALSE) 
    readLines(u) 
    # The return value of `readLines()` is the actual value 
    # that will be returned in case there is no condition 
    # (e.g. warning or error). 
    # You don't need to state the return value via `return()` as code 
    # in the "try" part is not wrapped insided a function (unlike that
    # for the condition handlers for warnings and error below)
  },
  error=function(cond) {
    message(paste("URL does not seem to exist:", final_url))
    message("The original error message:")
    message(cond)
    return(NA)  # Choose a return value in case of error
  },
  warning=function(cond) {
    message(paste("URL caused a warning:", final_url))
    message("Here's the original warning message:")
    message(cond)
    # Choose a return value in case of warning
    return(NA)
  },
  finally=  close(u)
  #   # NOTE:
  #   # Here goes everything that should be executed at the end,
  #   # regardless of success or error.
  #   # If you want more than one expression to be executed, then you 
  #   # need to wrap them in curly brackets ({...}); otherwise you could
  #   # just have written 'finally=<expression>' 
  #   message(paste("Processed URL:", url))
  #   message("Some other message at the end")
  # }
  )    
  return(out)
}