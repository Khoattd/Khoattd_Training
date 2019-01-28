open source - server side scripting language
có thể nhúng vào HTMl
scalable, big programs easily maintainable 
có thể phát triển app internet, intranet 
GUItool Suport : Tcl/tk, GTK, opeGL
Nhiều function built sẵn 
CASE SENSITIVE
a + b = a+b (a là local variable)
a +b = a(+b) (a là method)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SYNTAX :
    print <<EOF
    This is the first way of creating
     here document ie. multiple line string.
    EOF

    print <<"EOF";                # same as above
        This is the second way of creating
        here document ie. multiple line string.
    EOF

    print <<`EOC`                 # execute commands
	    echo hi there
	    echo lo there
    EOC

    print <<"foo", <<"bar"  # you can stack them
	    I said foo.
    foo
	    I said bar.
    bar

    BEGIN {
     code
    } gọi code trước khi programs chạy. ngược với END

    COMMENT :
    # THIS IS A COMMENT
    =  begin 
        multiple line comment 
    = end
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUBY CLASS AND OBJECTS
    4 type of varibles:
    local: defined in a method, ngoài method ko xài được bắt đầu vs lowercase letter hoặc _
    instance: là variable của mỗi object, thay đổi theo từng object (available across method) 
    class: biến xài được của một class, (available across objects), bắt đầu bằng @@
    global: availabel across classes. bắt đầu bằng $
    vd : class Customer
    @@no_of_customers = 0
    end  => xài để định xem bao nhiêu customer được tạo 
    tạo mới : cust1 = Customer. new

    CUSTOM METHOD TO CREATE RUBY OBJECT 
    phải khai báo method initialize trong class 
    vd:
    class Customer
    @@no_of_customers = 0
        def initialize(id, name, addr) #local variable
            @cust_id = id
            @cust_name = name
            @cust_addr = addr
        end
        def function()            #method name LUÔN LUÔN bắt đầu bằng lowercase 
            statement 1
            statement 2
        end
    end
    cust1 = Customer.new("1", "John", "Wisdom Apartments, Ludhiya")
    cust1.function #gọi method 
    để in giá trị của object:  puts "Customer id #@cust_id"

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
METHOD :
    Method được def ngoài class def : default private 
    Method được def trong class def : default public
    phải được def trước khi call 
-------------------------------------------------------------------------------------
    def test(a1 = "Ruby", a2 = "Perl")        #cách set default nếu không pass
        puts "The programming language is #{a1}"
        puts "The programming language is #{a2}"
    end
    test "C", "C++"
    test
    call method không cần () 
