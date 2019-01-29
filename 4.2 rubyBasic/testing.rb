thêm sau không đổi +
them sau có đổi <<
thêm trước có đổi : prepend
them trước không đổi : 


class People

   def initialize(name,age)
      @name = name
      @age = age
   end
    def age= (x)
        @age = x
    end
    def name = (y)
        @name = name
    end
end
people = People.new "John", 18

$x=5 
case $x 
when 0..2
   puts "x < 3"
else 
    puts "x>3"
end
-----------------------
$i = 0
while $i < 10 do 
if i<3
    next
else if i>7
    break
else 
    puts "#{i}"
    
end
 i+=1
end

until $i > 5 do 
 puts ("#$i")
 $i +=1
end

for x in 0..4 do 
 puts("#{x}")
end

begin 
 puts "#$i"
 $i +=1
end while $i<5 

(0..5).each do |i|
   puts " #{i}"
end


for i in 0..5
   if i < 2 
      next
   else if i > 8
        break   
   end
   puts " #{i}"
end



=-----------------------
2) không đổi: khoa.slice(0.3)
    đ

    6) làm đổi: names.insert(3,"vinh")
    7) không làm đổi: names.gsub("nga","nhan")
    để làm đổi chỉ cần thêm ! sau gsub
    8) làm đổi: names[3..7] = "Nhân"
    9) names.delete("nga") , muốn thay đổi chuổi gốc chỉ cần thêm !
    10) không làm đổi: names.capitalize. muốn thay đổi chuổi chỉ cần thêm !
    11) không đổi: names.upcase. muốn thay đổi chỉ cần thêm !
    12) không đổi: names.downcase. muốn thay đổi chỉ cần thêm !
    13) names.include?("dương")
    14) names.empty?
    15) không đổi: names.delete(" ") muốn thay đổi chỉ cần thêm !
    16) names.lines(" ")

1) nums.count
2) nums.count { |x| x.even? }
3) nums.first/ nums.last
4) nums.first(5)/ nums.last(5)
5) nums.slice(2..4)
6) nums.unshift(3) / num.push(3)
7) nums.insert(2,3)
8) nums.shift
9) nums.pop
10) nums.delete(9)
11) nums.delete_at(5)
12) nums.each {|x| puts "#{x*3}" }
13) nums.each_index {|x| puts "#{nums[x]*3 + x}"}

1) lấy giá trị của phần tử có index là 100, return nil nếu length của nums nhỏ hơn 100
2) nums.empty?
3) nums.include?(23)
4) nums.delete(nil)
5) không làm đổi: nums.uniq muốn thay đổi chuổi chỉ cần thêm !
6) each pass mỗi phần tử của array vào block và trả lại kết quả của block
map tạo một array mới với các phần tử là kết quả của block với các phân tử tương
ứng của array cũ
7) nums.collect { |x| x*5 }
8) nums.map! { |x| x+= 2}
9) nums.select {|x| x>18 }
10) nums.reject! {|x| x>18}
11) nums.join(",")
12) nums.sort      
13) nums.sort.reverse
14) nums.sort {|x| x %3}
