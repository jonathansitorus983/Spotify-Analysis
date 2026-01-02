#dataset is spotify
install.packages("modeest")
library(modeest)
df <- ProjectPhase2_ExcelDataFile_Spotify

#5 measures of location
summary(df$popularity)
mean_spotify <- mean(df$popularity)
median_spotify <- median(df$popularity)
mode_spotify <- mfv(df$popularity)
min_spotify <- min(df$popularity)
max_spotify <- max(df$popularity)

print(mean_spotify)
print(median_spotify)
print(mode_spotify)
print(min_spotify)
print(max_spotify)

#5 dispersion of popularity
range_spotify <- max_spotify - min_spotify
var_spotify <- var(df$popularity)
sd_spotify <- sd(df$popularity)
iqr_spotify <- IQR(df$popularity)
cv_spotify <- (sd_spotify / mean_spotify)


print(range_spotify)
print(var_spotify)
print(sd_spotify)
print(iqr_spotify)
print(cv_spotify)

#scatterplots
num_vars <- df[, c("popularity", "year", "bpm", "danceability", "valence", "duration")]
pairs(num_vars)
cor(num_vars)

#regression
cor.test(df$popularity, df$danceability)

#regression model
reg1 <- lm(popularity ~ year+bpm+danceability+valence+duration, data = df)
summary(reg1)

#variance
library(car)
model <- reg1
residualPlots(model,quadratic=F,fitted=F)
qqPlot(model$residuals,envelope=F)
hist(model$residuals)
ncvTest(model)
shapiro.test(model$residuals)
durbinWatsonTest(model)



#new variable
df$dancepop <- ifelse(df$genre == "dance pop", 1, 0)
reg2 <- lm(popularity ~ year + bpm + danceability + valence + duration + dancepop, data = df)
summary(reg2)
