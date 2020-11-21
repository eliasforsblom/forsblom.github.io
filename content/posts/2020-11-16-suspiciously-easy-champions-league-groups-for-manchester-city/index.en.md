---
title: Suspiciously easy champions league groups for Manchester city?
author: Elias Forsblom
date: '2020-11-17'
slug: []
categories:
  - Data analysis
tags:
  - data analysis
  - data analytics
  - champions league
  - R
description: ''
thumbnail: images/tn.png
---

*Or just a silly comment made by rival football fans?*

2 months ago the 2020-21 seasons champions league group stage was drawn and both on pubs and on the internet you could hear and read about Manchester citys - once again - shockingly easy draw. Trying to be as unbiased as I can as a Chelsea supporter I looked at the 2020-21 drawings as well as previous drawings and couldn't help feeling that Manchester citys groups the past 4 years do seem to be suspiciously easy, but from experience I am also aware that just looking at the different club names trying to form an opinion without being biased is quite hard if not impossible, especially looking a couple years back trying to remember how great a specific club was that specific year. 

This made me curious and decided to try to se if I could find any statistical evidence that could support the theory of Manchester city being drawn into suspisously easy groups. 

First of all, I needed to find the datasets that would allow me to do the testing and I began with the easiest, the different groups that had been drawn between 2014 and 2020. When doing the tests I am using data from every group, not only Manchester citys group, but for the sake of getting a break from this block of text and practice making tables in Markdown I will preview  Manchester citys group from 2014 to 2020.

| 2020-21    | 2019-20  | 2018-19    | 2017-18   | 2016-17         | 2015-16         | 2014-15        |
|------------|----------|------------|-----------|-----------------|-----------------|----------------|
| Man City   | Man City | Man City   | Man City  | Man City        | Man City        | Man City       |
| Olympiakos | Atalanta | Lyon       | Shaktar   | Barcelona       | Juventus        | Bayern Munchen |
| Porto      | Shaktar  | Shaktar    | Napoli    | Mönchengladbach | Sevilla         | Roma           |
| L'OM       | Zagreb   | Hoffenheim | Feyenoord | Celtic          | Mönchengladbach | CSKA Moscow    |


The second dataset I had to aqquire to be able to do the testing was a dataset that ranked how great a club was for the specific year. It may sound very easy, but how do you rank a clubs accomplishment for a specific season, and how would someones assumptions make it statistically correct? I decided to make it easy for myself and use UEFA's club coefficient rank, after all thats the coefficient that UEFA uses when making the drawing pools for the lottery, which ultimately is what I want to try to find differences in. Here are some previews of the UEFA club coefficient rankings.

| Season | 2020-21            | 2019-20        | 2018-19         | 2017-18        | 2016-17               | 2015-16              | 2014-15              |
|--------|--------------------|----------------|-----------------|----------------|-----------------------|----------------------|----------------------|
| 1      | Bayern Munchen     | Bayern Munchen | Real Madrid     | Real Madrid    | Real Madrid           | Real Madrid          | Real Madrid          |
| 2      | Barcelona          | Real Madrid    | Atletico Madrid | Bayern Munchen | Bayern Munchen        | Barcelona            | Barcelona            |
| 3      | Real Madrid        | Barcelona      | Bayern Munchen  | Barcelona      | Barcelona             | Bayern Munchen       | Bayern Munchen       |
| ...    | ...                | ...            | ...             | ...            | ...                   | ...                  | ...                  |
| 198    | Riga FC            | FK Kukësi      | Lyngby BK       | SønderjyskE    | Admira Wacker Mödling | KF Skënderbeu        | Helsingborgs IF      |
| 199    | Progrès Niederkorn | AS Trenčín     | SønderjyskE     | Randers FC     | Shakhter Karagandy    | Servette FC          | Kardemir Karabükspor |
| 200    | FC Vaduz           | Mladá Boleslav | Randers FC      | Nordsjælland   | Helsingborgs IF       | Hapoel Kiryat Shmona | FC Midtjylland       |

If you happen to watch football at all, you have probably already realized by looking at the bottom of the UEFA club ceofficient rankings that there was a huge portion of the data that I did not use.

When starting this little proejct I hadn't given myself time to think about how I would actually conduct the different tests I had to do in order to acually get some answers to the questions, so when I had gathered the data I belived I needed to be able to conduct the test I started to clean and process the data so R would be able to understand it and so that it would make sense to the purpose. 

I started with calculating the mean club rank for every group and for every season and this is what I ended up with (Manchester citys groups is in bold)

