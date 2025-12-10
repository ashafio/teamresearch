# Simplest test plot in R
dev.new()
x <- 1:10
y <- x^2

plot(x, y,
     main = "Test Plot",
     xlab = "X",
     ylab = "Y",
     pch = 19)

