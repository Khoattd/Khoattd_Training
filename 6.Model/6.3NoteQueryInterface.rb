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
    take 
        retrieve object tới thứ tự implicit (ẩn ?)
        return nil nếu không tìm được record 
        KHÔNG RAISE EXCEPTION. Nếu muốn raise exception take! 
        KẾT QUẢ DỰA VÀO DATABASE ENGINE  
            vd: client = Client.take 
                client = Client.take(3)
    first 
        tìm record theo thứ tự của primary_key.
        nếu trước first có order thì sẽ tìm theo order trước đó 
        return nil nếu không tìm được record, KHÔNG RAISE EXCEPTION, MUỐN RAISE XÀI FIRST!
            vd: Comment.first | Comment.first(3)
                Comment.order("created_at").find(3) 
    last 
        đảo của first, tìm từ dưới lên
    find_by 
        tìm first record match condition 
        return nill, không raise exception. nếu muốn raise exception xài find_by!
            vd: Comment.find_by body: "wwwwww"
                #tương tự comment.where(body: "wwwwww").take 
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
--------------------
PURE STRING CONDITON 
    vd: Article.where("comments_count='3'")
    KHÔNG NÊN SỬ DỤNG VÌ CÓ THỂ BỊ SQL INJECTION EXPLOIT
ARRAY CONDITION 
    vd: Client.where("order_count = ?" , params[:orders])
        Client.where("orders_count = ? AND locked = ?", params[:orders], false)
    first agument sẽ được xem là condition string, các additional argument phía sau sẽ được thay vào ?
!!!!! được highly perfer hơn pure string  (Client.where("orders_count = #{params[:orders]}")) 
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
        sử dụng BETWEEN SQL statement 
    Subset Conditions 
        sử dụng IN SQL statement 
        vd: Client.where(orders_count: [1,3,5])
            Article.where(comments_count: [nill,3])
    NOT Conditions 
        có thể thực hiện bằng where.not 
        vd: Client.where.not(locked:true)
    OR Condition 
        Client.where(locked: true).or(Client.where(orders_count: [1,3,5]))
        sẽ return các client có locker: true hoặc các client có orders_count là 1 3 5
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ORDERING 
    sử dụng để retrieve records từ database theo order nhất định, sử dụng order method 
        vd: Article.order(:created_at) | .order("created_at") | order("created_at DESC")
    hoặc multiple order ưu tiên sắp xếp theo thứ tự từ trái sang phai 
        vd: Article.order(comments_count: :asc, created_at: :desc) 
    hoặc Article.order(comments_count: :asc).order(created_at: :desc)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SELECTING SPECIFIC FIELDs
    chỉ chọn các field mong muốn thay vì chọn tất cả các field 
    vd: Article.select(:title,:comments_count)
    CHÚ Ý. cái này sẽ tạo model chỉ có các field mình lựa. Nếu access field mà mình không lựa sẽ báo ActiveRecord:MissingAttributeErrror 
    nếu chỉ muốn lấy record với giá trị duy nhất cho mỗi cái đúng trong field 
    vd: Article.select(:comments_count).distinct
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
LIMIT AND OFFSET 
    Limit dùng để giới hạn số lượng return object 
    OFFSet xác định chỗ bắt đầu tìm trong database 
    VD : Article.limit(5).offset(3) #không lấy thằng số 3 mà lấy thằng số 4 trở đi 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
OVERRIDING CONDITION 
    Unscope 
        loại bỏ 1 method nào đó
       vd: Article.where('id > 10').limit(20).order('id asc').unscope(:order)
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
        String SQL Fragment 
            vd: Author.joins("INNER JOIN posts ON posts.author_id = authors.id AND posts.published = 't'")
        ARRAY/HASH of Named Association 
        