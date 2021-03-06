Được xây dựng trên JS
Jquery làm được thì JS làm được nhưng dài hơn (không có chiều ngược lại)
mục tiêu: làm gọn gàng code. Cho phép sử dụng attribute selector với nhưng
browser không hỗ  trợ
AJAX được sử dụng để giao tiếp giữa client và server mà không cần reload page vd như yêu cầu check mail mới 
https://learn.jquery.com/ajax/jquery-ajax-methods/
Jquery Validation: plugin của jquery giúp kiểm tra độ valid của dữ liệu phía client,
giảm tải cho server. (vd: khi client nhập sai yêu cầu về tên, gửi lên server, không 
có jquevy validation thì server sẽ phải trả về, tốn tài nguyên). Jquery validation 
sẽ check legit r ms gửi

PHÂN BIỆT EACH VS MAP
Cả 2 đều pass các element trong matched set vào function.
Each trả về kết quả của fucntion (trả về array cũ)
Map trả về array mới Jquery Object chứa kết quả của function

Each tương tự như for 
Map tạo ra mảng mới với mỗi phần tử trong mảng đó là các phần tử trong mảng cũ được đưa qua function

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SELECTOR
+Basic:
".a.b" có cả a và b 
".a .b" cái class b trong cái class a 
".a, .b" có class a hoặc b

-Attribute
valid identifier:  " '' "; ' "" '; " \"\" "; ' \' \' '
cú pháp thông thường :$( "[attribute *type* 'value']" ) vd $( "a[hreflang|='en']" )
+ chứa or theo sau bằng -: |=
+ chứa chuỗi substring trong value: *=   //chỉ cần chứa vd 'man' found: milkman
+ chứa word: ~=  // chưa từ riêng biệt: vd 'man' found: milk man 
+ kết thúc giống với: $= // vd 'letter' found: newsletters
+ Có attribute nhưng ko phải hoặc ko có attribute: !=
+ Start with: ^= vs 'news' found newsletters
+ [Attribute]: có attribute
+ Multiple Attribute: ( "[1][2][N]" ): phải có tất cả 1 tới N ms select
---------------------------------------------------------------------------------------------
FILTER 
-BASIC FILTER
CÚ PHÁP THÔNG THƯỜNG: VD $("div:animated")
+ :animated select thằng nào đang có animation 
+ :eq(index) lựa thằng thứ index trong đống matched trc đó (zero indexed) vd: $("#div2 input:eq(2)")
+ :even/:odd lựa những thằng có index chẵn/lẻ trong matched $("#div2 input:even")
+ :first thằng đầu tiên trong đống matched  (tương đương :ed(0)) (jquery extension cải thiện = .filter(":first"))
+ :focus thằng đang có focus trong đống matched
+ :gt(index) những thằng có stt lớn hơn index trong đống matched (jquery extension thay = $(" ").slice(index))
+ :lt(index) ngược với gt (jquery extension thay = $(" ").slice(0, index) )
+ :header lọc ra những thằng là h1, h2 ...  (jquery extension cải thiện = .filter(":header"))
+ :lang(language) lọc theo ngôn ngữ
+ :not(selector) lọc ra những thằng ko match cái selector vd: $("#div2 input:not([type='text'])")
----------------------------------------------------------------------------------------------------------------
-CHILD FILTER
+ :first-child tất cả những thằng là con cả
+ :last-child lọc ra những thằng là con út. tính luôn cháu chắt chit nếu trước : rỗng
+ :first-of-type lọc ra những thằng con đầu tiên của loại nó. Cháu ngoại cũng tính nếu trước : rỗng
+ :last-of-type . ngược với first-of-type
+ :nth-child(index/even/odd/equation)  tìm trong những thằng matched trước đó những thằng thỏa yêu cầu con.
SỐ THỨ TỰ ĐỂ TÍNH CON LÀ SỐ THỨ TỰ CỦA NÓ KHI CHƯA LỌC TRONG THẰNG CHA.
 vd: tìm input là con thứ 2  trong tất cả các div: $("div input:nth-child(2)"): những thằng input là con cả 
 sẽ ko đc chọn .1 INDEXED
