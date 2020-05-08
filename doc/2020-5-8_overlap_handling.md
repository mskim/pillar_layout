# Overlap Handling

템플렛 이외에 편집중 생성되는 기사의 종류

자르기_기사 (좌,우)           left_divide, right_divide
내림_기사   (좌,우)           left_drop, right_drop
첨부_기사   (좌측하단,우측하단)  left_overlap, right_overlap

부고/인사, 발문, 안내문 은 일반 기사와 별도로 처리한다.


첨부기사는 본 기사가 4x4 이상 일때만 생성이 가능하다.

def overlapable?



