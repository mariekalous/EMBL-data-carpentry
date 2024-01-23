weight_g <- c(50, 60, 65, 80) #creates a vector

animals <- c("mouse", "rat", "dog")

length(animals) #gets the length of the vector

class(weight_g) #get the type of data
str(animals) #get the structure of the object
animals <- c("cincilla", animals) #add an element to the beginning of the vector
animals <- c(animals, "frog") #adds an element to the end of the vector
animals

#subsetting a vector
animals [2]
animals[c(1, 2)]

more_animals <- animals[c(1, 2,3, 2, 1, 4)]
more_animals
 weight_g
weight_g[c(FALSE, FALSE, TRUE, TRUE)] #DISCARDS THE FIRST TWO ELEMENTS AND KEEPS THE LAST TWO
weight_g > 63
weight_g [weight_g > 63] #shows values larger than 63
weight_g[weight_g > 63 & weight_g < 80] #both logicals are valid
weight_g[weight_g < 58 | weight_g > 80] #vertical line meand that either one of the logicals is valid

animals[animals == "rat" | animals == "frog"]
#%in% helps us find all elements corresponding to a vector of elements of our choice
animals %in% c("rat", "frog", "cat", "duck", "dog")
animals

#an example of a vector with missing data
heights <- c(2, 4, 4, NA, 6)
mean(heights, na.rm = T) #removes missing values
