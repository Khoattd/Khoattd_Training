ACTIVE RECORD BASICS 
là model 
chịu trách nhiệm business data and logic 
mỗi model class refer 1 table, các attribute là các row 
trong active record : object carry both persistent data và behavior which operates on that data 
ORM
NAMING CONVENTION 
    Database table : Plural, underscore separating word vd: line_items
        forein_keys: thêm _id sau tên vd: item_id
    
    Model Class : Singular,  chữ đầu capitalize Vd: LineItem

    Optional : (reserved)
    created_at : ghi lại current date + time khi record đc tạo 
    updated_at :  khi record đc update 
    lock_version
    type  
    (table_name)_count -   
OVERRIDE NAMING CONVENTION 
    tạo table name khác cho model : 
    self.table_name = "my_products" #trong model class 
    tạo key khác cho model : 
    self.primary_key = "product_id"
CRUD:Read and Write 
Active Record tự động tạo method cho C,R,U,D để tương tác với data trong table 
    Create: 
    method New : return new object 
        vd:  @article = Article.new
    method Create: return new object, save to database 
        vd: @articles = Article.all
    Read: 
    [name].all: return collection with all user  
    [name].first: return first user 
    [ClassName].find_by
    david = User.find_by(name: 'David')
    Tìm tất cả users có tên là david, làm Code, sắp xếp theo ngày tạo :
    users = User.where(name: 'David', occupation: 'Code Artist').order(created_at: :desc)
    Update: khi 1 active record object được retrive, attribute có thể được modified và lưu 
        vd: 
            user = User.find_by(name: 'David')
            user.update(name: 'Dave')
            hoặc : 
            User.update_all "max_login_attempts = 3, must_change_password = 'true'"
    Delete: [name].destroy 
            [name].destroy_all 
VALIDATE 
    thêm trong class để validate trước khi được ghi vào database 
    validates :name, presence: true