+ :nth-last-child(index/even/odd/equation) giống nth-child nhưng từ đếm ngược lên
+ :nth-last-of-type(index/even/odd/equation): giống nth-child nhưng chỉ tính type của nó
+ :nth-of-type(): tương tự như last-of-type nhưng từ trên xuống
+ :only-child thằng là con 1
+ :only-of-type thằng là duy nhất trong cha nó
-----------------------------------------------------------------------------------------
CONTENT FILTER
+ :contain(text) tìm thằng trong nội dung có text. CASE SENSITIVE
+ :empty tìm tất cả những thằng không có con
+ :has(selector) tìm những thằng thỏa yêu cầu của selector (jquery extension thay bằng $(selector).has(selector))
vd: $("div").has("p:contains('haha')")
+ :parent tìm những thằng có con (jquery extension xài .filter(":parent"))
-----------------------------------------------------------------------------------------
FORM
+ :button tìm những thằng button và những thằng type là button  (jquery extension xài .filter(":button"))
+ :checkbox tìm những thằng type là textbox (jquery extension xài [type="checkbox"])
+ :checked
+ :disabled, :enabled
+ :file tìm những thằng có type là file (jquery extension xài [type="file"])
+ :focus
+ :image (jquery extension xài [type="image"])
+ :input (jquery extension xài .filter(":input"))
+ :password (jquery extension xài [type="password"])                    document.querySelectorAll()
+ :radio (jquery extension xài [type="radio"])
+ :reset(jquery extension xài [type="reset"]) 
+ :selected không hoạt động với checkbox + radio  (jquery extension xài .filter(":selected"))
+ :submit (jquery extension xài input[type="submit"], button[type="submit"])
+ :text tìm những thằng có type là text (jquery extension xài [type="text"])
---------------------------------------------------------------------------------------------
HIERACHY
+ $("parent > child") tìm những thằng child có cha là parent vd $("ul.topnav > li") tìm những thằng li có cha là ul
không tính cháu chắt chít
+ $("ancestor descendant") giống như cái > nhưng tính cả cháu chắt chít
+ $("prev + next") tìm những thằng next là anh em NGAY SAU prev
+ $("prev ~ sibling") tìm trong tất cả các anh em có thằng prev

TRAVERSING FILTER VS FILTER
vd: $("div").eq(2) vs $("div:eq(2)")
traversing filter làm lần lượt. bước selector trước sau đó filter eq 
:eq(2) filter trực tiếp 

+ .eq()
+ .filter(selector/function/elements/selection) giảm matched set thêm 1 lần nữa. Function trả về boolean
vd: $( "li" ).filter( ":even" )
vd2: $( "li" )
  .filter(function( index ) {return $( "strong", this ).length === 1;})
    .css( "background-color", "red" );   tìm những thằng li có 1 strong 
+ .first() / .last() lọc lại matched set còn thằng đầu tiên / cuối cùng 
+ .has(selector/contained)
+ .is(selector/function/selection/elements) (return true) thằng này ko tạo jquery object mới,
chỉ giúp check object hiện tại hỏa điều kiện hay ko 
+ .map( callback) cho mỗi thằng trong matched set vào function, return 1 jquery objec mới
+ .not(selector/function/selection) lọc những thằng không mathced yêu cầu, thằng nào không matched thì được chọn
+ .slice(start [,end]) cắt matched set thành đoạn, có thể  xài số âm 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
DOM MANIPULATION METHODS
+ .addClass("classname"/fucntion) /.removeClass : thêm hhoặc bỏ class, thêm nhiều class cùng lúc được 
có chấp nhận function: 
vd: $( "ul li" ).addClass(function( index ) {
    return "item-" + index;
  });

+ .hasClass("classname") check trong matched set có class name ko. return boolean 
+ .toggleCLass
----------------------------------------------
COPY
+ .clone() deep copy tạo ra một element mới. không pass argument thì event handler sẽ ko copy theo. 
vd : .clone(true,true). không nên xài khi element có id 

----------------------------------------------
INSERTION, AROUND 

+ .wrap([selector]) / .unwrap() thêm hoặc xóa parent của thằng nào đó. 
  vd: $("p").warp("<div class='test'> </div>") =>> tìm những thằng p rồi bọc nó bằng div 
+ .wrapAll() thằng này tạo DOM tree mới. những thằng không có trong set matched ra rìa ko đc wrap 
  vd: tương tự wrap
