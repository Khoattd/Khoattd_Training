OBJECT LIFE CYCLE 
    normal operation of Rails application: created, updated and destroyed 
CALLBACK CHO PHÉP TRIGGER LOGIC TRƯỚC VÀ SAU KHI OBJECT THAY ĐỔI TRẠNG THÁI 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CALLBACK OVERVIEW 
Callbacks là các method được call tại moments nhất định của object life cycle.
    sử dụng call back để chạy code khi một Active Record object được 
    created,saved,updated,deleted, validated,loaded from the database 
--------------
CALLBACK REGISTRATION 
    phải register trươc skhi sử dụng callback
    2 cách khai báo callback : dạng method hoặc dạng block
    class User < ApplicationRecord
        validates :login, :email, presence: true 
        before_validation :ensure_login_has_a_value #cach1 
        before_create do                            #cach2 
             self.name = login.capitalize if name.blank?
          end
        private
          def ensure_login_has_a_value
            if login.nil?
              self.login = email unless email.blank?
            end
          end   
      end
    pass option :on để thực hiện callback trên event nhất định 
        vd: before_validation :normalize_name, on: [:create,:update]
    method callback phải là private, nếu để public nó có thể được gọi bên ngoài model và vi phạm 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
AVAILABLE CALLBACKS
  Creating Object    
    before_validation
    after_validation
    before_save
    around_save
    before_create
    around_create
    after_create
    after_save
    after_commit/after_rollback
  Updating Object
    before_validation
    after_validation
    before_save
    around_save
    before_update
    around_update
    after_update
    after_save
    after_commit/after_rollback
  Destroying Object 
    before_destroy
    around_destroy
    after_destroy
    after_commit/after_rollback
!!!! after_save LUÔN LUÔN chạy sau after_update và after_create bất kể khi nào macro call trước hay sau 
!!!! before_destroy nên đặt trước dependent: :destroy để chắc chắn callback chạy ngay trước khi object bị xóa 
  after_initialize : gọi call back ngay khi object được instantiated (new hoặc load từ database)
  after_find : gọi call back ngay khi object được load từ database 
        được trigger bởi các method : all, first,find,find_by, find_by_*, find_by_*!,find_by_sql, last
  after_touch : gọi call back ngay khi object được touch (u.touch)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUNNING CALLBACKS 
 các method trigger callback:
    create/create!
    destroy/destroy!/destroy_all
    save/save!/save(validate: false)
    toggle!
    touch
    update_attribute/update/update!
    valid?
SKIPPING CALLBACKS 
 các method skip callbacks :
    decrement/decrement_counter
    delete/delete_all
    increment/increment_counter
    toggle
    update_column/_columns/_all/_counters
------------------------------------------------------------------------------------------------------------
CONDITIONAL CALLBACKS 
  giống validation, có thể sử dụng :if, :unless để thêm condition, take symbol,array,proc 
  USING WITH SYMBOL
      symbol coresponding to a method. method sẽ được call ngay trước cái callback 
      vd: before_save :normalize_card_number, if: :paid_with_card?
       #call check paid_with_card? trước khi chạy callback, return true mới thực hiện callback 
  USING WITH PROC 
      sử dụng khi viết short validation method, one-line 
      vd: before_save :normalize_card_number,if: Proc.new { |order| order.paid_with_card? }
  MULTIPLE CONDITIONS FOR CALLBACKS 
      có thể sử dụng cùng lúc :if và :unless cho một call back 
        vd: after_create :send_email_to_author, if: :author_wants_emails?,
                                          unless: Proc.new { |comment| comment.article.ignore_comments? 
------------------------------------------------------------------------------------------------------------
TRANSACTION CALLBACKS (after_commit + after_rollback)
 2 callback này chỉ thực hiện khi database changes đã được commit hoặc rollback 
 sử dụng khi active record models cần tương tác với external system không phải là database transaction 
 ??????????????????????????????????????
 HALTING EXECUTION 
 queue bao gồm 
      + registered callback, model validation, database operation 
      + toàn bộ callback chain được bọc trong transaction 
      + nếu bất kì callback nào raise exception, excution chain bị halt và Rollback
      được thực hienj.
      để stop chain: throw :abort 