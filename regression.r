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
wilcox.test( d$combined_education ~ d$imigrant > 0 )
wilcox.test( d$income ~ d$imigrant > 0 )

d$has_children = d$v321 > 0
d$political = d$v265_LR

### full model
m1 <- lm( income ~ ( imigrant > 0 ) + combined_education + has_children + age + political, d )
summary( m1 )


m2 <- data.frame( d$combined_education, d$has_children, d$age, d$political, d$imigrant )

m2$imigrant = mean( d$imigrant, na.rm = T )

m2$income <- m1$coefficients[1] + m1$coefficients[3] * m2$d.combined_education + m1$coefficients[4] * m2$d.has_children +
m1$coefficients[5] * m2$d.age + m1$coefficients[6] * m2$d.political + m1$coefficients[2] * m2$imigrant

wilcox.test( m2$income ~ m2$d.imigrant > 0 )
