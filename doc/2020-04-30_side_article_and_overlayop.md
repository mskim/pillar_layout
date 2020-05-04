# handling side_boxes and overlap

## WorkingArticle
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
  add_left_drop(column)  좌측 내림기사 추가
  delete_drop

## pillar layout for 
  - right_drop
    [0,0,5,10,2,[-2,0]]

    [0,0,5,10,2,[column_position,starting_y]}]
  - left_drop
    [0,0,5,10,2,{right_drop: [2,0]}]

  - overlap

## page_layout 
  