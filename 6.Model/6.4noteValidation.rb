OVERVIEW 
    server-side validation  (ngoài ra còn client-side validation, controller level validation)
    WHY? 
        ensure that only valid dâta go to the database (model-lever)
        database anogstic, end user không thể qua mặt 
    WHEN? 
        khi chạy method như create,save. sẽ send SQL Command tới database. Validation sẽ chạy 
        ngay trước khi các command đó được thực hiện.
        Nếu validation fail, object sẽ được mark là invalid và active record sẽ không 
        thực hiện các command.
        CÓ CÁC METHOD TRIGGER VALIDATION, CÁC METHOD THÌ KHÔNG 
    CÁC METHOD TRIGGER VALIDATION :
        + create,create!
        + save,save!
        + update, update!
        + update_attributes 
        các method có !(bang version), raise exception nếu record invalid 
        non-bang thì không.save+ update return fals. create return object 
    CÁC METHOD SKIP VALIDATION :
        + decrement! , decrement_counter
        + increment! , increment_counter 
        + toggle!
        + touch 
        + update_all, _attribut, _column, _columns, _counters
        + save(validate: false)
VALID? INVALID? 
    thực hiện validation mà không cần các method trigger validation 
    .errors.messages method để xem các errors
    vd:     Person.create(name: "John Doe").valid? # => true
            Person.create(name: nil).valid? # => false
ERRORS[:attribute]
 method check xem atttribute có bị error không. true nếu error
 CHỈ CHẠY SAU KHI ĐÃ THỰC HIỆN VALIDATION, VÌ NÓ CHỈ INSPECT ERROR COLLECTION 
 CHỨ KHÔNG TRIGGER VALIDATIONS 
            VD: Person.create.errors[:name].any? # => true

ERRORS.DETAILS[:attriute]
    check validation nào fail 
            VD: a = Article.create(tittle: "khoa", text: "a")
              a.errors.details[:tittle] =>>> trả về hash chứa tittle too short 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VALIDATION HELPER 
    sử dụng trực tiếp trong model class def 
    tất cả các helper đều accept :on và :message option
-------------------------------------------------------------------
Acceptance 
    kiếm tra checkbox đã check chưa. 
    vd : validates :terms_of_service, acceptance: { message: 'must be abided' }
    acceptance không cần phải record trong database, nếu không có trong database helper
    sẽ tự tạo virtual attribute 

Validate_associated
 check valid với được liên kết với model này.
 không sử dụng ở cả 2 cái được associated với nhau vì sẽ tạo loop  
            vd: has_many :books
                validates_associated :books
Confirmation 
 sử dụng để 2 text_field phải có 2 content giống nhau (password, email)
 chỉ check khi field có đuôi _confirmation có content  
    vd:   validates :email, confirmation: true
          validates :email_confirmation, presence: true
Exclusion/Inclusion
    sử dụng để check attribute value không/phải được có trong given set 
    vd: exclusion: { in: %w(www us ca jp),message: "%{value} is reserved." }
            nhập www, us, ca, jp sẽ báo lỗi. nếu trong string có nó thì vẫn được vd wwww
Format 
    check attribute value có match với regular expression không 
    vd :format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
Length 
    check độ dài của attribute values :
    bao gồm: minimum, maximum, in, is 
    option : too_long, wrong_length, too_short
            vd: length: { maximum: 1000,too_long: "%{count} is the maximum allowed" }
Numericality
    chỉ cho phép là số 
    option: only_integer, even, odd : boolean 
            greater_than, greater_than_or_equal_to
            equal_to, less_than, less_than_or_equal_to
            other_than,
            vd: validates :points, numericality: true
Presence/Absence 
 check attribute value phải có/không có 
Uniqueness 
 check attribute value phải là duy nhất trước khi lưu vào database
 thêm option scope, case_sensitive 
Vd: validates :name, uniqueness: { scope: :year,message: "should happen once per year" }
Validates_with 
    check với class được code để validation, không có default error 
Validates_each 
    check các attribute với một block, block được pass record, attribute name, attribute value 
    phải add error message vào model để nó invalid 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
COMMON VALIDATION OPTION 
:allow_nil bỏ qua validation nếu value được validate là nil 
:allow_blank bỏ qua validation nếu value là blank 
:message specify message được đưua vào error collection khi validation fails 
:on quyết định khi nào thì validate 
            vd: on: :create 
                on: :update 
    có thể pass custom event vd: on: :account_setup
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CONDITIONAL VALIDATION 
USING SYMBOL 
    method của if sẽ được gọi ngay trước khi validate 
    vd:     
        class Order < ApplicationRecord
            validates :card_number, presence: true, if: :paid_with_card?
            def paid_with_card?
                payment_type == "card"
            end
        end
USING PROC
    cho phép viết condition inline thay vì tạo method mới 
    vd: 
        class Account < ApplicationRecord
            validates :password, confirmation: true,
            unless: Proc.new { |a| a.password.blank? }
        end
GROUPING CONDITIONAL VALIDATION 
    thực hiện nhiều validation với một condition duy nhất 
    vd: 
        class User < ApplicationRecord
            with_options if: :is_admin? do |admin|
            admin.validates :password, length: { minimum: 10 }
            admin.validates :email, presence: true
            end
        end
COMBINING VALIDATION CONDITION 
    sử dụng array trogn if: để  sử dụng multiple condition #if: [epr1,epr2]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CUSTOM VALIDATION 
CUSTOM VALIDATOR 
    là class được kế thừa từ ActiveModel::Validator (hoặc ActiveModel::EachValidator)
    phải có  def validate(record) (hoặc  def validate_each(record, attribute, value))
    gọi bằng validates_with [MyValidator]
        vd:     
            class MyValidator < ActiveModel::Validator
                def validate(record)
                    unless record.name.starts_with? 'X'
                    record.errors[:name] << 'Need a name starting with X please!'
                    end
                end
            end
   
            class Person
                include ActiveModel::Validations
                validates_with MyValidator
            end
CUSTOM METHOD 
    có thể tạo method để check state của model và thêm message error 
    ngay trong class ở file method 
    gọi bằng validate :[methodName]
    có thể thêm nhiều method validation, sẽ được chạy theo thứ tự 
    trong def method phải có errors.add(:[attribute],"message")
    DEFAULT SẼ CHẠY MỖI KHI THỰC HIỆN VALID? HOẶC SAVE 
    có thể thêm option :on
    vd: 
        class Invoice < ApplicationRecord
        validate :active_customer, on: :create
        def active_customer
            errors.add(:customer_id, "is not active") unless customer.active?
        end
        end