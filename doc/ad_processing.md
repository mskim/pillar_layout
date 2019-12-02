# 광고처리

## 광고 처리 방식

1. 손쉽게 해당 페이지에 배치하기 (기존방식)
1. 광고 자동 배치
  - GW 입력정보 연동하기
  - 광고주 정보 입력 규칙 정리
1. 지난 광고 관리
1. 광고 batch 등록
  - parse CSV at seed time
  - 화일 이름에 정보 포함
    - 9-1_삼성전자_2018-8_5단통.jpg
    - 11-1_lg_2018-8_300x400.jpg

1. upload image
  - 파일명 관리
  - 영문이름 지원?,
    = lg_2018-8.jpg
  - thumbnail , eps

1. 인쇄 지원


## nav menu

### 오늘광고
  오늘이슈 페이지에 포함된 광고박스 보여주기
  동시 배치하기(용량이 큰 이미지를 배치할 경우 속도가 저하 됨으로 편집시 보류하다가 특정시간에 자리에 배치)
    - palace button

  페이지 템플렛이 바뀔어 광고 크기경우 적용하기

### 광고관리
  사진올리기
  광고검색
  광고주 정보

## create new ad

1. Create new ad
1. fill in the ad info

- advertiser
- ad type
- Upload Ad Image

## select it as todays ad

- search ad by advertise
- check it as today's ad
- assing page and order

## place ad

- place assigned ad to page
- place ads automatically at planed time
- trigger this process with cron

## create Model
  - ad_library_image
    - ad_libray_image  AdLibraryImageUploader
    - ad_type
    - advertiser
    - color

## ActiveStorage

We might as well replement the whole image uploading using ActiveStrage,
keeping ad_library_images on the cloud??
I need more testing using ActiveStrage!!
