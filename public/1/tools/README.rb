
1. rjob.app 을 /Appleication folder 로 복사
2. KoPubBatang_Pro Bold 등등 의 서체들을 /Library/fonts/ 로 복사
    - 재시동

3. .bash_profile 에 rjob 가상이름 설정

atom ~/.bash_profile

alias newsman="/Applications/newsman.app/Contents/MacOS/newsman"
alias rjob="/Applications/rjob.app/Contents/MacOS/rjob"

// 수정된 부분 적용하기
. ~/.bash_profile

4. rjob font_list

5. ruby generate_layout.rb

6. ruby generate_pdf.rb
