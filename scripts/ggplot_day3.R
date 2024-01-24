#plotting data
plt <- ggplot(
  data = surveys_complete,
  mapping = aes(x = weight, y = hindfoot_length)
) #we created an object plt, but it doesnt show anything, we neeed to add layers

plt +
  geom_point() + #this creates a scatterplot (adds a geometry layer)
  ggtitle("My first plot!") #this adds a title