--------------------------------------------------------------------------
    METHOD LUÔN TRẢ MỘT GIÁ TRỊ (DEFAULT LÀ KẾT QUẢ CỦA ĐOẠN CODE CUỐI )
    RETURN :
    trả lại 1 hay nhiều value trong 1 array 
    vd: return 1,2,3
 ---------------------------------------------------------------------------------
    def sample (*test)                       #Method cho phép pass 1 đống các variable 
     puts "The number of parameters is #{test.length}"
    end
    sample "Zara", "6", "F"
 -------------------------------------------------------------------------------
    class Accounts
        def reading_charge
        end
        def Accounts.return_date            #instantiating method để có thể gọi mà ko cần tạo object:
        end                                 # gọi bằng : Accounts.return_date
    end
 --------------------------------------------------------------------------------
    ALIAS 
    khi đặt alias cho method rồi thì khi method thay đổi, alias vẫn giữ method cũ 
    không được đặt alias là số vd ($1)
    syntax:
    alias method-name[tên] method-name[cái được đặt tên]
    alias global-variable-name global-variable-name
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUBY - STRINGS :
    default sử dụng ASC II , mỗi chữ 1 bytes
    đổi bằng: $KCODE =  'a' #ASCII        đặt ở đầu program
                        'e' #EUC 
                        'n' #none = ASCII
                        'u' #UTF-8
    --------------------------------------------------------------------
    '' vs""
    '' xem tất cả bên trong nó là string 
    "" có thể sử dụng để chèn code với #{}
    vd: puts "The sum of x and y is #{ x + y }." => in tổng x + y
    puts 'The sum of x and y is #{ x + y }.' => in #{ x + y}
    %Q{}, %{}  = ""
    %q[] = ''
    --------------------------------------------------------------------
    STRING BUILT-IN METHOD 
    cần tạo string object mới để xài 
        vd: myStr = String.new("THIS IS TEST")
            foo = myStr.downcase
            puts "#{foo}"
    + try_convert(obj) : convert 1 obj thành string, return nil nếu ko convert được (#to_string method)
    + Str % arg: sử dụng str như format, apply to arg 
    format : %[flags][width][.precision]type
    flags: quyết định định dạng vd thêm 0x, cách viết số âm 
    width: integer số character nhỏ nhất viết vô kết quả vd %05d decimal, cần 5 số, nếu 123 thì ra 00123 
    vd: "%-5s: %08x" % [ "ID", self.object_id ]   #=> "ID   : 200e14d6"
        "%05d" % 123                              #=> "00123"
    
    + Str * int: lặp lại str int lần 
    + Str + str2: gộp str2 vào sau Str 
    + +str -> str(mutable): nếu string frozen, return duplicated mutable string
      -str -> str(frozen): nếu string frozen, trả lại chính nó. nếu ko return forzen string 

    + Str << object/integer :append obj vô str , nếu pass integer thì append code point 
        vd: a << "world"   #=> "hello world"
    + Str <=> str2: return -1,0,1,nil : so sánh 2 string so chiều dài của Str vs str2 (CASE SENSITIVE)
    + Str == object (object#==) [return true or false]
        nếu object ko phải instance của String nhưng respond to to_string thì so sánh được 
        SO SÁNH LENGTH VÀ CONTENT 

    + Str === obj  [return true or false] tg tự ở trên 
    + Str =~ obj -> integer or nil 
     ???????????????????????????????????????????????

    + Str[index]/[start,length],[range],[regexp],[regexp,capture],[match_str] -> new_str hoặc nil 
            + lấy ra chữ ở index 
            + lấy ra substring từ start với length 
            + range : [2..5] : trả về substring giữ index 2 và 5  
            #trong 3 th trên, nếu index là negative thì đếm ngược lên 
            + Regexp: /expression/. vd: /\d/ : số từ 0 ts 9 
    + Str[index]/[index,index]/[range]/[regexp]/[regexp,integer/name]/[other_str] = new_str 
            + thay thế content của Str bằng new_str
    
    + ascii_only? -> true/false .check string xem có chứa gì ngoài ascii ko 
    + bytes : return array chứa bytes của các ký tự trong string 
    + bytesize -> integer: return độ dài của str theo byte 
    + byteslice(integer/ integer,integer / range) -> new_string or new 
        giống Str[index] nhưng tính theo byte 
    + capitalize/capitalize[option] -> new_str  # viết hoa chữ đầu string 
            capitalize! : return nil nếu không có thay đổi nào
      downcase/downcase(option)
      upcase   
      swapcase: đảo case của str                t n    
    + casecmp(str2): Case Insensitive version của <=>
      casecmp? -> true,false,nil so sánh 2 string có bằng nhau ko. case insensitive
    + center(width,[padstr='']). center string trong 1 string có chiều dài là width, đệm là padstr 
    + chars: xếp string thành array 
    + chomp: cắt \r, \n, \r\n khỏi cuối string, nếu pass str2 thì cắt str2 khỏi str cuối str 
      chomp!: inplace, nil nếu ko đổi 
    + chop: cắt chữ cuối. \r\n cắt cả đôi, \n\r chỉ cắt \r
    #xài chomp an toàn hơn vì ko đổi string nếu end ko phải là \n \r 
      chop!:
    + chr: return char đầu tiên 
    + clear: empty string 
    + concat(obj1,obj2): giống + 
    + count([str2]+) -> integer đếm str2 có trong str, hoặc các ký tự của str 2 có trong str2
    vd : count ("hello","^l") đếm chữ h, e, o, trừ chữ l
        c1-c2: đếm các chữ giữa c1,c2
        "\\^aeiou" đếm ^,a,e,i,o,u
    + crypt(satl_str): mã hóa 
    + delete(str2+). rule giống count
      delete!: inplace,m return nil 
      delete_prefix/!, _suffix/!
    + dump : nhưng char ko print đc đc thêm \ đằng trc
      undump: ngược với dump
    + "hello".each_byte {|c| print c, ' ' } =>> cho byte của mỗi char vào code 
        kết quả: 104 101 108 108 111
        each_char: tương tự nhưng thay byte = char
        each_codepoint
    + eachline: cắt string thành các sub string rồi hiện ở mỗi line khác nhau 
        vd: print "Example one\n"
            "hello\nworld".each_line {|s| p s} 
            Example one
                "hello\n"
                "world"
            print "Example two\n"
            "hello\nworld".each_line('l') {|s| p s}
            print "Example three\n"
                 Example two
                "hel"
                "l"
                "o\nworl"
                "d"
    + empty? -> true/false : chekc length của string 
    + encode(encoding [, options] )
        encode(dst_encoding, src_encoding [, options] ) → str           #có thêm !
        encode([options]) → str
       
    + end_with?(""), check đuôi của string, có thể  check nhiều đuôi, chỉ cần 1 cái đúng trả về true 
      start_with? : tương tự
    + eql?("str2") - > true/false: so sánh s string, true khi giống nhau hoàn toàn, CASE SENSITIVE 
    + force_encoding(encoding): chuyển string sang dạng encoding khac 
    +   gsub(pattern, replacement) → new_str
        gsub(pattern, hash) → new_str
        gsub(pattern) {|match| block } → new_str                 #có thêm !
        gsub(pattern) → enumerator
    thay những cái thỏa pattern bằng replacement 
        vd: "hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
            "hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
            "hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
            "hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  #=> "h{e}ll{o}"
            'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"
    + hash -> integer
    + include?("str2") : check str1 có str2 hay ko 
    + index(substring [, offset]) → integer or nil
        index(regexp [, offset]) → integer or nil
        tìm index của substring hoặc regexp, offset để xác định vị trí bắt đầu tìm, negative sẽ tìm từ sau lên 
      rindex(substring [, integer]) → integer or nil
      rindex(regexp [, integer]) → integer or nil
       #lấy index của chữ cuối cùng 
         
    + replace(str2) thay str bằng str2 
    + insert(index, other_str) → str
    + inspect 
    + length 
    + ljust(integer, padstr=' ') → new_str
        nếu str.length nhỏ hơn integer, padd thêm bên phải cho bằng 
      rjust: tương tự nhưng thêm vào bên trái 
    + lstrip: loại bỏ whitespace đầu string 
      lstrip! return nil nếu không đổi 
      rstrip: loại bỏ whitespace cuối string 
      strip/! : loại bỏ ở cả đầu và đuôi 
    +   match(pattern) → matchdata or nil
        match(pattern, pos) → matchdata or nil
        #tìm cái pattern match
        vd: khoa = String.new("Tran Thanh Dang Khoa")
            khoa.match("T.....") => Tran T
        thêm ? : trả về  true/false 
??????????????????????????????????????????????????
    + next : trả về string next của nó: 
    vd "khoa".next => "khob"; "khoa".next.next = "khoc"
      !: inplace 
    + oct : chuyển sang bát phân 
    + ord: lấy code mã 
    + partition(sep) → [head, sep, tail]
      partition(regexp) → [head, match, tail]
      vd:   "hello".partition("l")         #=> ["he", "l", "lo"]
            "hello".partition("x")         #=> ["hello", "", ""]
            "hello".partition(/.l/)        #=> ["h", "el", "lo"]
      rpartition: làm ngược từ đuôi string lên
    + prepend(str2,str3) thêm vào trước str str2, str3
    + replace(str2) thay str bằng str2 
    + reverse : đảo ngược str. thêm ! để  return ngay trên str 
    + scan(pattern) → array 
      scan(pattern) {|match, ...| block } → str
      vd:   a = "cruel world"
            a.scan(/\w+/)        #=> ["cruel", "world"]
            a.scan(/.../)        #=> ["cru", "el ", "wor"]
            a.scan(/(...)/)      #=> [["cru"], ["el "], ["wor"]]
            a.scan(/(..)(..)/)   #=> [["cr", "ue"], ["l ", "wo"]]
    
            a.scan(/\w+/) {|w| print "<<#{w}>> " }
            print "\n"  #<<cruel>> <<world>>
            a.scan(/(.)(.)/) {|x,y| print y, x }
            print "\n" #rceu lowlr
    + scrub → new_str 
      scrub(repl) → new_str
      scrub{|bytes|} → new_str 
    thay invalid bytes sequce bằng repl hoặc bằng return của block
    vd:  "abc\u3042\x81".scrub("*") #=> "abc\u3042*"
         "abc\u3042\xE3\x80".scrub{|bytes| '<'+bytes.unpack('H*')[0]+'>' } #=> "abc\u3042<e380>"
     thêm ! để return ngay trên str, retủn nil nếu không đổi 
    + sub(pattern, replacement) → new_tr
      sub(pattern, hash) → new_str
      sub(pattern) {|match| block } → new_str
     tương tự nhưu scrub nhưng hoạt động với những thằng pattern 
     #chỉ thay những thằng match đầu tiên
     vd: "hello".sub(/[aeiou]/, '*')     #=> "h*llo"
      thêm ! để in place và return nil 
    + setbyte(index,integer) set indeth byte thành integer 
    + size : check character length 
    + slice(index) → new_str or nil
      slice(start, length) → new_str or nil
      slice(range) → new_str or nil
      #nếu passnegative làm làm từ sau lên
      slice(regexp) → new_str or nil
      slice(regexp, capture) → new_str or nil
      slice(match_str) → new_str or nil 
      trả về đoạn slice 
      thêm !: xóa đoạn slice ra khỏi source str 
    + split(pattern [,limit]): cắt str ra từng đoạn 
       vd:  "hello".split(//)               #=> ["h", "e", "l", "l", "o"]
            "hello".split(//, 3)            #=> ["h", "e", "llo"]
            "mellow yellow".split("ello")   #=> ["m", "w y", "w"]
    + squeeze(str2). 
        nếu không pass thì rút nhưng chữ đi đôi vd :"yellow moon".squeeze                  #=> "yelow mon"
        nếu pass argument thì thì áp dụng vs những chữ có trong str2 
        áp dụng từ chữ m tới z = > "m-z"
        thêm ! để inplace + return nil 
    + sum(n=integer) trả về n-basic checksum của str 
    + to_c: chuyển string biểu diễn số phức thành số phức 
    '3-4i'.to_c        #=> (3-4i)
    + to_f: chuyển string thành số float (chỉ đổi số đấu trong từ)
    vd: "45.67 degrees".to_f   #=> 45.67
    + to_i(base=n) chuyển về số base n. n từ 2 ts 36
    + to_r : chuyển về phần số / rút gọn phân số 
    + to_sym: trả bề symbol của str. nếu chưa có symbol thì tạo 
     vd:s = 'cat'.to_sym       #=> :cat
        s == :cat              #=> true
    + tr(form_str, to_str) thay 
    vd :    "hello".tr('el', 'ip')      #=> "hippo"
            "hello".tr('aeiou', '*')    #=> "h*ll*
    bắt đầu bằng ^ để loại bỏ nó 
    + tr_s() thực hiện tr, rồi loại bỏ những chữ bị duplicate 
    + unicode_normalize(:nfc/:nfd/:nfkc/:nfkd)\
        thêm !,? 
    + upto(other_str, exclusive=false) {|s| block } → str 
      upto(other_str, exclusive=false) → an_enumerator
      vd :  "a8".upto("b6") {|s| print s, ' ' }  
            for s in "a8".."b6"
            print s, ' '
            end
            produces: a8 a9 b0 b1 b2 b3 b4 b5 b6
    + valid_encoding? → true or false check xem có encode đúng ko
    vd: "\xc2\xa1".force_encoding("UTF-8").valid_encoding?  #=> true
        "\xc2".force_encoding("UTF-8").valid_encoding?      #=> false
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ARRAY
    0-indexed
    có thể chứa lọa giá trị khác nhau 
    TẠO ARRAY 
    ary = [1, "two", 3.0] #=> [1, "two", 3.0]
    ary = Array.new    #=> []
    Array.new(3)       #=> [nil, nil, nil]
    Array.new(3, true) #=> [true, true, true]
    Array.new(4) { Hash.new }  #=> [{}, {}, {}, {}]
    Array.new(4) {|i| i.to_s } #=> ["0", "1", "2", "3"]
    ARRAY NHIỀU CHIỀU :
    empty_table = Array.new(3) { Array.new(3) }
    #=> [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]

    a = Array.new(2, Hash.new)
    a[0]['cat'] = 'feline'
    # => [{"cat"=>"feline"}, {"cat"=>"feline"}
với cách tạo này, khi thay đổi 1 phần từ của array do nó chứa hash nên các thằng khác đổi theo
    nên sử dụng dạng block để tạo các phần tử khác nhau: 
    vd:  a = Array.new(2) { Hash.new }
         a[0]['cat'] = 'feline'
         a # => [{"cat"=>"feline"}, {}]
ACCESS ARRAY :
    arr[2, 3]: bắt đầu từ index 2, lấy 3 cái 
    arr[1..-3]: bắt đầu từ index 1, kết thúc ở cái thứ 3 đếm ngc lên 
    arr.at(index) = arr[index]
    nếu lấy ngoài range của array sẽ trả về nil 
    arr.fetch(index)= > lấy ngoài range báo về index error 
    arr.fetch(index,"oops") => lấy ngoài range báo về "oops"
    arr.fisrt/last: lấy thằng đầu / last 
    arr.take/drop(n): lấy n gía trị đầu/cuối 
        .take_while {block}
    arr.value_at(id1,id2) :lấy các giá trị tại các index tương ứng 
    
ARRAY SIZE :
    .count = .lenght 
    .empty? -> true/false 
    .include?('item') => có chứa item không 
ADD ITEM 
    .push() (or << ) => add vào cuối array 
    .unshift() => add vào đầu array 
    .insert(index,'item'): thêm item vào vị trí index #có thể thêm nhiều vlua cùng lúc 
REMOVING ITEM :
    .pop : xóa thằng cuối array và return nó 
    .shift: xóa thằng đầu array và dời array, return nó 
    .delete_at() : xóa tại index nào đó, dời array 
    .delete(item): xóa item trong array, dời array 
            thêm {"mess"} để hiện mess nếu không thấy item 
    .compact :loại bỏ những thằng nil #thêm ! để  in place 
    .uniq: loại bỏ duplicate khỏi array 
    .drop(n): loại bỏ n phần tử đầu rồi dời array 
        drop_while { |obj| block } : loại bỏ có điều kiện
        chạy từ trái sang phải. tới khi nào ko thỏa điều kiện thì dừng, kể cả khi các phần tử sau đó có 
        thỏa điều kiện hay không
LẶP QUA ARRAY :
    EACH :
    arr = [1, 2, 3, 4, 5]
    arr.each { |a| print a -= 10, " " }
    # prints: -9 -8 -7 -6 -5
    #=> [1, 2, 3, 4, 5]

    .reverse_each: giống each nhưng ngược từ dưới lên 
    .map: tạo một array mới với các giá trị được thay đổi từ array cũ 
    vd: arr.map { |a| 2*a }   #=> [2, 4, 6, 8, 10]
        arr                   #=> [1, 2, 3, 4, 5]
SELECTING FORM ARRAY :
 vd:    arr = [1, 2, 3, 4, 5, 6]
        arr.select { |a| a > 3 }     #=> [4, 5, 6]    có thể thêm !
        arr.reject { |a| a < 3 }     #=> [3, 4, 5, 6] có thể thêm !
        arr.drop_while { |a| a < 4 } #=> [4, 5, 6]
        arr                          #=> [1, 2, 3, 4, 5, 6]
    .delete_if {}
    .keep_if {}
METHOD :
    + Array.try_convert([]) : chuyển object thành array 
    ar1 & ar2 : tạo array mới chưa giá trị chung của ar1 và ar2 . Thứ tự của ar1 
    + ar * int: tạo array mới lặp lại int lần 
        *  "str" chuyển array thành string, các phần tử cách nhau bằng str
    + ar1 + ar2 : gộp 2 array 
    + ar1 - ar2 : bỏ những phần từ có trong ar2 ra khỏi ar1 
    + ar << obj : thêm obj vào chính ar
    vd: a << "c" << "d" << [ 3, 4 ]
        #=>  [ 1, 2, "c", "d", [ 3, 4 ] ]
    + ar1 <=> ar2 return -1,0,1,nil 
    so sánh từng phần tử của ar1 với ar2 .
    nó bằng khi từng phần tử  bằng nhau và bằng chiều dài 
    nếu 1 cặp phần tử ko ss đc thì trả nil 
    + ary == ar2 - > boolean : so sánh 2 array 
    + ary[index] = obj → obj 
      ary[start, length] = obj or other_ary or nil → obj or other_ary or nil
      ary[range] = obj or other_ary or nil → obj or other_ary or nil
      # dùng để set giá trị của array 
      LƯU Ý : a[0..2] = "A"               #=> ["A", "4"] thay 1 range bằng 1 element duy nhất 
    + assoc(obj): tìm trong ar1. với các phần tử của ar1 có thể là 1 array. nếu obj BẰNG VỚI PHẦN TỬ ĐẦU TIÊN 
    CỦA ARRAY CON CỦA ar1 thì return nó. bằng nil khi không tìm thấy. kể cả nếu có obj nhưng không phải là 
    array thì vẫn là nil   
        vd: s1 = [ "colors", "red", "blue", "green" ]
            s2 = [ "letters", "a", "b", "c" ]
            s3 = "foo"
            a  = [ s1, s2, s3 ]
            a.assoc("letters")  #=> [ "letters", "a", "b", "c" ]
            a.assoc("foo")      #=> nil

     rassoc: TÌM PHẦN TỬ CON THỨ 2 
    + bsearch {|x| block } → elem
        dạng 1: find-mininum mode: array luôn phải sắp xếp từ thấp tới lớn rồi
                vd: ary = [0, 4, 7, 10, 12]
                ary.bsearch {|x| x >=   4 } #=> 4
                ary.bsearch {|x| x >=   6 } #=> 7
                ary.bsearch {|x| x >=  -1 } #=> 0
        dạng 2: find-any mode : 
            the block returns a positive number for ary if 0 <= k < i,
            the block returns zero for ary if i <= k < j, and
            the block returns a negative number for ary if j <= k < ary.size.
            vd :    ary = [0, 4, 7, 10, 12]
                    # try to find v such that 4 <= v < 8
                    ary.bsearch {|x| 1 - x / 4 } #=> 4 or 7
                    # try to find v such that 8 <= v < 10
                    ary.bsearch {|x| 4 - x / 2 } #=> nil
    + clear : xóa mọi phần tử 
    + collect { |item| block } → new_ary  #giống với map
      collect → Enumerator 
        vd: a = [ "a", "b", "c", "d" ]
            a.collect { |x| x + "!" }         #=> ["a!", "b!", "c!", "d!"]
    thêm ! để thực hiện in place 
    + combination(n) gộp n phần tử trong array rồi call block
      repeated_combination(n)
    vd: a.combination(3).to_a: lấy tổ hợp con có 3 phần tử, chuyển thành array, pass vào a lại 
    + concat(ar1,ar2): thêm các phần tử của ar1 và ar2 vào ar 
    + count → int  #đếm số  phần tử trong array 
      count(obj) → int #đếm số phần tử equal với obj
      count { |item| block } → int # đếm số phần tử thỏa block. block phải return true 
    + cycle(n=nil) { |obj| block } → nil
      cycle(n=nil) → Enumerator
      gọi block cho mỗi element n lần, nếu n là nil thì gọi mãi 
    + dig(idx,idx2): lấy phần tử trong array con 
    + each:    
        vd: a = [ "a", "b", "c" ]
            a.each {|x| print x, " -- " }
        each_index : thay vì pass element sẽ pass index của element 
    + empty?
    + eql?
    + fill: thay phần tử 
    + .index(element): trả về index của element 
        rindex(element): trả về index của element cuối cùng xuất hiện 
    + .flatten/([level]): giảm chiều của array 
     #thêm ! để in plac e
    + .frozen?
    + hash -> integer  : tính hascode 
    + include?(obj)
    + replace(ar2): thay content của ar1 bằng ar2 
    + reverse: đảo ngược element của aray #có option !
    + .join("separator"): chuyển array thành string bắt bằng separator 
    + max/min 
    + permutation(n) { |p| block } → ary
    + product(ar2): lấy từng phần tử của ar1 gộp với từng phần tử của ar2 mới tạo thành phần tử của ar lớn
        vd: [1,2].product([1,2])       #=> [[1,1],[1,2],[2,1],[2,2]]
    + rotate(n) xoay array  #có option!
    + sample() lấy địa 1 element của array 
    + select {|item| block} lấy ra giá trị nào làm block return true 
    + shuffle  #có !
    + sort #có !
    + sum: tính tổng array 
    + transpose : đảo ma trận 
    +