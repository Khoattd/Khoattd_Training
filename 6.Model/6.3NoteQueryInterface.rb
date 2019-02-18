DÙNG ĐỂ XỬ LÝ RECORD TRONG DATABASE 

    class Client < ApplicationRecord
        has_one :address
        has_many :orders
        has_and_belongs_to_many :roles
    end
    class Address < ApplicationRecord
        belongs_to :client
    end
    class Order < ApplicationRecord
        belongs_to :client, counter_cache: true
    end
    class Role < ApplicationRecord
        has_and_belongs_to_many :clients
    end
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RETRIEVING OBJECTS FROM THE DATABASE 
    dùng để retrieve object từ database 
    các finder method cho phép pass argument để perform queries to database mà không cần viết raw SQL 
    BAO GỒM     
        find
        create_with
        distinct
        eager_load
        extending
        from
        group
        having
        includes
        joins
        left_outer_joins
        limit
        lock
        none
        offset
        order
        preload
        readonly
        references
        reorder
        reverse_order
        select
        where
-----------------------------------------
RETRIEVING A SINGLE OBJECT
    find 
        retrieve object ứng với PRIMARY KEY được pass và option 
            vd: client = Client.find(10)
                clients = Client.find([1,10])
        Raise ActiveRecord::RecordNotFound nếu không có matching record.
        Trong trường hợp tìm nhiều object, chỉ cần 1 object không tìm th ấy cũng raise exception 
        SELECT * FROM clients WHERE (clients.id = 10) LIMIT 1
        SELECT * FROM clients WHERE (clients.id IN (1,10))

    take 
        retrieve object tới thứ tự implicit (ẩn ?)
        return nil nếu không tìm được record 
        KHÔNG RAISE EXCEPTION. Nếu muốn raise exception take! 
        KẾT QUẢ DỰA VÀO DATABASE ENGINE  
            vd: client = Client.take 
                client = Client.take(3)
                SELECT * FROM clients LIMIT 1
    first 
        tìm record theo thứ tự của primary_key.
        nếu trước first có order thì sẽ tìm theo order trước đó 
        return nil nếu không tìm được record, KHÔNG RAISE EXCEPTION, MUỐN RAISE XÀI FIRST!
            vd: Comment.first | Comment.first(3)
                Comment.order("created_at").find(3) 
                SELECT * FROM clients ORDER BY clients.id ASC LIMIT 1
    last 
        đảo của first, tìm từ dưới lên
        SELECT * FROM clients ORDER BY clients.id DESC LIMIT 1
    find_by 
        tìm first record match condition 
        return nill, không raise exception. nếu muốn raise exception xài find_by!
            vd: Comment.find_by body: "wwwwww"
                #tương tự comment.where(body: "wwwwww").take 
         SELECT * FROM clients WHERE (clients.first_name = 'Lifo') LIMIT 1
------------------------------------------------
RETRIEVING MULTIPLE OBJECT IN BATCHES 
    batch: gom 1 tập các record rồi xử lý thay vì xử lý cả database 1 lúc như bình thường 
----------------- 
    find_each
        retrive record thành batch rồi pass từng batce vào block code. default là 1000 record 1 batch 
            vd:User.find_each do |user|
                    NewsMailer.weekly(user).deliver_now
                end
        PHẢI KHÔNG CÓ THỨ TỰ 
        OPTION FOR FIND_EACH 
        :bacth_size giới hạn số record trong mỗi batch  
            vd: User.find_each(batch_size: 5000) do |user|
        :start 
            default record được fetch theo thứ tự tăng dần của primary_key (phải là integer) 
            start xác định vị trí bắt đầu. usefull khi muốn resume interuptted batch 
            vd: User.find_each(start: 2000, finish: 10000) do |user|
        :finish xác định vị trí kết thúc 
        :error_on_ignore 
            Overrides the application config to specify if an error should be 
            raised when an order is present in the relation.
-----------------
    find_in_batches 
        tương tự như find_each (cùng retrieve batches of records)
        find_in_batches đưa vào block bacth NHƯ LÀ MỘT ARRAY CÁC MODEL (trong khi find_each pass vào block từng 
        records)
        hoạt động trên cả class và relation 
                vd: Invoice.pending.find_in_batches do |invoices|
                        pending_invoices_export.add_invoices(invoices)
                    end
        KHÔNG ĐƯỢC CÓ THỨ TỰ vd: Invoice.order("created_at DESC").pending 
        CÓ CÙNG OPTION VỚI FIND_EACH 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CONDITIONS 
    method WHERE cho phép pass codition để giới hạn records được return
    RETURN ACTIVERECORD RELATION  
