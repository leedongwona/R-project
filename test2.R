
z 

function_02 = function(txtname){
  
  library(ggplot2)
  library("multilinguer") 
  library(KoNLP)
  library("stringr")
  library("dplyr")
  library("wordcloud")
  
  
  z= read.table(file=txtname, sep = ",", 
                fileEncoding = "utf-8", col.names = c("reply"), header = T)
  
  z_r = str_replace_all(z$reply, "\\W"," ")
  
  nouns = strsplit(z_r, " ")
  
  wordcount = nouns %>% unlist() %>% table()
  
  df_word =  as.data.frame(wordcount, stringsAsFactors = F)
  
  df_word = rename(df_word,
                    word = .,
                    freq = Freq)
  
  df_word2 = filter(df_word, nchar(word) >= 2)
  
  df_word2 = df_word2 %>% filter(!word == "FFFD")
  
  df_word3 = df_word2 %>% arrange(desc(freq))
  
  pal = brewer.pal(8, "Dark2")
  
  imgFile = "wc.png"
  windows()
  
  wordcloud(words = df_word3$word,
            freq = df_word3$freq,
            min.freq = 1,
            max.words = 200,
            random.order = F,
            rot.per = .5,
            scale= c(4, 0.3),
            colors = pal
  )
  savePlot(imgFile, typle = "png")
}

function_02("너에게_이동원.txt")


