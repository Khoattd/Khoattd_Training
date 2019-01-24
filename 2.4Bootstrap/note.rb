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
