function_01 = function(){
  
  library(httr)
  library(rvest)
  library(RSelenium)
  library(stringr)
  library(dplyr)
  library(readr)
  
  rd$server$stop()
  
  rd = rsDriver(chromever = "106.0.5249.61", 4445L, 
                remoteServerAddr="localhost")
  
  remDr = rd$client
  
  remDr$navigate("http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9791191891201")
  
  remDr$executeScript("window.scrollTo(0, 1000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 2000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 3000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 4000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 5000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 6000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 7000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 8000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 9000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 10000)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 10500)")
  Sys.sleep(1)
  remDr$executeScript("window.scrollTo(0, 11000)")
  Sys.sleep(1)

  
  
  replies = read_html(page) %>% 
    html_nodes(css="div.box_detail_review ul.board_list div.comment_wrap div.txt") %>% 
    html_text()
  
  replies = str_trim(replies, side = "both")
  
  df_replies = data.frame(reply = replies)
  
  
  
  for(i in 1:10){
    
    elem = remDr$findElement(using = "css", value = "div.list_paging.align_center > div > a > img[alt='다음 페이지로 이동']")
    
    elem$clickElement()
    elem$
    
    page = remDr$getPageSource()[[1]]
    new_replies = read_html(page) %>% 
      html_nodes(css="div.box_detail_review ul.board_list div.comment_wrap div.txt") %>% 
      html_text()
    
    new_replies = str_trim(new_replies, side = "both")
    
    df_new_replies = data.frame(reply = new_replies)
    
    df_replies = rbind(df_replies, df_new_replies)
    
    Sys.sleep(sample(1:3, 1)*0.1)
    
  }
  
  write.table(df_replies, file="너에게_이동원.txt", quote = T, row.names = F, col.names = c("reply"), fileEncoding = "utf-8", sep = ",")
  
  z= read.table(file="너에게_이동원.txt", sep = ",", fileEncoding = "utf-8", col.names = c("reply"), header = T)
  View(z)
  
  rd$server$stop()
}


function_01()
