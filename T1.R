# Import the training set: train
train_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
train <- read.csv(train_url)

# Import the testing set: test
test_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
test <- read.csv(test_url)

# Your train and test set are still loaded in
str(train)
str(test)

# Copy of test
test_one <- test

# Initialize a Survived column to 0
test_one$Survived <- 0

# Set Survived to 1 if Sex equals "female"
test_one[test_one$Sex=='female',]$Survived <- 1



library(rpart)
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
str(my_tree_two)

library(rattle)
library(rpart.plot)
library(RColorBrewer)

fancyRpartPlot(my_tree_two)

# my_tree_two and test are available in the workspace

# Make predictions on the test set
my_prediction <- predict(my_tree_two, newdata = test, type = "class")


# Finish the data.frame() call
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Use nrow() on my_solution
nrow(my_solution)

# Finish the write.csv() call
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)