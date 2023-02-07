
########################## 크롤링 함수 ##########################

function_01 = function(searchname, product_number){
  
  library(httr)
  library(rvest)
  library(RSelenium)
  library(stringr)
  library(dplyr)
  library(readr)
  
  
  
  
  rd = rsDriver(chromever = "latest", 4445L, 
                remoteServerAddr="localhost" , check = F)
  Sys.sleep(5)
  
  remDr = rd$client
  
  
  url = c()
  url_1 = "https://www.oliveyoung.co.kr/store/search/getSearchMain.do?query="
  url_2 = "&giftYn=N"
  url_search = searchname
  
  
  url = paste0(url, url_1)
  url = paste0(url, url_search)
  url = paste0(url, url_2)
  
  
  remDr$navigate(url)
  Sys.sleep(3)
  
  el = c()
  el_left = "div#ajaxList ul#w_cate_prd_list:nth-child("
  el_1 = ifelse(product_number%%4 ==0, product_number%/%4, product_number%/%4+1 )
  el_mid = ") > li:nth-child("
  el_2 = product_number%%4
  el_2 = ifelse(product_number%%4 == 0, 4, el_2)
  el_right = ") > div > a > img"
  
  el = paste0(el, el_left)
  el = paste0(el, el_1)
  el = paste0(el, el_mid)
  el = paste0(el, el_2)
  el = paste0(el, el_right)
  
  el2 = remDr$findElement(using = "css", value = el)
  
  el2$clickElement()
  Sys.sleep(3)
  
  
  page = remDr$getPageSource()[[1]]
  
  remDr$executeScript("window.scrollTo(0, 50000)")
  Sys.sleep(1)
  
  review = remDr$findElement(using = "css", value = "#reviewInfo > a") 
  review$clickElement()
  Sys.sleep(2)
  
  review_count = read_html(page) %>% 
    html_nodes(css="#reviewInfo > a > span") %>% 
    html_text()
  
  review_count = str_replace_all(review_count, "\\W","") %>% as.numeric()
  p = ifelse(review_count%%10 == 0, review_count%/%10, review_count%/%10+1) 
  
  df_replies =sS data.frame()
  Sys.sleep(2)
  
  
  for(i in 1:p){
    
    page = remDr$getPageSource()[[1]]
    
    new_replies = read_html(page) %>% 
      html_nodes(css="#gdasList > li > div.review_cont > div.txt_inner") %>% 
      html_text()
    
    new_replies = str_trim(new_replies, side = "both")
    
    df_new_replies = data.frame(reply = new_replies)
    
    df_replies = rbind(df_replies, df_new_replies)
    
    if(i == p){
      
      break
    }
    
    click = remDr$findElement(using = "css", value = "#gdasContentsArea > div > div.pageing > strong + a")
    click$clickElement()
    
    Sys.sleep(5)
    
  }
  
  
  rd$server$stop()
  
  return(df_replies)
  
}

# 스킨 23번째 제품
a = function_01("스킨", 23)





########################## 저장 함수 ##########################


function_save = function(savedata, savetitle){
  
  write.table(savedata, file=savetitle , 
              quote = T, row.names = F, 
              col.names = c("reply"), fileEncoding = "utf-8", sep = ",")
  
}

# 스킨 23번째 제품
function_save(a, "anua.txt")






########################## 불러오기 함수 ##########################


function_read = function(savetitle){
  
  read.table(file=savetitle, sep = ",", fileEncoding = "utf-8", 
             col.names = c("reply"), header = T)
  
}







########################## 전처리 함수 ##########################



function_02= function(save_1){
  
  library("stringr")
  library("dplyr")
  
  z = save_1
  
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

# 스킨 23번째 제품
b = function_02(a)






########################## 분석 함수 ##########################

function_03 = function(save_2){
  
  library(dplyr)
  
  
  df_word3 = save_2 %>% arrange(desc(freq)) %>% head(200)
  
  df_word3 %>% str()
  df_word3 %>% View()
  
  return(df_word3)
  
}


# 스킨 23번째 제품
c = function_03(b)






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

# 스킨 23번째 제품
function_04(c, "anua_wc.png")






