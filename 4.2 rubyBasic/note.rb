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
    MỘT SỐ METHOD: 
        + str*[int]: lặp lại str int lần 
        + str + other : gộp 2 string
        + str << obj/integer : append object to string, hoặc append code point to string 

        + str <=> other_str: so sánh 2 string (length). return -1 (less than), 0, 1, nil. CASE INSENSITIVE
        + str == obj. false khi object ko phải là string. true khi str <=> obj return 0
        + str.capitalize : uppercase chữ đầu
             .capitalize! : tương tự nhưng changes in place ??????????
             .swapcase 
             .downcase, str.downcase!
             .upcase, upcase!
        + str.chop: bõ chữ cuối
             .chop!: giống chop  
             .rstrip: bỏ whitespace cuối string  
             .strip/!: bỏ cả whitespace đầu và cuối/return nil nếu ko đổi     
        + str.center: center str 
        + str.chomp. bõ $/, \n cuối string
        + str.concat(str2) gộp 2 str
        + str.crypt(str2) : mã hóa 
        + str.count 
        +str.delete(str2): xóa các chữ trong str 2 ra khỏi str 1
            .delete!(str2): tug tự delete 
       
        + str.dump: in luôn những thằng ko in đc. vd "this is test" => in luôn ""
        + str.index(substring/fixnum/regexp [, offset] dò index của substring
             .rindex : dò index của thằng đuôi của substring 
        + str.insert(index, other_str)
        + str.lstrip/str.lstrip! loại bỏ whitespace đầu chữ/ return nil nếu ko change 
        + str.replace(str2)
        + str.reverse/reverse!
        + str.rjust(integer, padstr = ' ') nếu độ dài str nhỏ hơn integer thì thêm paddstring đằng trc cho bằng
        + str.slice(fixnum, fixnum)
