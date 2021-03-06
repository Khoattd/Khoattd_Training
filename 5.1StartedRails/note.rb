+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
MODE-VIEW-PRESENTER vs MODEL-VIEW-CONTROLLER
presenter là trung gian, nhận dữ liệu từ view, gửi tới model đồng thời update view 
model tác động tới view thông qua presenter 
view call method từ presenter khi có tác động 
 trong khi đó ở MVC : view > controller > model > view
 model: how raw data or define the eesssential component 
        reflect real-world thíngs 
 view: define how users see, interact 
controller: liên lạc giữa view và model, nhận user input và quyết định what to do. 
            brain of the application
giống nấu ăn. model là tủ lạnh nắm giữ nguyên liệu (rawdata)
            . controller là recipe, quyết định lấy nguyên liệu nào, ghép lại nhưu nào, xử lý như nào 
            . view là bày ra bàn 


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Rail  là web app development framework được viết trên ruby để làm cho việc phát triển web đơn giãn , nhanh hơn 
2 principles: 
+ dont repeat your self: DRY 
+ convention over configuration 

CONTROLLER :
    nhận về request cụ thể của app 
    routing quyết định controller nào nhận request nào 
    một controller có thể có nhiều routes, mỗi routes xử lý 1 actions khác nhau 
    mỗi actions có mục đích là thu thập thông tin đưa vào view 
    mỗi controller là một class được inherit từ class cha Application controller 
    CHỈ CÓ PUBLIC METHOD MỚI LÀM ACTIONS ĐƯỢC 
    define new action giống như define một method của class 
create new controller: 
$ bin/rails generate controller Welcome index

VIEW :
    display thông tin thu thập được "a human readable format"
    default được viết bằng embedded ruby 
    mỗi action đều phải có view tương ứng để display nếu không sẽ báo lỗi unknowAction

ROUTING FILE : hold entries in a special DSL 
cho rails biết kết nối giữa incomming request   với controller và actions 
config/routes.rb 

RESOURCE : collection of similar object ex: articles, animals..
    có thể Create-Read-Update-Delete : CRUD operation 
    thêm resource ở :  config/routes.rb 
    resources :(resourcename)
MIGRATION :
    RUBY CLASSes được thiết kế để làm cho việc tạo và chỉnh sửa tables trong database dễ hơn 
    timestamp: để tables được xử lý theo thứ tự nó được tạo 
ATTENTION :
    Rails automatically wraps fields that contain an error with a div with class field_with_errors.
    You can define a css rule to make them standout.
    Order in controller: index, show, new, edit, create, update and destroy

WORK FLOW :
1) create new app 
    rails new [appname]
    cd [appname]
2) starting server 
    bin/rails server 
   checking routes 
    bin/rails routes 
3) generate controller 
        bin/rails generate controller [name] vd: bin/rails generate controller Welcome index 
        get in config/routes.rb 
        add root 'welcome#index'
   add resources in config/route.rb
        resources :[resourcesName]
    generage controller for resources :
        bin/rails generate controller [resourcesName]  #case insen
4) Add action to controller 
    get in app/controllers/.rb 
    define a method vd: def new
5) create a view (html) fix with the controller 
    get in app/views/resourcesName/ create new.html.erb 
    fix that  html 
6)  point to the right action: url: articles_path
<= form_with scope: :article, url: articles_path, local: true do |form| =>
7)  add action to controller again 
    def create 
8) create model   
        bin/rails generate model [resourcesName] [variable] 
            vd: bin\rails generate model Article title:string text:text 
    database được tạo tại: db/migrate/ .rb 
9) migrate db (tạo table)
        bin/rails migrate
10) save data submit to database 
    get in controller 
        def create 
            @article = Article.new(params[:article]) 
            @article.save
            redirect_to @article
11) add datatype security 
    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
12) edit and update
    def edit
        @article = Article.find(params[:id])
    end
    def update
        @article = Article.find(params[:id])
       
        if @article.update(article_params) #@article.update(title: 'A new title') chỉ update tittle 
          redirect_to @article
        else
          render 'edit'
        end
      end
13) Cleanup duplication view 
    <h1>New article</h1>
    <%= render 'form' %>  #lấy file form.html.erb 
     <%= link_to 'Back', articles_path %>
14) Deleting article 
def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end
  alert khi destroy:
   <td><%= link_to 'Destroy', article_path(article),
    method: :delete,
    data: { confirm: 'hahahahahah' } %></td>
15) add second model
    bin/rails generate model Comment commenter:string body:text article:references
        option articles: references sẽ tạo một cột trong db article_id làm external_ key cho table comment 
add has_many: comments trong model article.rb để một article có nhiều comment
16 ) adđ route cho comments. add relationship cho comment và article :
    config/routes.rb
    resources :articles do 
        resources :comments
...............
SECURITY 
thêm đầu controller 
http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
                                                              only: :delete 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CONFIGURATIONS 
4 chỗ để  thiết lập initialize
    config/application.rb
    Environment-specific configuration files VD: config/environments/production.rb
    Initializers
    After-initializers

    In the rare event that your application needs to run some code before Rails itself is loaded, 
    put it above the call to require 'rails/all' in config/application.rb.
------------------------------------------------
CONFIGURATION RAILS COMPONENTS 
GENERAL CONFIGURATIONS 
config.after_initialize chạy block sau khi Rail init xong app 
config.after_initialize do
    ActionView::Base.sanitized_allowed_tags.delete 'div'
  end
config.cache_classes : quyết định xem classé và modules của app có nên reload lại sau mỗi 
request hay không. dev mode : false. product,test mode : true 
config.beginning_of_week : set ngày bắt đầu của tuần  
config.console : set class có thể sử dụng bởi rail.console 
config.enable_dependency_loading : enables auto loading. kể cả bật cache_classes 
config.middleware : config middleware của application


1) App : chứa các subfolder cấu thành nên hoạt động của application.
    a) asset chứa các subfolder lưu các chỉnh sửa của javascripts, stylesheets, images 
        i) images : chứa các images dùng trong app 
        ii) javascripts: chưá code javascripts
        iii) stylesheets: chứa các file css style cho app 
    b) controllers: chứa các file controller của app 
    c) heplers: chứa các module helper 
    d) mailers: chứa địa chỉ maill của ng lập trình app 
    e) models: chứa các models của app 
    f) views: chứa các file html.erb để định dạng ui cho app 
2) Config: chứa các file config routes, database... của app 
    a) application.rb : file config chung của hệ thống 
    b) database.yml: file config cho database của app
    c) environments: chứa file config cho từng evironment 
        i) development: file config cho app trong giai đoạn phát triển 
        ii) production: file config cho app khi đưa ra người dùng 
        iii) test : file config của app sử dụng cho test 
    d) intializers: chứa các file thiết lập khi rails bắt đầu khởi động app 
    e) locals: chứa các file config cho các khu vực khác nhau trên thế giới 
    f) routes.rb: file kết nối request cho controllers và actions cụ thể 
3) Db folder chứa database của app, database schema và database migration 
    i) migrate: chứa các file khai báo tables của database
    ii) shcema.rb : file tổng hợp chứa các table của database
    iii) seeds.rb
4) gemfile, gemfile.lock: liệt kê các gem và version được sử dụng trong hệ thống. File này 
được sử dụng bởi Bundler gem 
5) log) lưu lại thông tin hoạt động phát triển
6) public. chứa các file và asset có được public 
7) readme) chứa note hoặc instruction manual
8) test: chứa unit test của appp 
9) vendor : chứa code của bên thứ 3