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
    + Str <=> str2: return -1,0,1,nil : so sánh 2 string so chiều dài của Str vs str2 (CASE INSENSITIVE)
    + Str == object (object#==) [return true or false]
        nếu object ko phải instance của String nhưng respond to to_string thì so sánh được 
        SO SÁNH LENGTH VÀ CONTENT 

    + Str === obj  [return true or false] tg tự ở trên 
    + Str =~ nil -> integer or nil 

