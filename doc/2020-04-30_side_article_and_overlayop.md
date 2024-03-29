
# 내림 기사박스란 사용법

오버랩과 내림기사 박스를 사용하여 필라에서 다양한 레이아웃을 구현 할 수 있다.

## 내림 기사박스란?

현재 좌우측에 기사를 추가하는 방식은 "기사박스 나누기 우측 2단", "기사박스 나누기 좌측 2단" 등을 선택 하는 방식을 사용한다,
그러나 이경우에는 나누어지는 박스가 현재 박스와 동일한 높이 만 가능하다.
다음 기사까지 연결된는 경우는 불가능 하다.

이를 해결하기 위해 "내림 기사 박스"란 방식을 사용한다.
글줄기(pillar) 에 내림박스 를 생성하여 현재 박스에서 하단까지 연결되는 자르기 박스를 구현할 수 있게 헸다.

"내림 기사 박스" 는 "기사박스 나누기 우측 ?단" 과 비슷한 방식으로 현재 작업중인 박스로 부터
필라 하단 까지 연결되는 기사박스 를 생성 하는 방식이다.


## 좌 우 내림박스 메뉴 에서 선택 하는 방법

현재 작업 중인 박스의 크기에 따라 가능한 메뉴가 나타나며, 이를 선택 헤서 생성 할 수 있다.

내림박스 우측 1 단 
내림박스 우측 2 단 
내림박스 우측 3 단 

내림박스 좌측 1 단 
내림박스 좌측 2 단 
내림박스 좌측 3 단 

메뉴에서 위 메뉴중 하나를 선택하면 선택 한 기사 박스를 시작으로 좌측 또는 우측에 최하단 까지 연결되는 내림기사가 생성된다.

1_R(좌측), 2_L(우측) 으로 표시된 내림기사가 생성된다.

## 내림박스 삭제 방법

추가된 내림박스 편집을 선택 한 후 메뉴에서 기사 삭제를 선택 한다.


## 내림박스의 시작 위치 자동조절

내림박스가 위치한 상단의 기사들이 자동 조절 될경우 내림박스의 위치도 이에 따라 자동으로 조절 된다.


# 양측 자식박스

"기사박스 나누기"로 생성된 기사들을 자식 박스라고 한다.

## 양측 달린박스(child box)

"기사박스 나누기"로 생성된 자식 박스들의 높이는 부모 박스의 높이와 동인하게 유지 된다.
즉 부모 박스가 "자동 행 조절" 이나 "행수 추가" 로 높이가 변하면 이에 딸린 자식박스의 높이도 동일하게 자동 재조판 된다.

## 하단 달린박스(overlap child box)

"overlap"

하단 기사박스가 추가 되면 어미 기사 박스는 잠금상태(locked) 가 된다.
잠금상태란 자동 행조절이 나나 행 추가가 금지된 상태를 말한다.

기사박스 하단우측 1단
기사박스 하단우측 2단
기사박스 하단우측 3단

기사박스 하단좌측 1단
기사박스 하단좌측 2단
기사박스 하단좌측 3단

## 행수 늘리기때



# handling drop_article and overlap

## WorkingArticle side drop articles
  has_ancestry # this keep track of attached articles 
  serialize :overlap Array 
    kind: # left_side, right_side, overlap, extended_left, extended_right
    [kind, grid_x, grid_y, column, row]

side_boxes can be used for vitical division article and beyond 

## locking
  when is locked, adjust_height is no longer available

  inactive:true means locked
  kind:string #right, right_span, left, left_span

## pillar_sidebox
create at starting article
  - once it is created above box should be locked


can be created from top article box
  - expand vertically to bottom

  add_right_drop(column) 우측 내림기사 추가
  delete_drop

## pillar layout for 
  - right_drop
    [0,0,5,10,2,[-2,0]]

    [0,0,5,10,2,[column_position,starting_y]}]
  - left_drop
    [0,0,5,10,2,{right_drop: [2,0]}]

  - overlap

## page_layout 
  