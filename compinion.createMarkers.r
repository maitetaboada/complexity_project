#### create lists of mpqa subjectivity markers for each category (negative, positive, neutral)

#dependencies
library("textstem")

#read all markers per category
df = read.csv("working/compinion/markers/neutral_mpqa.csv")

#create list of stemmed markers
df.stemmed = df[df$stemmed == "y" & df$pos != "anypos",]

#add stems
df.stemmed$stems = stem_words(df.stemmed$words)

#assign postags to (Stanford POS tagset) pos categories
df.stemmed$postag <- with(df.stemmed, ifelse(
  pos == "noun" , '_nn', ifelse(
  pos == "adj", '_jj', ifelse(
  pos == "verb", '_vb', '_rb'))))

#write.csv()

############ step of manual screening and cleaning of stems ##############

#add search pattern for all entries
df.stemmed = read.csv("working/temp/negative.stemmed_mpqa_temp.csv")

df.stemmed$pattern = paste("^", df.stemmed$stems, "[a-z]*_vb", sep="")

##create list of unstemmed and postagged markers; retrieve according to postags from ST postagged texts

df.pos = df[df$stemmed == "n" & df$pos != "anypos",]

#assign postags to pos categories
df.pos$postag <- with(df.pos, ifelse(
  pos == "noun" , '_nn', ifelse(
  pos == "adj", '_jj', ifelse(
  pos == "verb", '_vb', '_rb'))))

df.pos$pattern = paste("^", df.pos$words, df.pos$postag, sep ="")

#write.csv() to save lists


#create list of markers that are "anypos"; retrieve as exact
#matches from raw texts

df.anypos = df[df$pos == "anypos",]

#create search pattern
df.anypos$pattern = paste("^", df.anypos$words, "$", sep ="")

#write.csv()


