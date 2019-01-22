Được xây dựng trên JS
Jquery làm được thì JS làm được nhưng dài hơn (không có chiều ngược lại)
mục tiêu: làm gọn gàng code. Cho phép sử dụng attribute selector với nhưng
browser không hỗ  trợ
Ajax: read2know
Jquery Validation: plugin của jquery giúp kiểm tra độ valid của dữ liệu phía client,
giảm tải cho server. (vd: khi client nhập sai yêu cầu về tên, gửi lên server, không 
có jquevy validation thì server sẽ phải trả về, tốn tài nguyên). Jquery validation 
sẽ check legit r ms gửi

PHÂN BIỆT EACH VS MAP 



----------------------------------------------------
Selectors:
+Basic:
".a.b" có cả a và b 
".a .b" cái class b trong cái class a 
".a, .b" có class a hoặc b

-Attribute
valid identifier:  " '' "; ' "" '; " \"\" "; ' \' \' '
cú pháp thông thường :$( "[attribute *type* 'value']" ) vd $( "a[hreflang|='en']" )
+ chứa or theo sau bằng -: |=
+ chứa chuỗi substring trong value: *=   //chỉ cần chứa vd 'man' found: milkman
+ chứa word: ~=  // chưa từ riêng biệt: vd 'man' found: milk man 
+ kết thúc giống với: $= // vd 'letter' found: newsletters
+ Có attribute nhưng ko phải hoặc ko có attribute: !=
+ Start with: ^= vs 'news' found newsletters
+ [Attribute]: có attribute
+ Multiple Attribute: ( "[1][2][N]" ): phải có tất cả 1 tới N ms select