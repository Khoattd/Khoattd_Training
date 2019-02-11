OVERVIEW 
    migration giúp thay đổi database schema overtime, không cần SQL  
    sử dụng Ruby DSL để mổ tả thay đổi trong tables 
    migration có thể xem như các version của database 
    Active Record biết làm thế nào để update schema 
    migration lỗi thì phải rollback lại bằng tay
CREATING A MIGRATION :
    migration class : CamelCase 
    thời gian trước file migrate để Active record xử lý theo thứ tự. 
    nếu thêm file khác hoặc tự thay thì nhớ để ý thời gian 


TẠO TABLE : 
    If the migration name is of the form "CreateXXXs" 
    and is followed by a list of column names 
    and types then a migration creating the table XXX with the columns listed will be generated. For example:
     vd: 
        rails generate migration CreateProducts name:string part_number:string
         #tạo 1 file trong db/mig chứa def chang create_tables 
thay đổi table thông qua migrate :  
    rails generate migration Add[x]To[Xxxs] 
        vd: rails generate migration AddDetailToArticles detail:string
    rails generate migration Remove[x]From[Xxxs]
        vd: rails generate migration RemoveDetailToArticles detail:string 
migration refer tới table khác (liên kết - tạo external key)
    vd: rails generate migration AddUserRefToProducts user:references
     #nghĩa là thêm vào product refer tới bảng user. tạo một cột user_id 
migration join 2 table : 
    rails g migration CreateJoinTable[T1][T2] [t1] [t2] #chú ý case sensitive đúng như cái này 
TẠO MODEL TƯƠNG ỨNG :
    Note: 
        rails g model Product 
        rails g migration CreateProducts
    2 cái này tương tự nhau. model tạo file migrate trong db và tạo thêm file trong models 
    migration chỉ tạo file migrate để tạo bảng trong database chứ không tạo model 
        thường tạo bảng xài model Product.
        migration chủ yếu để thay đổi bảng như Add/Remove cột 
WRITTING MIGRATION :
    collum modifier 
        limit Sets the maximum size of the string/text/binary/integer fields.
        precision Defines the precision for the decimal fields, representing the total number of digits in the number.
        scale Defines the scale for the decimal fields, representing the number of digits after the decimal point.
        polymorphic Adds a type column for belongs_to associations.
        null Allows or disallows NULL values in the column.
        default Allows to set a default value on the column. Note that if you are using a dynamic value (such as a date), the default will only be calculated the first time (i.e. on the date the migration is applied).
        index Adds an index for the column.
        comment Adds a comment for the column

        add/remove_foreign_key :inWhere(lowercase,plural), :PointtoWhere(lowercase,plural)


NÓI CHUNG
Tạo migration :
    rails g migration (anyname) (option)
        các tên có sẵn : Add/Remove[x]To[XXX], Create[XXX], CreateJoinTable[T1][T2] [t1] [t2]
    nếu tạo migration có tên bất kì thì tạo ra file migrate rrỗng 
    khai báo các method trong change để có thể migrate database 
        vd: 
        change_column :[tables], :[column], :[type]

nếu đã migrate một migration lỗi: 
    rails db:rollback [STEP=n]
    sau đó fixx migration rồi migrate lại 
    hoặc 
    rails db:redo [STEP=]
SOME MORE COMMAND : 
    Setup database: rails db:setup (create database, load schema, initialize with seed data)
    Reset database: rails db:rest 
                    or rails db:rop + rail db:setup 
    Chạy 1 migrate chỉ định 
                    rails db:migrate:up VERSION:20080906120000
    Chạy migration trên môi trường: 
                    rails db:migrate RAILS_ENV=test

CHANGING EXISTING MIGRATION 
  not a good idead 
    tạo extra work cho team nếu một migration đó đã chạy trên production machine rồi 
    chỉ nên thay đổi những migration ở trên máy dev 
CHÚ Ý 
khi tạo change database VD: CHANGE COLUMN type 
 b1) tạo column mới 
 b2) chuyển data từ column cũ sang column mới 
 b3) xóa column cũ 
 ĐÁNH GIÁ HOẠT ĐỘNG CỦA APP TRƯỚC KHI CHANGE DADATABASE 

 Foreign_key : true, false :
 ràng buộc các bảng ref với nhau. nếu true thì thay đổi khoogn được. vd xóa bảng 
 INDEX: sử dụng để retreive data, tăng tốc search, queries 
        hại : làm chậm tốc độ xử lý database. vì index cũng phải input, update... build lại binary tree.