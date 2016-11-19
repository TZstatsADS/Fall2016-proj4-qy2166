# Project: Words 4 Music

### [Project Description](doc/Project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**courseworks login required**)
+ [Data description](doc/readme.html)
+ Contributor's name: Qing Yin
+ Collaborate with Tian Sheng, Yaqing Xie, Yueqi Zhang, Sen Zhuang
+ Project title: Rock On Lyrics
+ Project summary: In this project, given some fields associated with a song (such as start time of each bar, start time of each beat, start time of each section, etc.), I am trying to predict what kinds of lyrics may appear in this song. The general training procedures are as follows: 1. Feature Extraction (in this step, I will extract specific features from those given fields); 2. Song Labelling and Probability Computation (in the training data sets, I am given the lyrics and their frequencies in each song, so in this step, I will use "topic modelling" method to derive top topics and give each song a specific topic, and at the same time, compute the probability of a specific word in a song given the song is in a specific topic); 3. Song Classification (in this step, I will use Random Forest to derive a probability matrix with each row specified as the probabilities that each song belongs to specific topics); 4. Lyric Prediction (in this step, I will use the formula (sum P(word in a song|topic_k)P(topic_k|features of a song)) to compute the probability of each word in each song, and then I can treat the top words as the possible lyrics). Through this project, I have learned how to extract music features, how to do topic modelling, how to do classification with multiple classes and how to use Bayes Rule in Data Science. 
+ [Project report](output/report.Rmd)
	
Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
