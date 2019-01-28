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
= begin 
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