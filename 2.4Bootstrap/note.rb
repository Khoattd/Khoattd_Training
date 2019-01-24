NOTE BOOTSTRAP
HTML,CSS,JS framework để  phát triển "responsive, mobile first" projects trên web
giúp front-end nhanh, dễ hơn, đa thiết bị
scale website và app dễ dàng 
------------------------------------------
Grid-system 
tạo layout cho page bằng cách chia page thành các cột, hàng chứa content
+ Row phải nằm trong .container (fixed-width) hoặc .container-fluid
+ tạo các row thể thành các colum 
+ content nằm trong các colum
+ phone: .col-xs-
  tables: .com-sm-
  medium desktop: .col-md- 
  large desktop: .col-lg-
thêm sau là độ rộng 1 colum (phần 12)
nếu tổng colum lớn hơn 12 thì nhảy xuống line dưới 
+  <div class="clearfix visible-xs-block"></div> :extra required viewport
+ .col-md-* .col-md-offset-x dời collum độ rộng * sang phải x collum 
+ NESTING COLLUM: 
các colum con phải có tổng thành 12 collum
--------------------------------------
TYPOGRAPHY

HEADING 
+ có thêm <small>secondary text</small>

BODYCOPY
+default: fontsize: 14; line-height: 1.428 
+ thêm class "lead" đêr làm paragraph to lên

INLINE TEXT ELEMENTS 
+ <mark> </mark> : hight light 
+ <del> </del> : thêm gạch ngang giữu tex 
+ <s> </s> : nhìn tương tự del
+ <ins> </ins>: text addition to document 
+ <u> </u> gạch chân 
+ <small> </small> nhỏ chữ (85% của parent)
ALIGNMENT CLASSES   
<p class="text-left">Left aligned text.</p>
<p class="text-center">Center aligned text.</p>
<p class="text-right">Right aligned text.</p>
<p class="text-justify">Justified text.</p>
<p class="text-nowrap">No wrap text.</p>
p class="text-lowercase">Lowercased text.</p>
<p class="text-uppercase">Uppercased text.</p>
<p class="text-capitalize">Capitalized text.</p>

TRANFORMATION CLASSES
<abbr title="attribute">attr</abbr> : thêm dotted bottom + hover 
thêm class intitialism để thêm tí font size nhỏ hơn 
<address> </address> thêm address ngay sau thằng parent gần nhất 
<blockquote></blockquote> wrap bất kì thằng html nào để nó thành quote 

<blockquote>
  <p></p>
  <footer> <cite title="Source Title">Source Title</cite></footer>
</blockquote>
thêm đoạn footer nhỏ dưới blockquote

thêm class blockquote-reverse vào blockquote để  right-alignment 
LIST : class="list-inline" để display inline
DECRIPTION :
<dl>
  <dt>...</dt> //term
  <dd>...</dd> //decription for term 
</dl>
thêm class "dl-horizontal" thể  term và decription nằm ngang

CODE :
<kpd> : thể hiện chữ hình cái nút
----------------
TABLE :
Available class: 
table-striped:  sọc hàng 
table-bordered: viền trong và ngoài table
table-hover: hover qua đổi màu
table-condensed: giảm cell padding còn 1/2
CONTEXTUAL CLASSES 
áp dụng cho row: <tr class=""> cho cell: <td class ="">
.active: apply hover color cho cell/row cụ thể
.success: positive action (màu)
.info: neutral change or action (màu)
.warning: need attention (màu)
.danger: negavtive attention
RESPONSIVE TABLE
bao table bằng <div class="table-responsive"> để table linh hoạt hơn trong các device nhỏ
thêm vào input class="form-control" để prestyle (width 100)
wrap input trong <div class="form-group"> để chỉnh width
Inline Form
//form-inline: cho form nằm cùng 1 hàng
// sr-only: không hiện label
//form-group: optinum spacing
//form-control: nhận default style
VD:
<form class="form-inline"> //cho form nằm cùng 1 hàng
  <div class="form-group">
    <label class="sr-only" for="exampleInputEmail3">Email address</label> 
    <input type="email" class="form-control" id="exampleInputEmail3" placeholder="Email"> 
  </div>
  <div class="form-group">
    <label class="sr-only" for="exampleInputPassword3">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword3" placeholder="Password">
  </div>
  <button type="submit" class="btn btn-default">Sign in</button>
</form>

HORIZONTAL FORM
<form class="form-horizontal">: xếp label và form cùng 1 hàng (không nhất thiết phải là form)
SUPPORTTED CONTROLS 
#text, password, datetime, datetime-local, date, month, time, week, number, email, url, search, tel, and color.#
form-control support texarea: <textarea class="form-control" rows="3"></textarea>
RADIO/CHECKBOX
radio, .radio-inline, .checkbox, or .checkbox-inline.
VD: <label class="checkbox-inline">
<input type="checkbox" id="inlineCheckbox1" value="option1"> 1
</label>
SELECTS :
<select multiple class="form-control"> : showw multiple option
STATIC CONTROL : cố định cái email@example.
<div class="form-group">
    <label class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
      <p class="form-control-static">email@example.com</p>
    </div>

CÁC PROPERTY:
+disabled => đặt trong <fieldset> để  disabled cả đống
+readonly 

BUTTON TAGS
Use the button classes on an <a>, <button>, or <input> element.
VD: <input class="btn btn-default" type="submit" value="Submit">
Color :  btn- : default, success, info, warning,danger, link
Size :   btn- :lg, sm, xs

IMAGE RESPONSIVE :
Thêm class image-responsive trong tag img
đổi shape image: thêm class img-rounded, img-circle, img-thumbnail

GLYPH ICON :
USE: chỉ sử dụng trên element rỗng, không mix với các element khác 
change location:@icon-font-path and/or @icon-font-name
<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
vd: sử dụng icon bên trong nút : 
<button type="button" class="btn btn-default btn-lg">
  <span class="glyphicon glyphicon-star" aria-hidden="true"></span> Star
</button>

DROP DOWN :
default: xếp ngay bên trene bên trái 
để chuyển sang phải add:
.dropdown-menu-right
Thêm dropdown header ở giữ các option:  <li class="dropdown-header">Dropdown header</li>
.divider: thêm thanh divider
.disabled
BUTTON GROUPS :
NAV :
vd: <ul class="nav nav-tabs">
<li role="presentation" class="active"><a href="#">Home</a></li>
<li role="presentation"><a href="#">Profile</a></li>
<li role="presentation"><a href="#">Messages</a></li>
</ul>

.nav-tab, .nav-pill, .nav-stacked, .nav-justified
vd: <ul class="nav nav-tabs nav-justified">
...
</ul>
<ul class="nav nav-pills nav-justified">
...
</ul>

thêm .disabled vào các li để disable nó