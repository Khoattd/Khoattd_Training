WHAT IS IT / WHAT IS IT FOR
Nhận diện URL và "phái tới" action của một controller hoặc rack application 
Generate paths và URL, tránh việc hardcord string trong view 
-----------------------------------------------
CONNECTING URLs To CODE 

-----------------------------------------------
GENERATING PATHS AND URLS FROM CODE 
  reduce brittleness(giòn) của view và làm code dễ hiểu hơn 
CONFIGURING THE RAILS ROUTER 
  config/routes.rb 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RESOURCE ROUTING : THE RAILS DEFAULT 
 cho phép declare nhanh routes cho givin resourceful controller
    thay thế toàn bộ các declare index, show,new, edit, create, update và destroy 
    vd: resources :articles 
------------------------------------
RESOURCES ON THE WEB 
    browser request page bằng cách thực hiện request cho 1 url bằng HTTP method vd: GET POST PATCH PUT DELETE
    mỗi method perform 1 operation trên resource 
------------------------------------
CRUD,VERB AND ACTIONS 
4 URLs - 7 action 
GET - #INDEX -      /photos 
GET - #NEW -        /photos/new
POST - #CREATE      /photos
GET  - #SHOW        /photos/:id
GET -  #EDIT        /photos/:id/edit 
PATCH/PUT - #UPDATE /photos/:id
DELETE - #DESTROY   /photos/:id 

Rails routes match theo thứ tự được specified
------------------------------------
PATH AND URL HELPERS 
vd: resources :photos 
    photos_path returns /photos
    new_photo_path returns /photos/new
    edit_photo_path(:id) returns /photos/:id/edit (for instance, edit_photo_path(10) returns /photos/10/edit)
    photo_path(:id) returns /photos/:id (for instance, photo_path(10) returns /photos/10)
-----------------------------------
DEFINING MULTIPLE RESOURCES AT THE SAME TIME 
vd:  resources :photos, :books, :videos
----------------------------------------
SINGULAR RESOURCES 
    chỉ show referered id chứ không show toàn bộ 
    vd: chỉ show currently loged user   get 'profile', to: 'users#show'
    get 'profile', action: :show, controller: 'users' 
    #sử dụng symbol thay vì users#show 
    resourceful route: 
    resource :geocoder
    resolve('Geocoder') { [:geocoder] }
    generate routes tương tự ở trên nhưng path sẽ là singular của geocoder 
    !!! nếu có cả resources :photos và resource :photo thì tạo cả 2 singular và plural routes trên cùng 1 controller là PhotosController
    SINGULAR RESOURCES HELPERS : 
        new_geocoder_path returns /geocoder/new
        edit_geocoder_path returns /geocoder/edit
        geocoder_path returns /geocoder
--------------------------------------
CREATING PATHS AND URLS FROM OBJECTS 
    set of routes:  
        resources :magazines do
            resources :ads
        end
    magazine_ad_path(@magazine,@ad)
        pass vào instances của magazine và ad thay vì index 
    url_for([@magazine,@ad])
        vd: 
        <%= link_to 'Ad details', [@magazine, @ad] %> 
        <%= link_to 'Ad details', url_for([@magazine, @ad]) %>
        rails tự động determine route 
ADDING MORE RESTful ACTIONS 
    ADDING MEMBER ROUTES 
        vd: 
            resources :photos do
            member do
                get 'preview'
            end
            end
        or   get 'preview', on: :member
    generate /photos/1/preview với GET. và route tới action preview trong PhotosController 
    đồng thời tạo photo_preview_url và photo_preview_path 
    có thể sử dụng get, patch, put, post, delete 
    nếu muốn xài params[:photo_id] thay vì [:id] tthì không cần out 

ADDING COLLECTION ROUTES     
    resources :photos do
        collection do
        get 'search'
        end
    end
    cho phép rails recognize path /photos/search với get, và chỉ tới route action tại photosController 
    có thể pass :on như với member route 

ADDING ROUTES FOR ADDITIONAL NEW ACTIONS
    để add một action thay thế, sử dụng :on 
        vd: get 'preview', on: :new
~!! không nên add quá nhiều action, chuyển sang hướng xài resource khác 
----------------------------
RESTRICTING THE ROUTES CREATED 
    default Rails tạo 7 route (index,show,new,create,update,edit,destroy) cho mỗi RESTful route trong app 
    SỬ DỤNG :ONLY VÀ :EXCEPT ĐỂ C HỈ TẠO RA CÁI ROUTE MONG MUỐN 
    vd: resources :photos, only: [:index,:show]
        #get tới /photos sẽ ok. POST sẽ fail 
        resources :photos, except: :destroy 
