# 디자인 쳄풀렛 입력 방식

# variable
이름 = "min soo"
나이  = 57

# constant
PI_VALUE = 3.14
Psome_VALUE = 3.14

# number integer
[1,2,4,5]

# float
[1.5, 2.3, 4.0, 5.1]

# string

a = "내일신문"
date = '2017-4-5'
name = 'Min Soo'
b = "7x15"
c = "7x15_5단통_4_1"
d = '36' # string, not number
e = "#{a}:#{date}"

# Array
my_array= [a, 5, 'gu']
your_array = ["this is a string", "7x15", "7x15_5단통_4_1"]
array3 = [my_array, your_array]

# Hash

my_hash = {'first': 'minsoo', 'last': 'kim', 'phone': '010-7468-8222', 'email': 'mskimsid@gmail.com', '주소': '1234=433'}
my_hash2 = {
  'first': 'minsoo',
  'last': 'kim',
  'phone': '010-7468-8222',
  'email': 'mskimsid@gmail.com'
}

섹션_샘플 = [
  {},
  {'7x15_2_1': []},
]

섹션_샘플1 = [
  {'7x15_2_1': []},
  {'7x15_2_': [[0,0,1,1], [3,3,4,4]]},
  {},
  {},
]

# 기사 순서는 앞에서 부터 순서대로 정해짐
섹션_샘플2 = [
  {'7x15_H_5단통_2_1': [[0,0,7,1, {'타입': '제목'}], [0,1,7,4],[0,5,7,6] [0,10,7,5, {'타입': '광고'}]]},
  {'7x15_5단통_2_1': [[0,0,7,5], [0,5,7,6], [0,10,7,5, {'타입': '광고'}]]},
  {'7x15_3_1': [[0,0,7,5], [0,5,7,6], [0,10,7,5]]},
  {},
]

페이지_샘플 = {
  '1페이지': 섹션_샘플1,
  '2페이지': 섹션_샘플2,
  '3페이지': 섹션_샘플2,
  '4페이지': 섹션_샘플2
}
