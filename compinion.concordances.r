##code to lemmatise the compinion corpus and retrieve concordances of subjectivity

#dependencies
source("working/rscripts/corpus_preparation.r")
library("textstem")

#read corpus files
data = read.corpus("working/temp/")


#remove punctuation using
clean.data = gsub('[[:punct:] ]+',' ', tolower(data))

#lemmatisation with textstem
#create lemma dictionary using treetagger
dict = make_lemma_dictionary(clean.data, engine="treetagger", path="bin/treetagger/")

#lemmatise
#lem.data = lemmatize_strings(clean.data, dictionary = dict)

#apply to corpus
lem.data = sapply(clean.data, function(x) lemmatize_strings(x, dictionary = dict))

#retrieve subjectivity markers
#create lists of markers to be retrieved
#neutral mpqa
neutral = read.csv("working/compinion/subjectivity/neutral_mpqa.csv")

neutral.marker = paste("^", neutral$neutral_marker, "$", sep ="")

neutral.matches = paste(unique(neutral.marker), collapse ="|")

#negative mpqa
neg = read.csv("working/compinion/subjectivity/negative_mpqa.csv")

neg.marker = paste("^", neg$neg.marker, "$", sep ="")

neg.matches = paste(unique(neg.marker), collapse ="|")

#positive mpqa
pos = read.csv("working/compinion/subjectivity/positive_mpqa.csv")

pos.marker = paste("^", pos$pos.marker, "$", sep ="")

pos.matches = paste(unique(pos.marker), collapse ="|")


#split lemmatised text into words
word.lems = sapply(lem.data, function(x)  unlist(wordsplit(x)))

#match markers and count

neutral.matched = sapply(word.lems, function(x) grep(x, pattern = neutral.matches, value =T))

neutral.freqs = sapply(neutral.matched, function(x) length(unlist(x)))

neg.matched = sapply(word.lems, function(x) grep(x, pattern = neg.matches, value =T))

neg.freqs = sapply(neg.matched, function(x) length(unlist(x)))

pos.matched = sapply(word.lems, function(x) grep(x, pattern = pos.matches, value =T))

pos.freqs = sapply(pos.matched, function(x) length(unlist(x)))

#save frequency counts to csv

df = data.frame(neutral.freqs, neg.freqs, pos.freqs)

colnames(df) <- ("text", "neutral_markers", "negative_markers", "positive_markers")

#retrieve markers from pos-tagged texts
neg = read.csv("working/compinion/markers/negative_mpqa.csv")

#assign postags to pos categories
neg$postag <- with(neg, ifelse(
  pos == "noun" , '_nn', ifelse(
  pos == "adj", '_jj', ifelse(
  pos == "anypos", '', ifelse(
  pos == "verb", '_vb', '_rb')))))


neg.marker = paste("^", neg$words, neg$postag, sep ="")

neg.matches = paste(unique(neg.marker), collapse ="|")

#split text into words and lowercase
word.data = sapply(data, function(x)  unlist(wordsplit(tolower(x))))

#grep will only process about 2000 items at a time
#TO DO split pattern into two or three parts
neg.matched = sapply(word.data, function(x) grep(x, pattern = neg.matches, value =T))

neg.freqs = sapply(neg.matched, function(x) length(unlist(x)))




