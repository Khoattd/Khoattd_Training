+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
MODE-VIEW-PRESENTER vs MODEL-VIEW-CONTROLLER
presenter là trung gian, nhận dữ liệu từ view, gửi tới model đồng thời update view 
model tác động tới view thông qua presenter 
view call method từ presenter khi có tác động 
 trong khi đó ở MVC : view > controller > model > view
 model: how raw data or define the eesssential component 
        reflect real-world thíngs 
 view: define how users see, interact 
controller: liên lạc giữa view và model, nhận user input và quyết định what to do. 
            brain of the application
giống nấu ăn. model là tủ lạnh nắm giữ nguyên liệu (rawdata)
            . controller là recipe, quyết định lấy nguyên liệu nào, ghép lại nhưu nào, xử lý như nào 
            . view là bày ra bàn 


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Rail  là web app development framework được viết trên ruby để làm cho việc phát triển web đơn giãn , nhanh hơn 
2 principles: 
+ dont repeat your self: DRY 
+ convention over configuration 

CONTROLLER :
    nhận về request cụ thể của app 
    routing quyết định controller nào nhận request nào 
    một controller có thể có nhiều routes, mỗi routes xử lý 1 actions khác nhau 
    mỗi actions có mục đích là thu thập thông tin đưa vào view 
    mỗi controller là một class được inherit từ class cha Application controller 
    CHỈ CÓ PUBLIC METHOD MỚI LÀM ACTIONS ĐƯỢC 
    define new action giống như define một method của class 
create new controller: 
$ bin/rails generate controller Welcome index

VIEW :
    display thông tin thu thập được "a human readable format"
    default được viết bằng embedded ruby 
    mỗi action đều phải có view tương ứng để display nếu không sẽ báo lỗi unknowAction

ROUTING FILE : hold entries in a special DSL 
cho rails biết kết nối giữa incomming request   với controller và actions 
config/routes.rb 

RESOURCE : collection of similar object ex: articles, animals..
    có thể Create-Read-Update-Delete : CRUD operation 
    thêm resource ở :  config/routes.rb 
    resources :(resourcename)