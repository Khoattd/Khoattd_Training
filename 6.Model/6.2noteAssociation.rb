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
    set 1 object trong belongs_to association sẽ không auto save object và associated object 

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
    sử dụng để customize behavior của belongs_to bằng cách pass options và scope block 
        khi khởi tạo association 
        vd:
            class Book < ApplicationRecord
            belongs_to :author, dependent: :destroy,
                counter_cache: true
            end
    CÁC OPTIONS BAO GỒM :
    :autosave boolean
        Rails tự động save any loaded association members và destroy marked for destruction 
        members khi parent object được save 
        CHÚ Ý: autosave: false khác không set autosave 
        nếu không set autosave, new associated object sẽ được save, updated assiated object 
        sẽ không save   
    :class_name
        nếu tên của model kia không thể "derived" từ association name. sử dụng class_name 
        để supply model name 
            vd: sách thuộc về tác giả nhưng model chứa tác giả là Patron 
            class Book < ApplicationRecord
                belongs_to :author, class_name: "Patron"
            end
    :counter_cache
        tìm belonging object nhanh hơn 
        nếu không có option counter_cache, @author.books.size sẽ thực hiện COUNT(*) query 
        thêm option counter_cache ở chỗ khai báo belongs_to (book) sẽ tọa cache value 
        để lưu giá trị counter
        TUY NHIÊN PHAỈ THÊM COLUMN _count (books_count) VÀO TABLE CỦA HAS_MANY MODEL 
            vd: belongs_to :author, counter_cache: true 
                                    counter_cache: :count_of_books #set tên cho column 
        NHỮNG OBJECT ĐƯỢC TẠO TRƯỚC KHI TẠO COLUMN _count sẽ khuông được đếm 
    :dependent
        có 2 option 
            :destroy khi object này bị destroy thì sẽ destroy luôn associated object 
            :delete khi object này bị destroy thì associated object sẽ bị detele trực tiếp 
                trong database mà không gọi lẹnh destroy 
    :foreign_key
        set name cho foreign_key. default là thêm suffix _id
            vd: foreign_key: "khoa"
        IN ANY CASE, RAIL SẼ KHÔNG TỰ TẠO COLUMN FOREIGN_KEY, PHẢI TỰ TẠO 
        BẰNG MIGRATION 
    :primary_key
        chọn column khác column id làm primary key 
        vd: 
            class User < ApplicationRecord
                self.primary_key = 'guid'  #set primary key của table User là guid
            end
            
            class Todo < ApplicationRecord
                belongs_to :user, primary_key: 'guid' 
            end
          #foreign_key của Todo table là user_id chứa data từ column guid của User 
    :inverse_of
    :polymorphic
        pass true để nó là polymorphic association 
    :touch
        updated_at, updated_on timestamp sẽ được update time mỗi khi object save 
        hoặc destroy
    :validate
        nếu set true, associated object sẽ được validate mỗi khi save object này 
         vd: nếu trong books có belongs_to :author, validate: true 
            mỗi khi save books thì author tương ứng sẽ được validate 
    :optional
        Nếu set true, associated object sẽ không validate presence 
-----------------------------
SCOPES FOR BELONGS_TO 
    sử dụng khi cần customize belongs_to thông qua một scope block 
    vd:             
        class Book < ApplicationRecord
            belongs_to :author, -> { where active: true },
                                dependent: :destroy
        end
    CÓ THỂ SỬ DỤNG BẤT CỨ QUERYING METHOD NÀO 
    --------------------------
    Where
        specify condition mà associated object phải có 
        vd: -> { where active: true } ( thằng author phải có attribute active là true)
    Includes 
        specify second-order association - cái sẽ được load khi association này được sử dụng 
        vd:  trogn trường hợp sử dụng nhiều @line_item.book.author
            class LineItem < ApplicationRecord
                belongs_to :book, -> { includes :author }
            end
            class Book < ApplicationRecord
                belongs_to :author
                has_many :line_items
            end
            class Author < ApplicationRecord
                has_many :books
            end
    Readonly 
        associated object chỉ có thể readonly khi retrived thoogn qua association 
    Select 
        override SQL SELECT (được sử dụng để retrive data của associated object). Default rails lấy all column 
        nếu sử dụng method select trên belongs_to, cần phải set foregin_key option để kết quả đúng 
