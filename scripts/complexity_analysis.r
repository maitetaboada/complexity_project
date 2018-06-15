#compinion complexity analysis

source("working/rscripts/corpus_preparation.r")

#apply distcomp.loop
result = measure.complexity("working/compression/", 1000)

write.csv(result, "working/compinion_result_1000reps.csv")


#get complexity scores and file sizes

df = data.frame(
      synratio = sapply(result, function(x) x$synratio),
      morphratio = sapply(result, function(x) x$morphratio),
      orig.uncomp = sapply(result, function(x) x$orig.uncomp),
      orig.comp = sapply(result, function(x) x$orig.comp)
)

#insert rownames
filenames = rownames(result[[1]])
rownames(df) = filenames


#calculate average morphological/syntactic complexity scores
df$meansynratio = rowMeans(df[1:1000])      #rowMeans(data.frame(sapply(result, function(x) x$synratio)))
df$meanmorphratio = rowMeans(df[1001:2000])


#standard deviation of morphological/syntactic complexity scores
df$syn.sd = apply(df[1:1000], 1, sd)
df$morph.sd = apply(df[1001:2000], 1, sd)


######adjusted overall complexity scores
df$average.orig.uncomp = rowMeans(df[2001:3000])
df$average.orig.comp = rowMeans(df[3001:4000])

#calculate regression residuals
df$average.comp.res = resid(lm(df$average.orig.comp ~ df$average.orig.uncomp)

#standard deviation of compressed/uncompressed file sizes
df$orig.uncomp.sd =  apply(df[2001:3000], 1, sd)
df$orig.comp.sd =  apply(df[3001:4000], 1, sd)


#save scores and stats
write.csv(df, "working/compinion_scores_1000reps.csv")




