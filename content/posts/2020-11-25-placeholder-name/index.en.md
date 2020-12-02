---
title: Placeholder name
author: Elias Forsblom
date: '2020-11-25'
slug: []
categories:
  - Spotify API
  - data science
  - Data analysis
tags:
  - spotify api
  - data science
  - R
  - data analysis
  - data analytics
description: ''
thumbnail: images/tn.png
---

Inspired by the incredible post "Using Data to Find the Angriest Death Grips Song" by Evan Oppenheimer *(Link in the end of this post)* I decided I also would play around and get acquainted with the spotify API and at the same time get to better my skills in data science overall. 

Going into this "project", and even by the time of starting to write this post I had no idea of what I actually wanted to do, so the first thing I did was to explore the spotify API to see what options i had and if there was someting that I would find intereseting to dig deeper into. 

I installed the spotify API package

```Python

install.packages('spotifyr')
devtools::install_github('charlie86/spotifyr')
library(dplyr)
library(knitr)

Sys.setenv(SPOTIFY_CLIENT_ID = 'THISISASECRET')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'THISISASECRET')

access_token <- get_spotify_access_token()

```
and instantly started to play around with some of the functions, such as get_artist_audio_features().

```Python

paramore <- get_artist_audio_features('paramore')

```

I looked around in the dataset it created and noticed the column named "valence", which spotify themselves says "describes the musical positiveness conveyed by a track". Tracks with high valence sound more positive, while tracks with low valence sound more negative.

I remebered that I recently had read another data science post regarding the spotify API, where the author was testing if the different european countries had differences in the enjoyment of sad music, in other words, if some countries listen to music with a lower value of valence *(Link in the end of this post)*.

This made me curious, could Covid-19 have an effect on which music we choose to listen to? And more specifically, could Covid-19 possible effect us into listening to sadder music than usual? Or maybe happier? Either way, I decided that I would try to look in to it!

The first step was to gather the data, and luckily spotify have the top 200 global music well documented for the last 4 years. Unfortunately though, it was only possible to download 1 week worth of the top 200 list at a time. It would of taken to much time to manually download 208 weeks worth of .csv documents so I decided to settle with analyzing 1 specific week for all the years, the last week of mars. The reasoning behind choosing the last week in mars was quite simlpe, it was one of the thougher weeks through this pandemic and if there would be a significant effect on what music we choose to listen to, it would probably be noticable for that specific week. 

The raw data looked like this when I imported it to R.

| 2017 | Position | Track name        | Artist           | Streams  |
|------|----------|-------------------|------------------|----------|
|      | 1        | Shape of you      | Ed Sheeran       | 48548944 |
|      | 2        | Passionfruit      | Drake            | 32675350 |
|      | 3        | It ain't me       | Kygo             | 28840908 |
|      | ...      | ...               | ...              | ...      |
|      | 198      | The greatest      | Sia              | 3245105  |
|      | 199      | White Iverson     | Post Malone      | 3243171  |
|      | 200      | It's gotta be you | Isaiah Firebrace | 3234882  |

| 2018 | Position | Track name                   | Artist       | Streams  |
|------|----------|------------------------------|--------------|----------|
|      | 1        | God's Plan                   | Drake        | 42879151 |
|      | 2        | Psycho (feat. Ty Dolla $ign) | Post Malone  | 31221103 |
|      | 3        | SAD!                         | XXXTENTACION | 27215954 |
|      | ...      | ...                          | ...          | ...      |
|      | 198      | Stay                         | Zedd         | 3711565  |
|      | 199      | I Dont Wanna Live Forever    | Zayn         | 3698909  |
|      | 200      | Wild Thoughts                | DJ Khaled    | 3697677  |

| 2019 | Position | Track name        | Artist         | Streams  |
|------|----------|-------------------|----------------|----------|
|      | 1        | 7 rings           | Ariana Grande  | 31265664 |
|      | 2        | Con Calma         | Daddy Yankee   | 31111446 |
|      | 3        | Sucker            | Jonas Brothers | 26364572 |
|      | ...      | ...               | ...            | ...      |
|      | 198      | bad idea          | Ariana Grande  | 4485687  |
|      | 199      | Thinking out Loud | Ed Sheeran     | 4484846  |
|      | 200      | In My Blood       | Shawn Mendes   | 4467407  |