---------------------------
CHECK DOES ASSOCIATED OBJECT EXIST 
    vd: if @book.author.nil?
             @msg = "No author found for this book"
        end
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
HAS_ONE ASSOCIATION REFERENCE 
    ngược với belongs_to, khi assign cho một has_many association, nó sẽ tự động
    được save (để update foreign_key của nó). any object bị thay thế sẽ được tự 
    động save vì nó cũng sẽ đổi foreign_key 
    Nếu một trong 2 save bị fail do không pass validation, assignment statement
        return false và bị cancel 
    Nếu parent object unsaved, child object sẽ không save. sẽ tự động save khi cả
        parent được save 
-----------------------------
METHOD ADDED 
    association
    association=(associate)
    build_association(attributes = {})
    create_association(attributes = {})
    create_association!(attributes = {})
    reload_association
    #association được thay bằng tên model được pass vào has_one 
    #tương tự như belongs_to 
----------------------------
OPTIONS FOR HAS_ONE 
    :as
        set association là polymporphic association 
    :autosave
        #tương tự belongs_to
    :class_name
        #tương tự belongs_to
    :dependent
        control associated object khi this object bị destroy 
        bao gồm :
            :destroy destroy luôn thằng con 
            :delete delete thằng con trực tiếp trong database 
            :nullify foregin_key set to null, không trigger callback 
            :restrict_with_exception raise exception nếu tồn tại associated record 
            :restrict_with_error add error to the owner nếu tồn tạo associated object 
    :foreign_key
        #tương tự belongs_to
    :inverse_of
        #tương tự belongs_to
    :primary_key
        #tương tự belongs_to
    :source
        Specifies source association name cho has_one :through association 
    :source_type
        sử dụng khi association proceed thông qua polymorphic association 
    :through
        specifies model trung gian để perform query 
    :validate
        #tương tự belongs_to 
------------------------
SCOPES FOR HAS_ONE 
    #y chang belongs_to 
-----------------------
CHECK DOES ASSOCIATED OBJECT EXIST 
    vd: if @supplier.account.nil?
             @msg = "No account found for this supplier"
        end
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
HAS_MANY REFERENCES 
-------------------
METHOD ADDED
    collection
    collection<<(object, ...)
    collection.delete(object, ...)
    collection.destroy(object, ...)
    collection=(objects)
    collection_singular_ids
    collection_singular_ids=(ids)
    collection.clear
    collection.empty?
    collection.size
    collection.find(...)
    collection.where(...)
    collection.exists?(...)
    collection.build(attributes = {}, ...)
    collection.create(attributes = {})
    collection.create!(attributes = {})
    collection.reload 
#collection được thay bằng class plural pass vào sau has_many 
#collection_singluar được thay bằng singularized version 
        vd: 
            class Author < ApplicationRecord
            has_many :books
            end
        => author.books / author.book_ids 
    Collection 
        trả về Relation của tất cả associated objects. nếu ko có return empty relation 
        vd: @author.books = @books 
    Collection<<(object,...)
        thêm 1 hoặc n objects vào collection bằng cách set foreign_key của các object
        đó bằng primary_key của calling model
        vd: @author.books << @book1 
    Collection.delete(object,..)
        xóa 1 hoặc n object khỏi collection bawgnf cách set foreign_key thành null 
        vd: @author.books.delete(@book1)
    Collection.destroy(object,..)
        xóa 1 hoặc n object khỏi collection bằng cách destroy mỗi object
        ignore :dependent option 
    Collection=(objects)
        làm collection chỉ chứa supplied object. bằng cách add và delete objects. 
        change đc persist tới database 
    Collection_singular_ids
        return array chứa id của các objects trong collection 
        vd: @author.book_ids = @book_ids 
    Collection_singular_ids = (ids) 
        làm collection chỉ chứa các objecst có primary key là các id được đưa vào 
        change đc persist tới database 
    Collection.clear 
        remove all objects khỏi collection theo cách được specified trong :dependent 
        nếu không có sẽ làm default là set foreign_key to null 
        với has_many :through là delete_all 
    Collection.empty? 
        return true nếu không có associated object nào 
    Collection.size 
    Collection.find
        Tìm object trong collection 
            vd: @author.books.find(1) 
    Collection.where 
        Tìm object trong collection với condition được pass vào where. 
        NHƯNG OBJECT ĐƯỢC LOAD LAZILY (database is queried only when the object 
        is accessed)
            vd: @available_books = @author.books.where(available: true) # No query yet
    Collection.exists?(..) 
        check object trong collection có pass condition hay không 
    Collection.build(attribute ={},...)
        tạo object mới với attribute được pass vào 
        Tuy nhiên associated object chưa được save
        vd:  @book = @author.books.build(published_at: Time.now,book_number: "A12345")
    Collection.create(attributes = {}) 
        tương tự như build nhưng object sẽ được save vào database 
    Collection.create! 
        tương tự như create nhưng raise ActiveRecord::RecordInvalid 
    Collection.reload 
        tương tự như belongs_to,has_many 
