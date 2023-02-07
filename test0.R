# 1. Rselenium 크롤링
# -크롬 최신화




# div.box_detail_review ul.board_list div.comment_wrap div.txt 
# #box_detail_review > div.list_paging.align_center > div > a:nth-child(13) > img



# 2. 데이터 수집함수 / 데이터 전처리 함수 / 데이터 분석 함수 /
# 데이터 시각화함수 / 수집한 데이터 저장함수 (파일명 입력 가능하도록 함수처리)



# 데이터 수집 함수 
# 크롤링 이용한 데이터 저장 : 서적명_본인명.txt
# 함수로 만들 것
# write.table(df_replies, "잘될 수밖에 없는 너에게")

# 데이터 전처리

# 데이터 분석

# 데이터 시각화

# 데이터 해석
# 저장하기

write.table(df_replies, file="xxx.txt", quote = T, row.names = F, col.names = c("reply"), fileEncoding = "utf-8", sep = ",")

​

# 읽어오기

z= read.table(file="xxx.txt", sep = ",", fileEncoding = "utf-8", col.names = c("reply"), header = T)

​

head(z