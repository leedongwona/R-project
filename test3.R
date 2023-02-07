
# url 따오기

url = "http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79"
book_url = url %>% GET() %>% read_html("EUC-KR") %>% 
  html_nodes("div.detail div.title a") %>% 
  html_attr(name = "href")


# 평점

url2 = "http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9788954699914"
book_rating = url2 %>% GET() %>% read_html("EUC-KR") %>% 
  html_nodes("#container > div:nth-child(4) > form > div.box_detail_point > div.review > div > div > em") %>% 
  html_text()
book_url[1] %>% GET()



# 첫 페이지 평점

book_rate = 1
for (x in 1:50) {
  d_url = book_url[x]
  d_data = GET(d_url)
  d_myHtml = read_html(d_data, "EUC-KR")
  d_sel1 = html_nodes(d_myHtml, "#container > div:nth-child(4) > form > div.box_detail_point > div.review > div > div > em")
  d_sel2 = html_text(d_sel1)
  book_rate[x] = print(d_sel2[1])
}
book_rate




# Rselenium 평점 가져오기


function_03 = function(){
  library(httr)
  library(rvest)
  library(RSelenium)
  library(stringr)
  library(dplyr)
  
  rd$server$stop()
  
  rd = rsDriver(chromever = "106.0.5249.61", 4445L, 
                remoteServerAddr="localhost")
  
  remDr = rd$client
  
  remDr$navigate("http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79")
  
  url = "http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79"
  book_url = url %>% GET() %>% read_html("EUC-KR") %>% 
    html_nodes("div.detail div.title a") %>% 
    html_attr(name = "href")
  
  
  book_rate = NA
  Sys.sleep(3)
  
  for (x in 1:50) {
    d_url = book_url[x]
    d_data = GET(d_url)
    d_myHtml = read_html(d_data, "EUC-KR")
    d_sel1 = html_nodes(d_myHtml, "#container > div:nth-child(4) > form > div.box_detail_point > div.review > div > div > em")
    d_sel2 = html_text(d_sel1)
    book_rate[x] = print(d_sel2[1])
    Sys.sleep(sample(1:2, 1)*0.1)
  }
  
  df_book_rate = data.frame(book_rate)
  Sys.sleep(2)
  df_book_rate = df_book_rate %>% rename(new_book_rate = book_rate)
  
  for (i in 1:3) {
    
    remDr$executeScript("window.scrollTo(0, 300)")
    Sys.sleep(2)
   
    el = remDr$findElement(using = "css", value = "#main_contents > div:nth-child(6) > div.list_paging > a.btn_next")
    el$
    el$clickElement()
    Sys.sleep(3)
    page = remDr$getPageSource()[[1]]
    
   
    book_url = read_html(page) %>% 
      html_nodes("div.detail div.title a") %>% 
      html_attr(name = "href")
    
    
    new_book_rate = NA
    Sys.sleep(3)
    
    
    for (x in 1:50) {
      d_url = book_url[x]
      d_data = GET(d_url)
      d_myHtml = read_html(d_data, "EUC-KR")
      d_sel1 = html_nodes(d_myHtml, "#container > div:nth-child(4) > form > div.box_detail_point > div.review > div > div > em")
      d_sel2 = html_text(d_sel1)
      new_book_rate[x] = print(d_sel2[1])
      df_new_book_rate = data.frame(new_book_rate)
      Sys.sleep(sample(1:2, 1)*0.1)
    }
    
    Sys.sleep(2)
    df_book_rate = rbind(df_book_rate, df_new_book_rate)
    
    Sys.sleep(5)
  }
  
  rd$server$stop()
  return(df_book_rate)
}

xx=function_03()

xx

install.packages("readr")

