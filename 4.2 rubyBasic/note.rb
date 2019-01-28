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
      swapcase: đảo case của str                    
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