--------------------
PURE STRING CONDITON 
    vd: Article.where("comments_count='3'")
    KHÔNG NÊN SỬ DỤNG VÌ CÓ THỂ BỊ SQL INJECTION EXPLOIT
ARRAY CONDITION 
    vd: Client.where("order_count = ?" , params[:orders])
        Client.where("orders_count = ? AND locked = ?", params[:orders], false)
    first agument sẽ được xem là condition string, các additional argument phía sau sẽ được thay vào ?
!!!!! được highly perfer hơn pure string  (Client.where("orders_count = #{params[:orders]}")) 
    SELECT * FROM clients WHERE (clients.locked = 1)
Place_holder Conditions 
    thay ? bằng key trong conditions string cho dễ đọc hơn 
        vd: Client.where("created_at >= :start_date AND created_at <= :end_date",
        {start_date: params[:start_date], end_date: params[:end_date]})
HASH CONDITIONS 
    increase the readability cho condition syntax 
    dùng để pass hash với key của field muốn qualified và value để qualify 
    !!!!! CHỈ SỬ DỤNG ĐƯỢC EQUALITY, RANGE VÀ SUBSET CHECKING 
    Equality Conditions 
        vd: Client.where(locked:true) | Client.where('locked':true)
    Range Conditions 
        vd: Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
            Article.where(comments_count: 2..3)
            SELECT * FROM clients WHERE (clients.created_at BETWEEN '2008-12-21 00:00:00' AND '2008-12-22 00:00:00')
        sử dụng BETWEEN SQL statement 
    
    Subset Conditions 
        sử dụng IN SQL statement 
        vd: Client.where(orders_count: [1,3,5])
            Article.where(comments_count: [nill,3])
            SELECT * FROM clients WHERE (clients.orders_count IN (1,3,5))
            
    NOT Conditions 
        có thể thực hiện bằng where.not 
        Thằng naỳ không đếm nil 
        vd: Client.where.not(locked:true)
        SELECT * FROM clients WHERE (clients.locked != 1)

    OR Condition 
        Client.where(locked: true).or(Client.where(orders_count: [1,3,5]))
        sẽ return các client có locker: true hoặc các client có orders_count là 1 3 5
        SELECT * FROM clients WHERE (clients.locked = 1 OR clients.orders_count IN (1,3,5))
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ORDERING 
    Return ACTIVE RECORD RELATION
    sử dụng để retrieve records từ database theo order nhất định, sử dụng order method 
        vd: Article.order(:created_at) | .order("created_at") | order("created_at DESC")
    hoặc multiple order ưu tiên sắp xếp theo thứ tự từ trái sang phai 
        vd: Article.order(comments_count: :asc, created_at: :desc) 
    hoặc Article.order(comments_count: :asc).order(created_at: :desc)
    SELECT * FROM clients ORDER BY orders_count ASC, created_at DESC
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SELECTING SPECIFIC FIELDs
    RETURN ACTIVE RECORD RELATION 
    chỉ chọn các field mong muốn thay vì chọn tất cả các field 
    vd: Article.select(:title,:comments_count)
    SELECT title, comments_count FROM articles
    CHÚ Ý. cái này sẽ tạo model chỉ có các field mình lựa. Nếu access field mà mình không lựa sẽ báo ActiveRecord:MissingAttributeErrror 
    nếu chỉ muốn lấy record với giá trị duy nhất cho mỗi cái đúng trong field 
    vd: Article.select(:comments_count).distinct
    SELECT DISTINCT comments_count FROM articles
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
LIMIT AND OFFSET 
    RETURN ACTIVE RECORD RELATION 
    Limit dùng để giới hạn số lượng return object 
    OFFSet xác định chỗ bắt đầu tìm trong database 
    VD : Article.limit(5).offset(3) #không lấy thằng số 3 mà lấy thằng số 4 trở đi 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
