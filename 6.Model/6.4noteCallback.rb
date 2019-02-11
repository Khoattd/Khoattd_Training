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
