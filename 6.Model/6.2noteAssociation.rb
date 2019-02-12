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
                 

