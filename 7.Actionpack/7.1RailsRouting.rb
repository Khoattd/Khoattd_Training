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
