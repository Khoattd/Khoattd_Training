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
---------------------------------------------------------------------------------------------
FILTER 
-BASIC FILTER
CÚ PHÁP THÔNG THƯỜNG: VD $("div:animated")
+ :animated select thằng nào đang có animation 
+ :eq(index) lựa thằng thứ index trong đống matched trc đó (zero indexed) vd: $("#div2 input:eq(2)")
+ :even/:odd lựa những thằng có index chẵn/lẻ trong matched $("#div2 input:even")
+ :first thằng đầu tiên trong đống matched  (tương đương :ed(0)) (jquery extension cải thiện = .filter(":first"))
+ :focus thằng đang có focus trong đống matched
+ :gt(index) những thằng có stt lớn hơn index trong đống matched (jquery extension thay = $(" ").slice(index))
+ :lt(index) ngược với gt (jquery extension thay = $(" ").slice(0, index) )
+ :header lọc ra những thằng là h1, h2 ...  (jquery extension cải thiện = .filter(":header"))
+ :lang(language) lọc theo ngôn ngữ
+ :not(selector) lọc ra những thằng ko match cái selector vd: $("#div2 input:not([type='text'])")


