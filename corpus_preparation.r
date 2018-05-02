#functions to prepare files and corpora


read.file <- function(filename) {
	paste(readLines(filename, encoding="UTF-8"), collapse="\n")
}

fileslist <- function(dir) {
	as.list(sapply(list.files(dir), function(x) { file.path(dir, x) }))
}

read.corpus <- function(dir) {
	f = fileslist(dir)
	sapply(f, function(file) {
		content <- read.file(file)
	})
}

writetofile <- function(output, targetdir, filename) {
	writeLines(output, con=file.path(targetdir, filename), sep = "\n")
}
	
write.corpus <- function(corpus, dir){
	dir.create(file.path(dir, "corpus/"))
	targetdir = paste(dir, "corpus/", sep="/")

        lapply(names(corpus), function(x){
                filename = x
		writetofile(corpus[[x]], targetdir, filename)
        })
}

trim.leadingnewline = function(s) {
	sub("^\\n", "", s)
}

normalise.spaces = function(s) {
        gsub("\\.\\s+", "\\.", s)
}


wordsplit <- function(s) {
	strsplit(s, "\\s+")
}

sentencesplit <- function(s) {
	 unlist(strsplit(s, "\\."))
}


#sample number of words in full sentences
#function takes output from  normalise.spaces(x), sentencesplit(x), wordsplit(x)
sample.wordsentences <- function(s, nwords){

        nwords_need = nwords
        nwords_have = 0

        i = 0   

        while (nwords_have < nwords_need){
                i = i + 1
                nwords_have = nwords_have + length(s[[i]])      
                }
        result <- s[1:i]           
        return(result)
}

##sample n-number of running words; takes outut from wordsplit; read in as corpus through read.corpus
sample.words <- function(wordcorp, nwords) {

words = lapply(wordcorp, function(x) unlist(x)[1:nwords])

}


#get length in sentences of smallest file in corpus
min.sentences <- function (corpus) {
	sentences = lapply(corpus, function (x) {
                sentencesplit(x)
        })

	min(sapply(sentences, length))
}


sample.sentences <- function(corpus, nsentences) {
        sentences = lapply(corpus, function (x) {
                sentencesplit(x)[1:nsentences]
        })
}



samplenwrite.sentences <- function(corpus, nsentences, dir) {
	s = sample.sentences(corpus, nsentences)
	
	write.corpus(s, dir)
}



sample.runningtext <- function(dir, filename, targetdir, nwords) {
	content <- read.file(file.path(dir, filename))
	clean <- remove_corpusmarkup(content)
	words <- wordsplit(clean)[1:nwords]
	writeLines(words, con=file.path(targetdir, filename))
}



#wordsplit <- function(s) {
#	unlist(strsplit(s, "\\s+"))
#}

#sentencesplit <- function(s) {
#	unlist(strsplit(gsub("\\.", "\\.\\!", s), "\\!"))
#}

#remove markup in FRED and ICE
remove.corpusmarkup <- function(x) {
	gsub("\\[[^]]*\\]|<[^>]*>|\\([^)]*\\)|#|\\{[^}]\\}|--", "", x)
}


#tag random tokens with "R100_" for POS-tagging
randomtagger <- function(words, nwords) {
	len <- length(words)
	positions <- sample.int(len, min(nwords, len), F)
	
	for(p in positions)
		words[p] = paste("R1000_", words[p], sep="")

	words
}

#tag random tokens with "R100_" across several files
tagmanyfiles <- function(dir, targetdir, nwords) {
	files <- list.files(dir)
	wordlists <- lapply(files, function(file) {
		content <- read.file(file.path(dir, file))
		wordsplit(remove_corpusmarkup(content))
	})

	lens <- sapply(wordlists, length)
	totallen <- sum(unlist(lens))

	words <- unlist(wordlists)
	taggedwords <- randomtagger(words, nwords)

	pos = 0;
	for (i in 1:(length(lens))) {
		nextpos = pos + lens[i]
		string <- paste(taggedwords[pos:nextpos], collapse=" ")
		writeLines(string, con=file.path(targetdir, files[i]))
		pos = nextpos
	}
}

#sample R1000_ tagged tokens
#r1000pos = grep("R1000_", hwords)

#for (p in r1000pos[101:1000]) { hwords[p] = sub("^R1000_", "", hwords[p]) }

#hwordsclean = gsub("-[A-Z0-9]{3}([.,?`])?", "\\1", hwords)

