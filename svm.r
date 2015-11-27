library('e1071')

library('foreign')

d <- read.spss("data2.sav" , to.data.frame = T )

d$income = d$v353M_ppp

## my home country v255
d[ !( d$v255 %in% c('yes', 'no') ) , ] <- NA

## spouse home country
d[ !( d$v342 %in% c('yes', 'no') ) , ] <- NA

d$imigrant <- as.integer( d$v342 ) + as.integer( d$v255 ) - 2

## education level
d$combined_education = as.integer( d$v344 ) + as.integer( d$v336 )

## check that combined_education is linked to imigrant status

d$has_children = d$v321 > 0
d$political = d$v265_LR

## train the two models

dd <- data.frame( income = d$income,
                  imigrant = d$imigrant,
                  combined_education = d$combined_education,
                  has_children = d$has_children,
                  political = d$political,
                  age = d$age )

dd <- dd[ complete.cases( dd ), ]

d0 <- dd[ dd$imigrant == 0, ]
d1 <- dd[ dd$imigrant > 0, ]

## model D0

index <- 1:nrow( d0 )
testindex <- sample(index, trunc( length(index) * 1 / 3 ) )

d0train <- d0[testindex,]
d0test <- d0[-testindex,]

gamma = 2^-10:0
cost = seq(1, 10, 0.5)
tune <- tune( svm , as.integer( income * 10 ) ~ + combined_education + has_children + age + political , data = d0train, cross = 2,
  ranges = list( gamma = gamma , cost = cost ), ## ranges = list( gamma = seq(0, 4, 0.05), cost = seq( 0.05 , 4, 0.05) ),
  tunecontrol = tune.control(
      best.model = T
  )
)

d0model <- tune$best.model

final <- data.frame( imigrant = d0test$imigrant , income = predict( d0model, d0test ) ) ## build a final model we can use to run wilcox

index <- 1:nrow( d1 )
testindex <- sample(index, trunc( length(index) * 1 / 3 ) )

d1train <- d1[testindex,]
d1test <- d1[-testindex,]

gamma = 2^-10:0
cost = seq(1, 10, 0.5)
tune <- tune( svm , as.integer( income * 10 ) ~ + combined_education + has_children + age + political , data = d1train, cross = 2,
  ranges = list( gamma = gamma , cost = cost ), ## ranges = list( gamma = seq(0, 4, 0.05), cost = seq( 0.05 , 4, 0.05) ),
  tunecontrol = tune.control(
      best.model = T
  )
)

d1model <- tune$best.model

temp <- data.frame( imigrant = d1test$imigrant , income = predict( d1model, d1test ) )
final <- rbind( final, temp )

wilcox.test( final$income ~ final$imigrant > 0 )
