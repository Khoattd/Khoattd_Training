OVERVIEW 
    server-side validation  (ngoài ra còn client-side validation, controller level validation)
    WHY? 
        ensure that only valid dâta go to the database 
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
    vd:     Person.create(name: "John Doe").valid? # => true
            Person.create(name: nil).valid? # => false
              