+ .wrapInner( [function]) thêm phân tử vô trong element đc chọn 
  vd: $("div").wrapInner("<div class='test'></div>") thêm 1 div class test vào trong các div hiện có
  thằng div class test wrap xung quanh content của thằng wrap đc chọn
  vd: pass function: $( ".inner" ).wrapInner(function() {
    return "<div class='" + this.nodeValue + "'></div>";
  });

------------------------------------------------
INSERTION, INSIDE
+ .append(content [,content]) có thể  pass function thêm content vào content của matched set 
  vd: $( ".inner" ).append( "<p>Test</p>" ); : thêm vào content của thằng có class inner một p nội dung test
  có thể  thêm element này vào element khác 
   vd: $("div").append($("p.wow")) DI CHUYỂN p có class wow vào trong div. nếu có nhiều target thì p.wow 
   sẽ được clone

+ .appendTo() hoạt động giống append nhưng cú pháp ngược lại 
  vd: ("<p>Test</p>").appendTo(".inner") => thêm p có conntent test vào content của .inner

+ .html() output là content html của thằng đầu tiên trong matched set (XML ko xài được)
  vd: $("p").html() => <strong>Description: "</strong>Get the HTML contents of the first."
+ .html(htmlString/function) set html content của TỪNG thằng trong matched set.
  cái htmlString sẽ thay tất cả các content của thằng trong matched set
   vd: $( "div.demo-container" ).html( "<p>All new content. <em>You bet!</em></p>" );
+ .prepend()/.prependTo() tương tự như append nhưng THÊM VÀO ĐẦU
+ .text() lấy ra text trong content của tất cả những thằng con cháu chắt chít của từng thằng trong matchedset
  .text("texta"/function) thêm text a vào content. Raw text, không input element đc như html
-----------------------------------------------------------------------------------------------
DOM INSERTION/OUTSIDE
+ .after() các tính chất tương tự .append()
vd $( ".inner" ).after( "<p>Test</p>" ); thêm 1 p sau .inner
+ .before()
+ .insertAffter() tương tự như .appendTo()
+ .insertBefore()
--------------------------------------------------------------------------------------
DOM REMOVAL 
+ .detach(selector) loại bỏ trong matched set các selector. tuy nhiên vẫn lưu lại và có thể  sử  dụng 
chỗ khác được (append, after)
+ .empty() xóa tất cả các con cháu chắt chít của mấy thằng trong matched set 
+ .remove() giống detach nhưng không lưu lại
+ .unwrap() xoá parent của matched set
----------------------------------------------------------------------------------------
DOM REPLACEMENT
+ .replaceAll(target) 
  vd: $( "<h2>New heading</h2>" ).replaceAll( ".inner" ); 
  thây tất cả những thằng có class inner bằng h2 
  Nếu 2 thằng replace cho nhau thì thằng target sẽ bị xóa (cả data + event handler), thằng source sẽ move tới chỗ  thằng target
+ .replaceWith() giống replaceAll nhưng đảo ngược
----------------------------------------------------------------------------------------
GENERAL ATTRIBUTE 
+ .attr("attribute name") trả về attribute value của THẰNG ĐẦU TIÊN trong matched set. để lấy của từng thằng, sử dụng loop .each() hoặc .map()
+ .prop() trả về property value của THẰNG ĐẦU TIÊN 
+ .removeAttr("attribute name") xóa attribute khỏi TỪNG thằng trong matched set
+ .remmoveProp() tương tự removeAttr
+ .val() lấy element value của thằng đầu tiên trong set. 
-------------------------------------------------------------------------------
+ .css("propertyName"/"propertyName", "value") lấy/set computed style properties của thằng đầu tiên trong matched set
+ .height() trả lại chiều cao ko kèm theo "px" trong khi css("height") trả lại 400px 
  .height(value/fucntion)
  .width()
+ .innerHeight(_blank/value/functions) lấy/set padding + height của first element (ko có px)
  .innerWidth() 
+ .offset() lấy tọa độ của first element theo document trả về object chứa top và left
+.outerHeight(_blank/true/value) lấy /set height ( tính luôn border or margin)
 .outerWidth()
