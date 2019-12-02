
# Whenever gem 에 대하여

Whenever gem 은 설정된 시간에 설정된 program을 자동으로 실행한는 프로그램 입니다.

Unix 에 서 제공한는 cron 이라는 프로그램을 Ruby 를 상용 하여 좀더 쉽게 사용할 수 있게 하는 프로그램 입니다.

## 설치 하기

Gemfile 에

gem 'whenever'  라고 입력
terminal  에서 bundle install
terminal  에서 wheneverize . 실행

config/scheduler.rb 파일이 생성

scheduler.rb 에 다음 과 같은 내용 입력

every :day, at: '4am' do
  # specify the task name as a string
  rake "style:new_issue"
end

매일 오전 4시에 rake style:new_issue 라는 rake 명령문을 실행하라는 것


모든 것이 설치된후
crop 을 작동 하려면

whenever --update-crontab 을 실행한다.
whenever --update-crontab --set environment='development'

도음말
whenever --help 을 실행한다.