| Group   | 2020-21  | 2019-20   | 2018-19   | 2017-18   | 2016-17   | 2015-16   | 2014-15 |
|---------|----------|-----------|-----------|-----------|-----------|-----------|---------|
| Group A | 18,5     | 32,5      | 20        | 20        | 25,25     | 33,25     | 46,5    |
| Group B | 24       | 28,75     | 26,5      | 22,5      | 23,5      | 32,5      | 35,75   |
| Group C | **27,5** | **28,75** | 30,5      | 27,25     | **24,75** | 44,75     | 26,25   |
| Group D | 41,25    | 20,75     | 39        | 18,75     | 33,75     | **20,75** | 25,25   |
| Group E | 32,25    | 28        | 36,5      | 50        | 29,25     | 34        | **25**  |
| Group F | 32,25    | 27        | **36,25** | **26,75** | 34,75     | 29,5      | 25,25   |
| Group G | 40       | 22        | 22,75     | 35,5      | 44,25     | 36,25     | 34      |
| Group H | 23,75    | 45,25     | 29,5      | 21,25     | 29,75     | 34,75     | 30,25   |

I do believe that this data is quite bland to just look at without the raw data, but dont worry, all the raw data will be uploaded to Github.

Without taking anything for granted, just by looking at the mean values of the groups that Manchester city was in I get a feeling that the suspiciousness of Manchester citys easy groups may have been a bit exaggerated... But that is up to the tests to prove! (To put it simple and a tiny but dumbed down, low mean value = hard champions league group)

After calculating the means of each group, I decided to scale down on the amount of teams I choose to look futher into as a lot of the teams did not make any logical sense to analyse and I decided to keep the 15 richest teams[LÄGG TILL REFERENS!] - which includes Manchester city - as those teams may be considered as the 15 biggest clubs in the world, which puts them in the same category as Manchester city. Here are the 15 clubs that is concidered to be europes biggest clubs.

| Club              |
|-------------------|
| Real Madrid       |
| Manchester United |
| Bayern Munchen    |
| Barcelona         |
| Manchester City   |
| Chelsea           |
| Liverpool         |
| Arsenal           |
| Tottenham         |
| Juventus          |
| PSG               |
| Atletico madrid   |
| Dortmund          |
| Schalke           |
| Inter             |

I decided to process the data a bit more after shrinking it down to only 15 clubs as well, and added a coefficient value that would serve as a better reflection on how "easy" the teams group actually were, taking in to consideration the teams own ranking (as it earlier had an impact on the groups mean value making team such as Real Madrid which oftenly ranked high seem to have very hard groups since their own rank dragged down the mean quite a lot). This was done by simply subtracting the clubs club coefficient ranking from the groups mean value for each year. The data that I will import to R will now looks like this.

| Coefficient | Club              | Season  |
|-------------|-------------------|---------|
| 21          | Real Madrid       | 2020-21 |
| 16,75       | Manchester United | 2020-21 |
| 17,5        | Bayern Munchen    | 2020-21 |
| 38          | Barcelona         | 2020-21 |
| ...         | ...               | ...     |
| 12,25       | Dortmund          | 2014-15 |
| 27          | Schalke           | 2014-15 |
|             | Inter             | 2014-15 |

As you can see on for example Inter, there are some missing values as every club didnt participate in champions league each season since they didnt manage to qualify, for the sake of keeping this quite easy as a first post, I will not be imputing these values, but in a later stage when I feel more comfortable with the whole blogdown idea I will hopefully revisit this data and make more accurate models, but for now we keep it simple.

It was finaly time to import the data in to R and start doing some statistical test, so I did.

```python
cl_data <- read.csv("cl_data.csv", header = TRUE, sep = ";", dec = ",")
str(cl_data)

modell1 <- aov(Index ~ Club, cl_data)
cl_df <- tapply(cl_data$Index, cl_data$Club, summary)
```
setting up and running our one-way anova model gives us the following mean values.

```python

cl_df
                team      mean
1            arsenal 16.666667
2    atletico_madrid 26.214286
3          barcelona 25.321429
4     bayern_munchen 25.642857
5            chelsea 24.400000
6           dortmund 16.050000
7              inter -8.833333
8           juventus 22.714286
9          liverpool 18.100000
10   manchester_city 17.678571
11 manchester_united 12.187500
12               psg 19.892857
13       real_madrid 27.785714
14           schalke 17.000000
15         tottenham  8.937500
```

Once again, just by looking at these fitted values for the one-way anova model we can assume that manchester city in no way have been favoured in the champions league group drawings, it even looks like they have had quite hard groups. 

Before continuing with some actual tests, I will do a quicker visual analysis of the residuals by setting up a **VERY SIMPLE**  four-in-one plot in R.

```python

par(mfrow=c(2,2))

soda.stdres <- rstandard(modell1)
qqnorm(soda.stdres)
qqline(soda.stdres)

hist(soda.stdres)

plot(soda.stdres)
lines(soda.stdres)
title("Residuals VS Order")

fv1 <- fitted.values(modell1)
plot(x = fv1, y = soda.stdres)
title("residuals VS fits")

```
![Example image](/images/fourinone.jpeg)

