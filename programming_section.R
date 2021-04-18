################################################################################
# Alex Bartlett
# March 13, 2021
#
# use binary search to count occurrences of an element in a sorted array of 
# integers
################################################################################

# return # of occurrences of m in X if m ix in X. If not, returns NA
occurrences <- function(X, m){
  
  # get location of first occurrence of m in X
  len = length(X)
  i = first_location(X, m, 1, len, len)
  
  # if m not in X, return 0
  if (i == 0)
    return(0)
  
  # get location of last occurrence of m in X (must be after first location)
  j = last_location(X, m, i, len, len)

  # return length of subarray between i and j aka number of occurrences of m
  count = j - i + 1
  return(count)
}

# return index of first occurrence of m in X. If m not in X, return NA
first_location <- function(X, m, start, end, len){

  
  # find midpoint of array to divide for searching (must be integer)
  if (end >= start)
    middle <- floor((start + end)/2)
  # in case we have gone past end of array
  else
    return(0)
  
  # if m is greater than X's midpoint value, search back half of X
  if (m > X[middle])
    return(first_location(X, m, middle + 1, end, len))
  
  # if m is less than X's midpoint value, search front half of X
  else if (m < X[middle])
    return(first_location(X, m, start, middle - 1, len))
  
  # if m equals X's midpoint value
  else if (m == X[middle]){
    # if this is the first occurrence of m, return it
    if (m > X[middle - 1] || middle == 1){
      return(middle)
    }
    # if not, keep searching earlier portion of array
    else
      return(first_location(X, m, start, middle - 1, len))
  }

  return(0)
  
}

# return index of last occurrence of m in X. If m not in X, return NA
last_location <- function(X, m, start, end, len){
  

  # find midpoint of array to divide for searching (must be integer)
  if (end >= start)
    middle <- floor((start + end)/2)
  # in case we have gone past end of array
  else
    return(0)
  
  # if m is greater than X's midpoint value, search back half of X
  if (m > X[middle])
    return(last_location(X, m, middle + 1, end, len))
  
  # if m is less than X's midpoint value, search front half of X
  else if (m < X[middle])
    return(last_location(X, m, start, middle - 1, len))
  
  # if m equals X's midpoint value
  else if (m == X[middle]){
    # if this is the last occurrence of m, return it
    if (middle == len || m < X[middle + 1]){
      return(middle)
    }
    # if not, keep searching latter portion of array
    else
      return(last_location(X, m, middle + 1, end, len))
  }
  
  return(0)
}

# testing
array <- c(2,3,4,4,4,5,6,7,7)
stopifnot(occurrences(array, 4) == 3)
stopifnot(occurrences(array, 5) == 1)
stopifnot(occurrences(array, 2) == 1)
stopifnot(occurrences(array, 7) == 2)
stopifnot(occurrences(array, 8) == 0)

array <- c(7,7,7,7,7,7,7,7,7,7)
stopifnot(occurrences(array, 7) == 10)
