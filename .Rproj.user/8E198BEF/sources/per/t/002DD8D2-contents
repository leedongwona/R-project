
########################## 크롤링 함수 ##########################

function_01 = function(url, pagemax, title){
  
  library(httr)
  library(rvest)
  library(RSelenium)
  library(stringr)
  library(dplyr)
  library(readr)
  
  rd = rsDriver(chromever = "106.0.5249.61", 4445L, 
                remoteServerAddr="localhost" , check = F)
  
  remDr = rd$client
  
  remDr$navigate(url)
  
  remDr$executeScript("window.scrollTo(0, 50000)")
  Sys.sleep(1)
  el2 = remDr$findElement(using = "css", value = "#review > li.on > a")
  el2$clickElement()
  Sys.sleep(1)
  
  
  df_replies = data.frame()
  
  
  
  for(i in 1:pagemax){
    page = remDr$getPageSource()[[1]]
    new_replies = read_html(page) %>% 
      html_nodes(css="div.box_detail_review ul.board_list div.comment_wrap div.txt") %>% 
      html_text()
    
    new_replies = str_trim(new_replies, side = "both")
    
    df_new_replies = data.frame(reply = new_replies)
    
    df_replies = rbind(df_replies, df_new_replies)
    
    if(i == pagemax){
      
      break
    }
    
    elem = remDr$findElement(using = "css", value = "div.list_paging.align_center > div > a > img[alt='다음 페이지로 이동']")
    elem$clickElement()
    Sys.sleep(10)
    
  }
  
 
  rd$server$stop()
  write.table(df_replies, file=title , quote = T, row.names = F, col.names = c("reply"), fileEncoding = "utf-8", sep = ",")
 
  
  return(df_replies)
  
}


a = function_01("http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9791191891201",
            11, "너에게_이동원.txt")








########################## 저장 함수 ##########################

function_save = function(savetitle){
  
  write.table(df_replies, file=savetitle , 
              quote = T, row.names = F, 
              col.names = c("reply"), fileEncoding = "utf-8", sep = ",")
  
}







########################## 불러오기 함수 ##########################

function_read = function(savetitle){
  
  read.table(file=savetitle, sep = ",", fileEncoding = "utf-8", 
             col.names = c("reply"), header = T)
  
}

d = function_read("너에게_이동원.txt")







########################## 전처리 함수 ##########################



function_02= function(save_1){
  
  library("stringr")
  library("dplyr")
  
  z = save1
  
  z_r = str_replace_all(z$reply, "\\W"," ")
  
  nouns = strsplit(z_r, " ")
  
  wordcount = nouns %>% unlist() %>% table()
  
  df_word =  as.data.frame(wordcount, stringsAsFactors = F)
  
  df_word = rename(df_word,
                   word = .,
                   freq = Freq)
  
  df_word2 = filter(df_word, nchar(word) >= 2)
  
  return(df_word2)
  
}

b = function_02(a)








########################## 분석 함수 ##########################

function_03 = function(save_2){
  
  library(dplyr)
  
  
  df_word3 = save2 %>% arrange(desc(freq))
  
  df_word3 %>% head(200)
  df_word3 %>% str()
  df_word3 %>% View()
  
  return(df_word3)
  
}

c = function_03(b)
c







########################## 시각화 함수 ##########################

function_04 = function(save_3, imgtitle){
  
  library("multilinguer") 
  library(KoNLP)
  library("wordcloud")
  
  
  pal = brewer.pal(8, "Dark2")
  
  imgFile = imgtitle
  windows()
  
  wordcloud(words = save_3$word,
            freq = save_3$freq,
            min.freq = 1,
            max.words = 200,
            random.order = F,
            rot.per = .5,
            scale= c(4, 0.3),
            colors = pal
  )
  
  savePlot(imgFile, type = "png")
  
}