-------------------------------------------------------------------
OPTIONS FOR HAS_MANY 
    :as
        xác định đây là polymorphic association 
    :autosave
        #tương tự 2 cái trên
    :class_name
        #tương tự 2 cái trên
    :counter_cache
        #tương tự 2 cái trên 
    :dependent
        bao gồm các options :
            :destroy all associated object cũng bị destroy theo 
            :delete_all associated object bị delete trực tiếp trong database 
            :nullify foreign_key set to null. KHÔNG TRIGGER CALLBACK 
            :restrict_with_exception raise exception nếu có bất kì associated object nào 
            :restrict_with_error add error to the owner nếu có bất kì associated object nào 
    :foreign_key
        #tương tự 2 cái trên
    :inverse_of
        #tương tự
    :primary_key
        #tương tự 
    :source
        #tương tự
    :source_type
        #tương tự
    :THROUGH
        #tương tự
    :validate
        #tương tự 
-----------------------------------------------------------------
SCOPE FOR HAS_MANY 
    sử dụng dể customize query cho has_many 
    vd:     
        class Author < ApplicationRecord
        has_many :books, -> { where processed: true }
        end
    BAO GỒM : 
        where
            #tương tự 
        extending
            specified a named module to extend the association proxy 
        group
            supplies an attribute name to group result set by 
                vd: 
                    class Author < ApplicationRecord
                    has_many :line_items, -> { group 'books.id' },
                                            through: :books
                    end
        includes
            #tương tự 
        limit
            set limit cho lượng object được lấy ra từ database 
                vd:  has_many :recent_books, -> { order('published_at desc').limit(100) },class_name: "Book"
        offset
            bỏ qua n object đầu tiên vd: -> {offset(11)} #bỏ qua 11 thằng đầu tiên 
        order
            sắp thứ tự cho các object nhận được theo cái gì đó 
                vd: has_many :books, -> { order "date_confirmed DESC" }
        readonly
            set readonly cho associated objet được lấy từ database 
        select
            #tương tự 
        distinct
            không lấy những thằng duplicate 
                vd: class Person
                has_many :readings
                has_many :articles, -> { distinct }, through: :readings
              end
            nếu gán 2 article giống nhau thì nó vẫn tồn tại 2 articles giống nhau. nhưng khi retereive từ Person chỉ 
            lấy được 1 article 
              ĐỂ MỖI ARTICLE LÀ UNIQUE, SET COLUMN LÀ UNIQUE: TRUE 
---------------------------------------------------------------
WHEN ARE OBJECTS SAVED 
khi gán 1 object cho 1 quan hệ has_many, object đó sẽ được auto save để update foreign_key của nó. nếu assign 
multiple object thì multiple object cugnx đc save 
    vd: khi tạo  b = comment.new thì b chưa đc save vào database 
        nhưng khi gán a.comments << b thì b sẽ được autosave vào database 
nếu ko pass validation thì assignment statement return false và cancelled 
nếu parrent obbject chưa đc save thì child object cũng sẽ ko đc save thì gán. toàn bộ unsaved member sẽ được 
save vào database khi parent đc save 
NẾU MUỐN GÁN MÀ KO LƯU VÀO DATABASE SỬ DỤNG COLLECTION.BUILD 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
HAS_AND_BELONGS_TO_MANY ASSOCIATION REFERENCES  
    Association này tự tạo join table cho 2 model gồm foreign_key tới mỗi class 
-----------------------------------
17 METHOD ADDED 
    collection
    collection<<(object, ...)
    collection.delete(object, ...)
    collection.destroy(object, ...)
    collection=(objects)
    collection_singular_ids
    collection_singular_ids=(ids)
    collection.clear
    collection.empty?
    collection.size
    collection.find(...)
    collection.where(...)
    collection.exists?(...)
    collection.build(attributes = {})
    collection.create(attributes = {})
    collection.create!(attributes = {})
    collection.reload
#collection được thay bằng class plural pass vào sau has_many 
#collection_singluar được thay bằng singularized version 
vd: Part has_and_belongs_to_many :assemblies 
        => part.assemblies | part.assembly_ids
