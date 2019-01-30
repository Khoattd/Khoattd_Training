Rail  là web app development framework được viết trên ruby để làm cho việc phát triển web đơn giãn , nhanh hơn 
2 principles: 
+ dont repeat your self: DRY 
+ convention over configuration 

CONTROLLER :
    nhận về request cụ thể của app 
    routing quyết định controller nào nhận request nào 
    một controller có thể có nhiều routes, mỗi routes xử lý 1 actions khác nhau 
    mỗi actions có mục đích là thu thập thông tin đưa vào view 
create new controller: 
$ bin/rails generate controller Welcome index

VIEW :
    display thông tin thu thập được "a human readable format"
    default được viết bằng embedded ruby 

ROUTING FILE : hold entries in a special DSL 
cho rails biết kết nối giữa incomming request   với controller và actions 
config/routes.rb 

RESOURCE : collection of similar object ex: articles, animals..
    có thể Create-Read-Update-Delete : CRUD operation 