OVERRIDING CONDITION 
    Unscope 
        loại bỏ 1 method nào đó
       vd: Article.where('id > 10').limit(20).order('id asc').unscope(:order)
       SELECT * FROM articles WHERE id > 10 LIMIT 20
        #loại bỏ không tính method order 
        Article.where(id: 10, trashed: false).unscope(where: :id)
        #chỉ thực hiện where(trashed: false)
    Only
        Ngược lại với unscope, chỉ thực nhiện những cái trong only
        vd: Article.where('id > 10').limit(20).order('id desc').only(:order, :where)
            #chỉ thực hiện order và where, không thực hiện limit 
    Reorder 
        thực hiện query theo order khác với order được khai báo trước đó (override nó)
        class Article < ApplicationRecord
            has_many :comments, -> { order('posted_at DESC') }
        end        
        Article.find(10).comments.reorder('name') #sẽ liệt kê các comments của article_id 10 theo thứ tự name chứ không theo thứ tự posted_at 
    Reverse_order 
        làm ngược lại method order nếu có 
        vd: Client.where("orders_count > 10").order(:name).reverse_order #thực hiện order name desc 
        Nếu không có order, sẽ thực hiện reverse order cho primary key 
    Rewhere 
        Override existing, named where condition
        vd: Article.where(trashed: true).rewhere(trashed: false)
        
        NẾU KHOOGN SỬ DỤNG REWHERE MÀ SỬ DỤNG WHERE NÓ SẼ THỰC HIỆN AND 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
JOINNING TABLE 
    Joins 
        RETURN ACTIVE RECORD RELATION 
        String SQL Fragment 
            vd: Author.joins("INNER JOIN posts ON posts.author_id = authors.id AND posts.published = 't'")
        ARRAY/HASH of Named Association 
            thực hiện inner joins trong SQL 
            vd: Category.joins(:articles)
            SELECT categories.* FROM categories INNER JOIN articles ON articles.category_id = categories.id
           #tạo 1 bảng joins giữa catagory và article 
        Join Multiple Association : 
            vd: Article.joins(:category, :comments)
            INNER JOIN 2 LẦN 
            # category has_many Article, Article has_many comment
            JOIN NESTED ASSOCIATION (SINGLE LEVEL)
                VD: Article.joins(comments: :guest)
                INNER JOIN comments ON comments.article_id = articles.id
                INNER JOIN guests ON guests.comment_id = comments.id
                #Article hass_many comments, Comment has_many guests 
                #return all articles that have a comment made by a guest
            JOINS NESSTER ASSOCAITON (MULTIPLE LEVEL)
                Category.joins(articles: [{ comments: :guest }, :tags])
                #return all categories that have articles, where those articles have a comment made by a guest, and where those articles also have a tag.
        SPECIFYING CONDITION ON THE JOINED TABLES
            có thể specify condition trên join table sử dụng ARRAY hoặc String condition. Hash condition cung cấp 1 syntax đặc biệt để specifying conditions 
                vd: time_range = (Time.now.midnight - 1.day)..Time.now.midnight
                    Client.joins(:orders).where('orders.created_at' => time_range)\
    LEFT_OUTER_JOINS 
        vd: Author.left_outer_joins(:posts).distinct.select('authors.*, COUNT(posts.*) AS posts_count').group('authors.id')
        "return all authors with their count of posts, whether or not they have any posts at all"
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EAGER LOADING ASSOCIATION 
    mechanism dùng để load associated record của object được return bởi model.find sử dụng ít queries nhất có thể
    N+1 QUERY PROBLEM 
        clients = Client.limit(10)
        clients.each do |client|
        puts client.address.postcode
        end 
        #cái này tìm 10 client rồi in ra posscode. 
        # bao gồm 1 query là find rồi query cho 10 cái client để load .
    SOLUTION TO N+1 QUERY PROBLEM 
        thay bawgnf clients = Client.includes(:address).limit(10)
        lúc này khi find client được load rồi thì address cũng được load theo 
        #lúc này chỉ thực 2 query là find client và find address in (1,2,3,..10)
-------------------------
EAGER LOADING MULTIPLE ASSOCIATIONS 
    SỬ DỤNG ARRAY 
        VD: Article.includes(:category, :comments)
            #Thằng này load tất cả các category và comment được associate với article 
    SỬ DỤNG HASH 
        vd: Category.includes(articles: [{ comments: :guest }, :tags]).find(1)
        #lấy category id 1, load articcles, tags được associated với articles, tất cả guest được associated với comments 