+ .position() lấy vị trí của first element theo parent của nó
+ .scrollLeft()/scrollTop() lấy/set vị trí của scroll bar
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
METHOD 
+ .each(function) 
vd:  $( "div" ).each(function( i ) {
  if ( this.style.color !== "blue" ) {
    this.style.color = "blue";
  } else {
    this.style.color = "";
  }
});
+ .data([key,value],[key]) store/lấy data vào element
+ .removeData("key","key2") xóa data
+.get(index) lấy html elemnt trong jquery object
+.index(,selector,element) lấy index của thằng nào đó trong matched set

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EFFECTS
+ .animate( properties [, duration ] [, easing ] [, complete ] ) thêm animation 
+ .clearQueue([queueName]) đừng đang hoạt động hoặc bỏ animation đang hoạt động 
+ .delay( duration [, queueName ] ) 
+ .dequeue() lấy next animation trong quêue để xài cho matched hiện tại
+ .finish chấm dứt tất cả animation (kể quả queue) vẫn chạy tới kết quả cuối
+ jQuery.fx.interval chỉnh fps của animation
+ .queue   (nên theo sau bằng dequeue đê animation sau đc chayj tiếp)
        vd:  $( "div" )
          .show( "slow" )
          .animate({ left: "+=200" }, 2000 )
          .queue(function() {
           $( this ).addClass( "newcolor" ).dequeue();
          })
          .animate({ left: "-=200" }, 500 )
          .queue(function() {
           $( this ).removeClass( "newcolor" ).dequeue();
          })
          .slideUp();
.queue( "fx", [] ) dừng animation, giữ trạng thái hiện tại

+.stop() dừng animation đang chạy 
 .stop(clearQueue,jumpToEnd) https://api.jquery.com/finish/
 ----------------------------------------------------------------
 FADING 
 + .fadeIn() , .fadeOut(), .fadeToggle()
 + .fadeTo( duration, opacity [, complete ] )
 vd : .fadeTo( "slow" , 0.5, function() {
  // Animation complete.
});

+ slideUp(), slideDown() .slideToggle()
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EVENTS 
multiple events, same handler: 
$( selector ).on(
    "event1 event2", 
    function() {    }
);
Multiple events, Different handler:
$( selector ).on({
    "event1": function() { },
    "event2": function() {  }
});

BROWSER EVENT 
+ .error()  (short cut của .on( "error", handler ).)
+ .resize() khi browser đổi kích thước 
+ scroll()
2 cái dưới hay attach cho window object
vd: $( window ).scroll(function() {
  $( "span" ).css( "display", "inline" ).fadeOut( "slow" );
});
------------------------------------------------------------------
DOCUMENT LOADING
$.holdReady(true/false) hold xong nhớ thả. thưởng để  ngay sau script source jquery
$.ready()
.ready()
.load() call event handler khi element load xong hoặc các element con load xong (thường xài vs window, image)
.unload() phải bound với window object. xảy ra khi load page khác, next hoặc back, close browser
-------------------------------------------------------------------------
EVENT HANDLER ATTACHMENT
+ .bind() = .on()
+ .delegated() từ 3.0 ko xài nữa thay bằng on()
+ .live() gắn event handler vào matched element, kể cả trong tương lai
cũng bị thay bởi on
không chain đc , mỗi lần chạy lại dò selector lại từ đầu
+ .die() gỡ event handler đc gắn bởi live
+ .off() :gỡ event handler 
+ .one() event handler chỉ được gọi 1 lần, vd : chỉ click 1 lần, mấy lần click sau ko làm gì
+ .trigger() call tất cả các event hanlder đc gắn vs element theo event type
MOUSE EVENT:
+ .contextmenu() : click phải 
+ .dblclick()
+ .hover(handlerIn,handerOut)
+ .mouseup() 
+ .mousedown()
+ .click() +>  CHỈ CHẠY KHI MOUSE DOWN VÀ UP BÊN TRÊN ELEMENT.
+ mouseenter() vs mouseover() hover khi di chuyển chuột bên trong element thì nó vẫn trigger
+mouseleave() vs mouseout() mouseleave  chỉ trigger với element nó gắn vs, ko tính con cháu chắt chít
KEYBOARD EVENT 
+ .keydown vs keypress: non-printing key : shift, delete, esc ko trigger key press.
keypress xác định ký tự nào được nhập trong khi keypress và key down xác định key nào đc ấn
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