By just looking at the four-in-one plot we can see that the residuals isnt perfectly normally distributed and could probably be looking better with some additional processing of the data, but for the sake of keeping this post very simple, we wont. The Residuals VS order as well as the residuals VS fits graphs seems to look good, as the residuals in the Residual VS order does not seem to follow any particular pattern, as well as residuals VS fits graph looking quite stationary, even though it may look like we might have an outlier. 


So now that we have done a simple residual analysis, I wanted to see if we had some significant differences between the clubs difficulty level.

```python
anova(modell1)[1,]

Analysis of Variance Table

Response: Index
     Df Sum Sq Mean Sq F value      Pr(>F)    
Club 14 4676.2  334.01   4.763 0.000006598 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

``` 

By analysing the anova-table, we can se that there are some significant differences between the clubs and some futher analysis of where the differences are, would be interesting. 

we conduct another test to find out where the differences are, and choose to only present the differences that is significant at a significance level of 0.05.

```python
B <- emmeans(modell1, specs = "Club")
D <-pairs(B)
diffs <-  summary(D,adjust = "tukey")
diffs

significantdiffs <- diffs %>% filter(p.value < 0.05)
significantdiffs

                  contrast  estimate       SE df   t.ratio        p.value
1          Arsenal - Inter  25.50000 6.837439 65  3.729467 0.028150059688
2  Atletico madrid - Inter  35.04762 5.778691 65  6.064976 0.000007411012
3        Barcelona - Inter  34.15476 5.778691 65  5.910467 0.000013561737
4   Bayern Munchen - Inter  34.47619 5.778691 65  5.966090 0.000010916376
5          Chelsea - Inter  33.23333 6.115591 65  5.434198 0.000084386145
6         Dortmund - Inter  24.88333 6.115591 65  4.068835 0.010082115656
7         Inter - Juventus -31.54762 5.778691 65 -5.459302 0.000076748696
8        Inter - Liverpool -26.93333 6.115591 65 -4.404044 0.003389350678
9  Inter - Manchester City -26.51190 5.778691 65 -4.587874 0.001814260530
10             Inter - PSG -28.72619 5.778691 65 -4.971055 0.000468205253
11     Inter - Real Madrid -36.61905 5.778691 65 -6.336911 0.000002531404
12 Real Madrid - Tottenham  18.84821 5.248756 65  3.590987 0.041705064288
``` 
with a significance level of 0.05 it seems like the only significant differences we where able to find where that Inter seems to have had quite hard groups (which is something I will adress later, as it isnt really true), as well as Real Madrid looking to have significantly easier groups than Tottenham. 

At this time, we have steered away from the main point of this blogpost a bit, since we saw quite eary that there probably wouldnt be so interesting in looking closer into Manchester city with the data we have available as well as with the simple analysis methods we are using for this blogpost. 

I also want to clarify that we obviously can't make any assumptions regarding wheter or not they have had easy drawings, and the same goes for all the other teams such as for example Inter who might have been portrayed as having very easy groups through out this blogpost, and the main reason are because of these problems that I will list:


 - One may argue that the coefficient I calculated to differentiate how easy groups some team may have had wasn't really as accurate as it could have been as there are more variables that have effect on the drawings than what I took in to account for. For example, the drawings are divided into four different pools, and there would of been interesting to test the differences between the differents pools as just having a fourth team with a very low UEFA coefficient rank that drags the mean value of the entire group down isn't really a great way to represnt how easy said group actually is.
 
 - The statistical modelling was done at a very basic level, as well as lacking in a lot of scientific areas as no hypothesis where set up, and the tests not nessecarily following the text book steps in one-factor anova modelling. But bear in mind that this is not a a showcase of my statistical skillset, but a way for me to practice and get acquainted with Hugo themes, github and data analysis blogging in general
 
 - The initial UEFA club coefficient may not be a great represenation in how great a club is. This can of course be discussed for ages, however I found it to be the closest to an unbiased opinion as possible. Maybe in the future there would be interesting to ask the same question but instead of using the UEFA club coefficient, one could use data from companies specialized in analysing football such as twelve.football. 
 
 - A lot of the differences found, in for example Inters case, strictly depend on Inter missing champions league for some years, which made them have a much lower UEFA club coefficient ranking for when they actually got to participate in the champions league, while still getting placed in decently high drawing pools, making them have a skewed coefficient.
 
However, looking at the data I have acquired and the tests I have made I do find it an interesting topic to analyse futher, and I will probably visit this topic - or at least something simillar - in the future with a bigger focus on statistics and data anlysis. 
