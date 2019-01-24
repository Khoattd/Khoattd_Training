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
