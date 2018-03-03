
setwd("I:\\my_ml\\Dataset")
getwd()

install.packages("arulesViz")
### Support, COnfidence, lift
library(arules)
Grocery_Data = read.csv("groceries_200.csv")
#Purchase data at a grocery store contains 9,835 transactions .
groceries <- read.transactions("http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml13/groceries.csv", sep = ",")
summary(groceries)
?inspect
# Display top five transactions
inspect(groceries[1:5])
itemFrequency(groceries[, 1:3])
## Plot the frequency of items
itemFrequencyPlot(groceries, support = 0.1)
# Plot top 20 items in terms of frequency

itemFrequencyPlot(groceries, topN = 20)

#a visualization of the sparse matrix for the first five transactions
image(groceries[1:5])

##visualization of a random sample of 100 transactions
image(sample(groceries, 100))
#Training a model on the data

# Below with default settings result in zero rules learned
apriori(groceries)

size(head(groceries)) # number of items in each observation
rules <- apriori(groceries, parameter = list(supp = 0.001, conf = 0.8))
# Show the top 5 rules, but only 2 digits
options(digits=2)
inspect(rules[1:5])

# Support 
#The support of a product or set of products is the fraction of transactions in our data set that contain that product or set of products.


# Confidence is conditional probability that customer buy product A will also buy product B.
# Example : Out of 200 customers who bought Product A, 100 bought Product B too.COnfidence is 50 %

## Lift : If someone buys Product A,  what % of chance of buying product B would increase.
#A lift > 1 indicates that the presence of A has increased the probability that the product B will occur on this transaction.
#A lift < 1 indicates that the presence of A has decreased the probability that the product B will occur on this transaction
rules
# summary of grocery association rules
summary(rules)
inspect(rules[1:3])


# Step 5: Improving model performance

inspect(sort(rules, by = "lift")[1:5])
# Insights from above line
### Personal who brought Liquor,red/blush wines 
##The first rule, with a lift of about 19, implies that people who buy liquor/Red wine are nearly 19 times more likely to buy bottled beer than the typical customer
## may be Beer for self and red wine for wife/GF. :)

# Finding subsets of rules containing any berry items
## The firest rule with a lift of 10 implies , person buying berries is 10 times likely to buy whole milk
berryrules <- subset(rules, items %in% "berries")
write(rules, file = "groceryrules_john.csv",
      sep = ",", quote = TRUE, row.names = FALSE)
inspect(berryrules)