LISTING EXISTINGS ROUTES 
http://localhost:3000/rails/info/routes tới url này để check routes hoạt động 
hoặc sử dụng commadn để lấy của 1 thằng chi tiết 
$ bin/rails routes -g new_comment
    $ bin/rails routes -g POST
    $ bin/rails routes -g admin
    
    Sử dụng option -c để xác định route với 1 controller nhất định  
    vd: rails routes -c comments 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
NON RESOURCESFUL ROUTES 
    ngoài việc hỗ trợ resources route thì rails còn hỗ trợ route tùy ý 
    (setup each route separately trong app)
--------------------------------------------------
BOUND PARAMETERS 
    vd: get 'photos(/:id)', to: :display
    nếu imcoming request của /photos/1 được xử lý bởi route này, thì sẽ invoke display action trong photos controller, và 1 đc pass vào params[:id]
    nếu chỉ có /photos thì cũng invoke display action do id là optional - nằm trong ngoặc 
---------------------------------------------------
DYNAMIC SEGMENTS 
    get 'photos/:id/:user_id', to: 'photos#show'
        #dynamic segment khoogn chấp nhận dots(.) vì dot được sử dụng 
        vd: photos/1/3 
---------------------------------------------------
STATIC SEGMENT 
    VD: get 'photos/:id/with_user/:user_id', to: 'photos#show'
    with_user là static segment 
---------------------------------------------------
THE QUERY STRING 
    get 'photos/:id', to: 'photos#show'
    An incoming path of /photos/1?user_id=2 sẽ được dẫn tới show action của Photos controller. params will be { controller: 'photos', action: 'show', id: '1', user_id: '2' }.
--------------------------------------------------=
DEFINING DEFAULT 
    get 'photos/:id', to: 'photos#show', defaults: { format: 'jpg' }
    vd: nếu có request tới photos/12 thì format param sẽ được mặc định là jpg 
có thể sử dụng default trong 1 block    
    vd: defaults format: :json do
            resources :photos
        end
KHÔNG THỂ ORVERRIDE DEFAULT THÔNG QUA QUERY PARAMETER - VÌ MỤC ĐÍCH SECURITY 
-------------------------------------------------
NAMING ROUTES 
    sử dụng option as: 
    vd: get 'exit', to: 'sessions#destroy', as: :logout
        sẽ tạo logout_path, logout_url. 
        call 2 cái đó sẽ return /exit 
HTTP VERB CONSTRAINT 
    sử dụng option via để match nhiều verb một lúc
    vd: via: :all 
    match 'photos', to: 'photos#show', via: [:get, :post]
    !!! nếu goupr cả GET và POST trong 1 action duy nhất 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
NESTED RESOURCES 
    cho phép capture realationship giữa 2 resource trong routing. 
    vd: resources :articles do 
            resources :comments 
    end 
--------------------------------------------------
LIMIT TO NESTING 
    có thể nest resources trong nested resources 
    KHÔNG NÊN NEST RESOURCE NHIỀU HƠN 1 LEVEL
----------------------------------------------
SHALLOW NESTING 
    dùng để tránh nest quá nhiều level 
    chỉ tạo 1 vài route trong nested . 1 cái để bên ngoài 
    vd: resources :articles do
            resources :comments, only: [:index, :new, :create]
        end
        resources :comments, only: [:show, :edit, :update, :destroy]
    lúc này, sử dụng shallow: option để rút gọn đoạn code ở trên 
    vd: 
    resources :articles do
        resources :comments, shallow: true
      end
    HOẶC :
        resources :articles, shallow: true do
            resources :comments
            resources :quotes
        end
    HOẶC : #tạo théo scope với do 
        shallow do
            resources :articles do
            resources :comments
            resources :quotes
            resources :drafts
            end
        end
    thêm scope shallow_path: "sekret" do #thêm tên cho path
        scope shallow_prefix: "sekret" do # thêm tên cho helper
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
CONTROLLER NAMESPACES AND ROUTING 
        VD: namespace :admin do
            resources :articles, :comments
        end
    thêm path kiểu /admin/articles
        có n nhiều kiểu thêm namespace. 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
USING ROOT 
    root chỉ nhật GET action 
    dùng để set route cho '/'
    nên để root ở trên cùng file. là route quan trọng nhất nên match đầu tiên 
    có thể sử dụng root trong scope và namespaces 
    .......

    root to: 'pages#main'
    root 'pages#main' # shortcut for the above

