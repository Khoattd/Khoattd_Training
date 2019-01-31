ACTIVE RECORD BASICS 
là model 
chịu trách nhiệm business data and logic 
mỗi model class refer 1 table, các attribute là các row 
NAMING CONVENTION 
    database table : Plural, underscore separating word vd: line_items
        forein_keys: thêm _id sau tên vd: item_id
        primary_keys: 
    Model Class : Singular,  chữ đầu capitalize Vd: LineItem