-------------------------------------
ADDITIONAL COLUMN METHOD 
    nếu trong jointable có thêm các cột additional ngoài 2 column chưa foreign_key 
    các cột đó sẽ được thêm như attribute của các record được retrieve từ quan hệ đó 
    RECORD ĐƯỢC RETURN VỚI ADDITIONAL ATTRIBUTE LUÔN LUÔN READ-ONLY 
    KHÔNG NÊN SỬ DỤNG. NẾU MUỐN SỬ DỤNG KIỂU ASSOCIATION COMPLEX NHƯU VẬY THÌ XÀI HAS_MANY :THROUGH 
---------------------------------------
    Collection 
        #tương tự has_many 
    Collection<<(object,...) 
        dùng đề gán 
        #tương tự has_many 
        !có thể dùng collection.concat và collection.push 
    Collection.delete(object,..)
        remove 1 hoặc n objects khỏi collection bằng cách xóa records trong jointable. 
        KHÔNG DESTROY OBJECT 
           vd: @part.assemblies.delete(@assembly1)
    Collection.destroy(object,..)
        tương tự như delete 
    Collection=(objecst)
        #tương tự has_many
    Collection_singular_ids
        return array chứa id của objects thuộc collection 
    Collection_singular_ids=(ids)
        #tương tự has_many
        dùng để gán 
    Collection.clear 
        remove tất cả object khỏi collection bằng cách xóa rows khỏi join table 
        KHÔNG DESTROY ASSOCIATED OBJECT 
    Collection.empty? 
        return true nếu collection khoogn có associated object nào 
    Collection.find(...)
        tìm objects trong collection 
    Collection.where(...)
        #tương tự has_many 
        vd: @new_assemblies = @part.assemblies.where("created_at > ?", 2.days.ago)
    Collection.exists?(...)
        #tương tự has_many 
    Colleciton.build(attribute={})
        object sẽ được tạo với passed attribute, link through join table sẽ được tạo, nhưng object chưa save 
    Collection.create(attribute={}) 
        sau khi pass all validation trên associated model. associated object sẽ được save
    Collection.create! 
        raise exception nếu RecordInvalid
    Collection.reload 
        #giống has_many
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
OPTIONS FOR HAS_AND_BELONGS_TO_MANY
    vd: 
    class Parts < ApplicationRecord
      has_and_belongs_to_many :assemblies, -> { readonly },
                                           autosave: true
    end
    BAO GỒM :
    :association_foreign_key
        set column name trong join table cho thằng associated object
        vd:
            has_and_belongs_to_many :friends,
            class_name: "User",
            foreign_key: "this_user_id",
            association_foreign_key: "other_user_id"
    :autosave
        #tương tự 
    :class_name
        #tương tự 
    :foreign_key 
        #tương tự
    :join_table
        #tương tự
    :validate
        #tương tự 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SCOPES FOR HAS_AND_BELONGS_TO_MANY
    vd:
        has_and_belongs_to_many :assemblies, -> { where active: true }
    Bao Gồm : 
        where #tương tự
        extending #tương tự 
        group   #tương tự
        includes #tương tự
        limit   #tương tự
        offset  #tương tự 
        order   #tương tự
        readonly    #tương tự
        Select  #tương tự
        distinct    #tương tự 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
WHEN ARE OBJECST SAVED 
    khi gán object cho association, object được autosave (Để update join table). multiple objects cũng save hết 
    nếu 1 cái fail validation thì return false và cancel 
    nếu parent unsaved thì child sẽ unsaved cho tới khi parent đc save
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ASSOCIATION CALLBACK 
    Tương tự như các callback thông thường, nhưng được trigger trong life cycle của collection 
        vd: has_many :books, before_add: :check_credit_limit
    4 CAllBACK :
        before_add
        after_add
        before_remove 
        after_remove 
    Rails sẽ pass object được add  hoặc remove vào callback 
    có thể stack nhiều callback trong 1 event bằng array  vd: before_add: [:callback1, :callback2]
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ASSOCATION EXTENSION 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SINGLE TABLE INHERITANCE 
    sử dụng để share field cho các model khác nhau vd: share field color, price cho Car, Motorcycle 
        nhưng mỗi cái lại có behavior khác nhau, controller khác nhau 
    vd: 
        tạo date vehicle có filed type để mark model 
        $ rails generate model vehicle type:string color:string price:decimal{10.2}
        tạo các model để sử dụng database vehicle 
        $ rails generate model car --parent=Vehicle
            cái này sẽ tạo model: class Car < Vehicle 
            khi tạo 1 car mới là tạo 1 record trong vehicle với type là car 
!!!!!!!!!!!!!!!!! khi initialze belongs_to hoặc has_one. nên sử dụng build_prefix để build association thay vì 
sử dụng .build method (sử dụng cho has_many, has_and_belongs_to_many). tương tự với create