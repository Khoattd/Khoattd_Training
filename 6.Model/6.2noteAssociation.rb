TYPE OF ASSOCIATION 
+ belongs_to (1-1)
+ has_one    (1-1)
+ has many   (1-n) 
+ has_many :through  (n-n)
+ has_one :through    (1-1)
+ has_and_belongs_to_many (n-n)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
------------------------belongs_to----------------------------------
one-to-one connection.nhìn từ dưới lên
vd: 
    class Book < ApplicationRecord
        belongs_to :author
    end
mỗi book có một author duy nhất 
PHẢI SỬ DỤNG SINGULAR TERM
-------------------------has_one------------------------------------
one-to-one connection . nhìn từ trên xuống 
chứa-xử lý 
vd: has_one :account 
mỗi supplier có một account duy nhất
-------------------------has_many-----------------------------------
one-to-many connection.
THƯỜNG ĐƯỢC NẰM PHÍA BÊN KIA CỦA belongs_to
mỗi instance của model này có 0 hoặc n instance của model kia 
vd: has_many :books #một author có nhiều book
PHẢI SỬ DỤNG PLURALIZE TERM 
---------------------------hay_many :through------------------------
many-to-many association 
mỗi instance model có thể matched 0 hoặc n instance của model khác thông qua bên thứ 3
vd:
    class Physician < ApplicationRecord
        has_many :appointments
        has_many :patients, through: :appointments
    end
    
    class Appointment < ApplicationRecord
        belongs_to :physician
        belongs_to :patient
    end
    
    class Patient < ApplicationRecord
        has_many :appointments
        has_many :physicians, through: :appointments
    end
một bác sỹ có nhiều bệnh nhân thông qua các cuộc hẹn 
một bệnh nhân có nhiều bác sỹ thông qua các cuộc hẹn
-------------------------has_one :through---------------------------------
one-to-one connection 
instance model có một matched với instance của model khác thông qua bên thứ 3
vd: 
    class Supplier < ApplicationRecord
        has_one :account
        has_one :account_history, through: :account
    end
mỗi suppler có một accout history thông qua một account. 
#mỗi account belongs_to 1 supplier và has_one accoute_history
#mỗi account_history belongs_to 1 account 
-------------------------has_and_belongs_to_many--------------------------
many-to-many 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
BELONGS_TO VS HAS_ONE 
thường để thiết lập quan hệ 1-1, 1 bên sẽ là belongs_to , bên còn lại là has_one 
    :BELONGS_TO LÀ BẢNG ĐẶT :FOREIGN_KEY 
 đặt 2 cái này sao cho login 
  vd: 1 account belongs_to 1 supplier / 1 supplier has_one 1 account 
        ngược lại nghe như shit 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
HAS_MANY :THROUGH VS HAS_AND_BELONGS_TO_MANY 
 has_and_belongs_to_many dễ xài hơn. đặt ở cả 2 phía.DIRECTLY 
        nhớ tạo join table 
 has_many :through INDIRECTLY. đặt ở cả 2 phía, through cái trung gian, 
        cái trung gian belongs_to 2 cái kia 
        sử dụng khi cần validation, callback, extra attribute trên thằng trung gian 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
POLYMORPHIC ASSOCIATIONS 
1 model có thể belongs_to 1 hoặc nhiều model khác trên 1 association duy nhất 
có thể hiểu như tạo tên cho nó để nhiều thằng có thể có nó.
2 MODEL CÓ NÓ KHÔNG CÓ QUAN HỆ VỚI NHAU 
vd: 1 picture có thể  belongs_to 1 employee hoặc  1 product thông qua symbol imageable
     class Picture < ApplicationRecord
        belongs_to :imageable, polymorphic: true
    end
    
    class Employee < ApplicationRecord
        has_many :pictures, as: :imageable
    end
    
    class Product < ApplicationRecord
        has_many :pictures, as: :imageable
    end       
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SELF JOINS 
    có quan hệ với chính nó
    vd: lưu dữ liệu của employee trong 1 bảng duy nhất, tuy nhiên phân biệt giữa manager và
        subordiates
        class Employee < ApplicationRecord
            has_many :subordinates, class_name: "Employee",
                                    foreign_key: "manager_id"
            belongs_to :manager, class_name: "Employee"
        end
    ta có thể retrive @employee.subordiates và @employee.manager
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TIPS, TRICKS, WARNINGS 
    phải tự tạo migration thay đổi theo association trong model 
        + tạo foreign_key cho association belongs_to 
        + tạo join table cho has_and_belongs_to_many
    CHÚ Ý TỚI SCOPE CỦA CLASS APPLICATION RECORD KHI TẠO CLASS TRONG MODULE  
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
BI-DIRECTIONAL APPLICATION
 khi 2 model có 2 association với nhau vd : has_many - belongs_to
 rails tự động hiểu a = author.first , b = a.book.first 
 CHÚ Ý
        nếu có option :through và :foreign_key, rails không tự hiểu 2 cái trên nữa 
        thêm vào đó, phải sử dụng inverse_of 
        vd: 
            class Author < ApplicationRecord
            has_many :books, inverse_of: 'writer'
            end
            
            class Book < ApplicationRecord
            belongs_to :writer, class_name: 'Author', foreign_key: 'author_id'
            end
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ASSOCIATION REFERENCE
-----------------------------------------------------------------   
BELONGS_TO REFERENCE 
METHOD ADDED 
    association
    association=(associate)
    build_association(attributes = {})
    create_association(attributes = {})
    create_association!(attributes = {})
    reload_association
#association được thay bằng tên model được pass vào belongs_to
        vd: class Book < ApplicationRecord
                belongs_to :author
            end
    # association =>> author
Association 
    vd: @book.author  trả về @author 
    nếu thằng associated object (@author) đã được retrieve từ database rồi thì thằng cached 
    sẽ được return. để tránh behavior này xài reload_association vd: @book.reload_author
Association=(associate)
    gán quan hệ cho model 
    vd: @book.author = @author (gán author của thằng book nào đó bằng thằng author nào đó)
    thực hiện bằng cách lấy primary key của thằng author gán cho foreign_key của thằng book
Build_association
    return new object của associated. thằng object này sẽ được instantiated với passed 
    attribte. foreign_key của this object sẽ được set 
    NHƯNG ASSOCIATED OBJECT SẼ CHƯA ĐƯỢC SAVE VÀO DATABASE 
    vd: @author = @book.build_author(author_number: 123,author_name: "John Doe")
            thằng author với 2 attribute sau sẽ được tạo nhưng chưa save vào database 
Create_association 
    GIỐNG NHƯ BUILD NHƯNG ASSOCIATED OBJECT SẼ ĐƯỢC SAVE VÀO DATABASE SAU KHI PASS VALIDATION 
    vd: @author = @book.create_author(author_number: 123,author_name: "John Doe")
    thằng author với 2 attribute sau sẽ được tạo,check valid và save vào database
Create_association! raise ActiveRecord::RecordInvalid nếu record không pas validation 
--------------  
OPTIONS FOR BELONGS_TO 
    
