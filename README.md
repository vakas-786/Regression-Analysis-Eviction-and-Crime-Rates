# Econometric Analysis of Eviction and Violent Crime Rates 
My final assignment for my Econometrics class this past spring required me to perform a regression analysis on a topic of my choice. At the time, the pandemic was raging on in the months of March and April as I was completing my senior year from home as classes were now online. I decided to perform a regression analysis comparing eviction rates with violent crime. I also included unemployment rates as evictions are mostly caused by missed payments due to factors such as unemployment. I used R to run my regressions and perform other tests. My code can be found in the file labeled <a href="https://github.com/vakas-786/Regression-Analysis-Eviction-and-Crime-Rates/blob/main/Vakas_project.R">Vakas_project.R</a>, I included comments for readers to follow along and see what my code did. To view my <b>full analysis</b> you can find it <a href="https://vakas-786.github.io/Regression-Analysis-Eviction-and-Crime-Rates/Econometrics%20Final%20Paper.pdf">here</a>. Below you can find a <b>condensed version</b> of my conclusions. Enjoy!

# Data 
To properly measure the effects of eviction rates on crime, data on unemployment rates were also collected since one of the main causes of evictions are missed payments from tenants who do not have access to sufficient amounts of capital due to, most commonly, unemployment.<br></br>
Data was collected from the following sources:
* <a href="https://www.bls.gov/">United States Bureau of Labor</a>
* <a href="https://evictionlab.org/">The Eviction Lab</a>
* <a href="https://www.ucrdatatool.gov/Search/Crime/State/RunCrimeStatebyState.cfm">Uniform Crime Reporting Statistics, FBI</a>

# Equations 
The OLS regression models used for the experiment were as follows:

* Crime = β0 + β1Eviction + β2Unempl + β3State + β4Time + u
* Crime = β0 + β1lag_Evict + β2lag_Unempl + β3State + β4Time + u
* Crime = β0 + β1Eviction + β2lag_Evict + β3lag_Unempl + β4State + β5Time + u
* Ch_Crime = β0 + β1Ch_Evict + β2Ch_Unempl + u

# Results 
<img src="/graphs/Regression Evic, Unempl, Crime.png" />
The analysis results prove that eviction rates were statistically significant as it had a p-value of .04. It was also economically significant as violent crime rates increased by around 5 per increase in eviction rates. Unemployment rates interestingly had a negative relationship to violent crime rates. Meaning, as unemployment rates increased, violent crime rates decreased. Based on the regression models <b>unemployment is not responsible for increases in violent crime</b>. Rather, homelessness greatly contributes to increased violent crime rates. Unemployment is an unreliable variable when trying to understand the causes for increased violent crime rates due to variables outside of the model such as amount of police, education, and poverty levels. <br>   To preserve the quality of life around the nation the government must focus its resources on making sure that tenants are granted rent relief. It would be best to pass legislation that would delay rent payments for the time being. The primary focus should be to ensure that citizens are granted housing rather than employment to quell an increase in violent crime rates.


# Libraries 
* <a href="https://www.rdocumentation.org/packages/stargazer/versions/5.2.2/topics/stargazer">stargazer<a/>
* <a href="https://www.rdocumentation.org/packages/lmtest/versions/0.9-38">lmtest</a>
* <a href="https://cran.r-project.org/web/packages/sandwich/index.html">sandwhich</a>
* <a href="https://cran.r-project.org/web/packages/car/index.html">car</a>
