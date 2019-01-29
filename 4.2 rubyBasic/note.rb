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
    instance: là variable của mỗi object, thay đổi theo từng object (available across method). bắt đầu bằng @
    class: biến xài được của một class, (available across objects), bắt đầu bằng @@. phải 
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
RUBY VARIABLES 
global ($), instance (@), class (@@), local (lowcase, _)

    CONSTANT : bắt đầu bằng uppercaseletter
        được khai báo trong class, module thì access local, khai báo ngoài clas/module -> access global 
    PSEUDO-VARIABLES : local variable, behave like constant. 
        không thể assign value vô pseudo_variables
        bao gồm: self, true/false, nil, __FILE__(name of current source file),__LINE__(current line in source file)
    BASICS LITERALS 
        + integer number:  -230 to 230-1 or -262 to 262-1 : object của class Fixnum 
                        :               ngoài             : object của class Bignum
            khởi đầu    : 0 octal, 0x hex, 0b binary 
        + floatting number: number có phần lẻ 
        + string: object của class string. chuỗi byte 
        + array
        + hash
            vd: hsh = colors = { "red" => 0xf00, "green" => 0x0f0, "blue" => 0x00f }
                hsh.each do |key, value|
                 print key, " is ", value, "\n"
                 end #=> red is 3840 ....
        + range: .. tính luôn số cuối vd 1..5 = 12345
                 ... bỏ số cuối 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUBY OPERATORS 
== vs === 
=== được sử dụng trong mệnh đề when của case 

eql? vs equal? 
eql check 2 biến bằng cả type và value 
equal? check object_id

and vs && tương tự cho or và ||
and có mức ưu tiên thấp hơn cả = 
vd: foo = :foo
bar = nil

a = foo and bar # gán a = foo trước, sau đó thực hiện a and bar
# => nil
a
# => :foo
 
a = foo && bar # gán a = kết quả của foo&& bar
# => nil
a
# => nil

a = (foo and bar) #gán a= kết quả của foo and bar
# => nil
a
# => nil

(a = foo) && bar 
# => nil
a
# => :foo
RUBY IF ELSE :
nếu viết chung dòng thì phải có then hoặc ;
vd if
x = 1
if x > 2 then puts "x is greater than 2" else puts "I can't guess the number" end
hoặc code if condition 
tương tự cho unless 
CASE WHEN :
    syntax: case expr0
                when expr1, expr2
                    stmt1
                when expr3, expr4
                    stmt2
                else
                    stmt3
                end
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUBY LOOPS 
WHILE : 
nếu viết 1 line thì phải có do , \ hoặc ;
dạn 2: begin 
            code 
        end while condition 
UNTIL : cấu trúc tương tự như WHILE 

FOR :
for variable [, variable ...] in expression [do]
    code
 end
 vd: for i in 0..5
            puts "Value of local variable is #{i}"
    end



