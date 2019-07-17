/*
Hiểu về (IN, OUT, INOUT) của procedure trong MYSQL. 
- Dùng (in) nghĩa là: được phép truyền một giá trị cụ thể cho 1 hàm procedure (int, varchar(n)date, ...). nghĩa
là bạn có thể truyền thẳng 1 giá trị vào hoặc có thể truyền một biến mà nó mang sẵn 1 giá trị cụ thể
- Dùng (out) nghĩa là: chỉ được phép truyền vào một biến (global: @x) nào đó, nếu bạn cố ý truyền một giá trị cụ 
thể như thằng (in) thì nó sẽ không nhận, và chương trình có thể báo lỗi.
kết thúc việc call 1 procedure thì biến @x vẫn lưu trữ giá trị nó nhận được và vì nó là biến global nên có thích thì 
có thể dùng bất cứ khi nào. 
- Dùng (inout) nghĩa là: 
*/

/*
IN - là chế độ mặc định. Khi bạn xác định tham số IN trong một thủ tục được lưu trữ, chương trình gọi phải 
chuyển một đối số cho thủ tục được lưu trữ. Ngoài ra, giá trị của tham số IN được bảo vệ. Điều đó có nghĩa 
là ngay cả giá trị của tham số IN cũng bị thay đổi bên trong thủ tục được lưu trữ, giá trị ban đầu của nó được 
giữ lại sau khi thủ tục được lưu trữ kết thúc. Nói cách khác, thủ tục được lưu trữ chỉ hoạt động trên bản sao 
của tham số IN.

OUT - giá trị của tham số OUT có thể được thay đổi bên trong thủ tục được lưu trữ và giá trị mới của nó được 
chuyển trở lại chương trình gọi. Lưu ý rằng thủ tục được lưu trữ không thể truy cập giá trị ban đầu của 
tham số OUT khi nó bắt đầu.

INOUT - một tham số INOUT là sự kết hợp của các tham số IN và OUT. Điều đó có nghĩa là chương trình 
gọi có thể vượt qua đối số và thủ tục được lưu trữ có thể sửa đổi tham số INOUT và chuyển giá trị mới 
trở lại chương trình gọi.
*/

/*
Biến global có thể được thay đổi bất cứ khi nào mình thích
*/