| 2020 | Position | Track name                       | Artist       | Streams  |
|------|----------|----------------------------------|--------------|----------|
|      | 1        | Blinding Lights                  | The Weeknd   | 52375259 |
|      | 2        | The Box                          | Roddy Ricch  | 33753609 |
|      | 3        | Dance Monkey                     | Tones And I  | 31463007 |
|      | ...      | ...                              | ...          | ...      |
|      | 198      | Girls Like You (feat.   Cardi B) | Maroon 5     | 4515388  |
|      | 199      | changes                          | XXXTENTACION | 4507185  |
|      | 200      | esta cabron se yo                | Bad Bunny    | 4438261  |

After the data was imported to R, I had to first convert the track names to track-ids, as that was not a part of the dataset that I got from spotifycharts. I created a for-loop - with help from the already existing search function from the spotifyr package - that could conduct the search for the track-id as well as creating a vector to store the ids in.

```Python
for(i in 1:length(top2017vecw)){
  search <- search_spotify(top2017vecw[i], type = "track", limit = 1)
  top2017idw[i] <- search$id
}
```

Once all the track-ids was gathered, I had wanted to find out the tracks valence values.

```Python
af2017w <- get_track_audio_features(top2017idw[1:100])
af20172w <- get_track_audio_features(top2017idw[101:200])

head(valenceanalysis)
  valence year   weight
1   0.931 2017 48548944
2   0.364 2017 32675350
3   0.539 2017 28840908
4   0.446 2017 27218668
5   0.781 2017 24106534
6   0.839 2017 23272542
```

At this point, I am finally ready to conduct some testing. 

```Python
meansbar <- summarySE(valenceanalysis, measurevar="valence", groupvars=c("year"))

ggplot(meansbar, aes(x=year, y=valence)) + 
  geom_bar(position=position_dodge(), colour = "black", stat="identity", aes(fill = year)) +
  geom_errorbar(aes(ymin=valence-ci, ymax=valence+ci),
                width=.2,                   
                position=position_dodge(.9)) +
  theme_bw() +
  scale_fill_brewer(type = "qual", palette = 8)
```

![Valence mean](/images/valancemean.jpeg)

Above you can see the mean valence plotted against each year, with an associated confidence interval with a confidence grade of 95%. By looking at this graph, we can quite confidently say that Covid-19 at least did not have an effect on the valence of the music climbs into the top 200 charts.

I decided to conduct a test either way, since this plot did not take the amount of streams into account.

```Python
model <- aov(valence ~ year, weights = weight, data = valenceanalysis)
anova(model)
Analysis of Variance Table

Response: valence
           Df    Sum Sq Mean Sq F value Pr(>F)
year        3    670019  223340  0.5325 0.6601
Residuals 796 333877154  419444
```

Looking at the P-value from the row 'year', we can see that neither the model which uses the number of streams as a weight shows any significant differences.

In other words, by doing this analysis I could not find anything that indicates some type of behaviour chnage in what music we have chosen to listen during one of the rougher week - considering death's - during this pandemic. However, I do belive that there could still be valuable to look deeper into the subject and maybe analyse the the entierty of the year - or pandemic period - once it is over, maybe we could be able to see a pattern of changed behaviour throughout the period? Or maybe a week worth of data isnt enough to see a difference. It is also hard to say that a week in Mars is where people would have started to change behaviour, after all, the pandemic had only been present in europe for a couple of months and even though it was a rough week concidering death cases, I have nothing else that indicates that the last week of mars would be worse than a random week in for example August when people had been in the pandemic for a much longer time, with restrictions and everything that it means. I will definitley revisit this topic once the pandemic is over!

And as promised, here are the blogposts i referred to in the text:

[Using Data to Find the Angriest Death Grips Song](https://towardsdatascience.com/angriest-death-grips-data-anger-502168c1c2f0)

[Sentiment analysis of musical taste: a cross-European comparison](http://paulelvers.com/post/emotionsineuropeanmusic/) 

 