--------------------------
SPECIFYING CONDITIONS ON EAGER LOADED ASSOCIATION 
    NÊN SỬ DỤNG JOIN HAY VÌ CÁI NÀY 
    NẾU MUỐN SỬ DỤNG CÁI NÀY THÌ XÀI WHERE 
        vd: Article.includes(:comments).where(comments: { visible: true })
         #thằng này thực hiện left_outer_join trong khi join thực hiện INNER JOIN 
         #sử dụng where kiểu này chỉ xài hash đc t hôi không xài string được 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
FINDING BY SQL 
    find_by_sql return object 
    vd: 
    Client.find_by_sql("SELECT * FROM clients
      INNER JOIN orders ON clients.id = orders.client_id
      ORDER BY clients.created_at desc")
--------------------------
    select_all
        return activeRecord::result
        giống find_by_sql nhưng không instantiate nó 
        vd:  a = Client.connection.select_all("SELECT * FROM clients
        INNER JOIN orders ON clients.id = orders.client_id WHERE orders.item = 20
       ")
        NẾU MUỐN TRẢ VỀ OBJECT THÌ THÊM .to_hash 
    pluck 
        trả về array chứa giá trị cuar cột được chọn trong pluck vd: 
        Client.where(orders_count: 4).pluck(:name)
         #=> ["elephant","name3"]
            SELECT name FROM clients WHERE orders_count = 4
        Client.distinct.pluck(:name)
            SELECT DISTINCT name FROM clients 
        Client.pluck(:id, :name)       
        #=> [[1,"Tran thanh dan khoa"],[2,"elephant"]
!!!!!! Theo sau pluck không thế có thêm scope, trước thì được 
!!!!!! không thể override method 
    ids 
        dạng ngắn của pluck(:id)
------------------------------
EXISTACE OF OBJECT 
    sử dụng .exists? để check object có tồn tại hay không 
    RETURN TRUE/FALSE 
    thực hiện query giống find nhưng thay vì trả object thì trả boolean
        Client.exists?(1) | Client.exists?(orders_count: 4)
        Client.where(orders_count: 4).exists?
        Client.exists?(id: [1,2,3]) #chỉ cần 1 cái đúng là return true
        Client.joins(:address).where("addresses.location"=>"united state").exsist?
    Có thể dụng dụng .any?, .many?
------------------------------
CALCULATION 
    count 
        vd: Client.count #SELECT COUNT(*) FROM "client"
            Client.where(orders_count: 4).count
             # # SELECT COUNT(*) FROM clients WHERE (orders_count: 4)
    average
        vd: Client.average(:orders_count) 
        #  SELECT AVG("clients"."orders_count") FROM "clients"
    tương tự cho minimum,maximum,sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SCOPE 
    LUÔN LUÔN RETURN ACTIVE RECORD RELATION 
        vd: 
            class Article < ApplicationRecord
            scope :published, -> { where(published: true) }
            end
        Có thể có nhiều scope 1 lúc 
    PASSING IN ARGUMENT
        vd:
            class Article < ApplicationRecord
                scope :created_before, ->(time) { where("created_at < ?", time) }
            end
            call :  Article.created_before(Time.zone.now)
    USING CONDITIONAL 
        vd: 
            class Article < ApplicationRecord
                scope :created_before, ->(time) { where("created_at < ?", time) if time.present? }
            end
    APPLYING A DEFAULT SCOPE 
            default_scope { where("removed_at IS NULL") }
            Khi queries được thực hiện trên model: SELECT * FROM clients WHERE removed_at IS NULL
    Merging Of Scopes 
        vd:
            class User < ApplicationRecord
                scope :active, -> { where state: 'active' }
                scope :inactive, -> { where state: 'inactive' }
            end
            User.active.inactive
            # SELECT "users".* FROM "users" WHERE "users"."state" = 'active' AND "users"."state" = 'inactive'
            User.active.where(state: 'finished')
            # SELECT users.(*) FROM users WHERE users.state= "active" AND users.state= "inactive"
        !!! Nếu có default_scope thì default scope luôn được prepend trước scope và where condition 
    REMOVING ALL SCOPING
        #useful khi default scope không áp dụng cho query nào đó
        Client.unscope.load  | Clietn.unscope