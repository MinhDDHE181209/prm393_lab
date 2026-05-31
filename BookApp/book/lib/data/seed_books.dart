import '../models/book.dart';
import '../models/chapter.dart';

/// Dữ liệu mẫu — chỉ dùng để upload lên Firestore lần đầu.
class SeedBooks {
  static const List<Book> all = [
    Book(
      id: 'book_1',
      title: 'Đắc Nhân Tâm',
      author: 'Dale Carnegie',
      description:
          'Nghệ thuật thu phục lòng người — cuốn sách kinh điển về giao tiếp và ứng xử.',
      chapters: [
        Chapter(
          id: 'ch_1_1',
          title: 'Chương 1: Nếu muốn thu phục lòng người',
          content:
              'Nếu bạn muốn thu phục lòng người, đừng bao giờ chỉ trích, phê phán hay oán trách họ. Hãy thử hiểu họ. Hãy tự hỏi: "Tại sao người đó lại làm như vậy?"\n\nĐiều này có vẻ đơn giản, nhưng lại là nguyên tắc quan trọng nhất trong mọi mối quan hệ. Khi ta hiểu động cơ của người khác, ta sẽ dễ dàng tha thứ và hợp tác hơn.\n\nMỗi con người đều muốn được tôn trọng, được lắng nghe và được công nhận. Khi bạn thể hiện sự quan tâm chân thành, bạn đã mở ra cánh cửa đầu tiên để xây dựng mối quan hệ tốt đẹp.\n\nHãy nhớ rằng: sự chỉ trích thường chỉ khiến người ta phòng thủ và kháng cự. Thay vào đó, hãy bắt đầu bằng lời khen ngợi chân thành và sự đồng cảm thực sự.',
        ),
        Chapter(
          id: 'ch_1_2',
          title: 'Chương 2: Sáu cách để được yêu mến',
          content:
              'Muốn được yêu mến, hãy quan tâm đến người khác một cách chân thành. Hãy mỉm cười, gọi tên họ, lắng nghe và khuyến khích họ nói về bản thân.\n\nSáu nguyên tắc cơ bản:\n\n1. Quan tâm thật sự đến người khác.\n2. Mỉm cười — nụ cười là ngôn ngữ chung của sự thân thiện.\n3. Gọi tên người đối diện — tên là âm thanh ngọt ngào nhất.\n4. Lắng nghe chăm chú và khuyến khích người khác nói.\n5. Nói về điều người khác quan tâm.\n6. Làm cho người khác cảm thấy quan trọng — và làm một cách chân thành.\n\nNhững điều tưởng chừng nhỏ bé này tạo nên sự khác biệt lớn trong cuộc sống hàng ngày.',
        ),
        Chapter(
          id: 'ch_1_3',
          title: 'Chương 3: Cách thuyết phục người khác',
          content:
              'Để thuyết phục người khác, tránh tranh cãi. Hãy bắt đầu bằng sự đồng thuận, đặt câu hỏi thay vì ra lệnh, và để người khác cảm thấy ý tưởng là của họ.\n\nKhi bạn muốn thay đổi ai đó, đừng bắt đầu bằng việc chỉ ra sai lầm. Hãy khen ngợi trước, sau đó nhẹ nhàng góp ý.\n\nMột trong những cách hiệu quả nhất là đặt câu hỏi để người khác tự nhận ra vấn đề. Con người thường tin vào những gì họ tự khám phá hơn là những gì được nói với họ.\n\nCuối cùng, hãy để người khác lưu giữ phẩm giá. Mọi người đều muốn cảm thấy mình đúng và được tôn trọng.',
        ),
      ],
    ),
    Book(
      id: 'book_2',
      title: 'Nhà Giả Kim',
      author: 'Paulo Coelho',
      description:
          'Hành trình tìm kiếm kho báu và khám phá bản thân của chàng chăn cừu Santiago.',
      chapters: [
        Chapter(
          id: 'ch_2_1',
          title: 'Chương 1: Giấc mơ về kho báu',
          content:
              'Santiago là một chàng chăn cừu trẻ sống ở vùng Andalusia, Tây Ban Nha. Mỗi đêm, anh mơ về một kho báu ẩn giấu dưới các kim tự tháp ở Ai Cập.\n\nMột ngày, anh gặp một vị vua bí ẩn tại quảng trường thị trấn. Vị vua khuyên anh theo đuổi giấc mơ và lắng nghe dấu hiệu của vũ trụ.\n\n"Khi bạn muốn một điều gì đó, cả vũ trụ sẽ hợp lại giúp bạn đạt được nó," vị vua nói.\n\nSantiago quyết định bán đàn cừu và bắt đầu cuộc hành trình. Anh không biết rằng con đường phía trước sẽ dạy anh nhiều điều hơn bất kỳ kho báu vật chất nào.',
        ),
        Chapter(
          id: 'ch_2_2',
          title: 'Chương 2: Người bán pha lê',
          content:
              'Santiago đến Tangier và bị lừa mất hết tiền. Trong lúc tuyệt vọng, anh tìm việc tại một cửa hàng pha lê.\n\nChủ cửa hàng là người tốt bụng nhưng đã từ bỏ ước mơ đi hành hương Mecca vì sợ sau khi đạt được sẽ không còn gì để mong đợi.\n\nSantiago làm việc chăm chỉ và học được nghề buôn bán. Anh kiếm đủ tiền để tiếp tục hành trình, nhưng cũng nhận ra rằng đôi khi con người sợ thay đổi hơn là sợ thất bại.\n\nCuộc gặp gỡ này dạy anh rằng mỗi người đều có một "Personal Legend" — sứ mệnh riêng mà cuộc đời giao phó.',
        ),
        Chapter(
          id: 'ch_2_3',
          title: 'Chương 3: Sa mạc và lữ quán',
          content:
              'Santiago gia nhập đoàn lữ hành qua sa mạc Sahara, hướng tới một oasis nơi có người thầy alchemist sống.\n\nTrên đường đi, anh học cách lắng nghe sa mạc, gió và trái tim mình. Tại oasis, anh gặp Fatima — người phụ nữ khiến anh muốn dừng lại.\n\nNhưng alchemist xuất hiện và nhắc anh: "Tình yêu không ngăn cản bạn thực hiện Personal Legend. Ngược lại, nó khuyến khích bạn tiến lên."\n\nSantiago tiếp tục hành trình với alchemist, học về sự biến đổi và lòng tin vào chính mình.',
        ),
      ],
    ),
    Book(
      id: 'book_3',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      description:
          'Lược sử loài người — từ thời kỳ đồ đá đến thời đại công nghệ.',
      chapters: [
        Chapter(
          id: 'ch_3_1',
          title: 'Chương 1: Một loài không đáng kể',
          content:
              'Cách đây 13,5 tỷ năm, vật chất, năng lượng, thời gian và không gian xuất hiện trong Big Bang. Cách đây 300.000 năm, Homo sapiens xuất hiện ở Đông Phi.\n\nTrong phần lớn lịch sử, con người không phải là loài vượt trội nhất. Chúng ta sống ở tầng giữa của chuỗi thức ăn, săn mồi nhỏ và tránh các động vật lớn.\n\nĐiều làm nên sự khác biệt của Homo sapiens là khả năng hợp tác linh hoạt với số lượng lớn người lạ. Không phải bộ não to hay cơ thể khỏe, mà là khả năng tạo ra và tin vào những câu chuyện chung — tôn giáo, quốc gia, tiền tệ, pháp luật.',
        ),
        Chapter(
          id: 'ch_3_2',
          title: 'Chương 2: Cách mạng Nông nghiệp',
          content:
              'Cách đây khoảng 10.000 năm, con người bắt đầu trồng trọt và chăn nuôi. Đây được gọi là Cách mạng Nông nghiệp — một bước ngoặt lớn nhất trong lịch sử loài người.\n\nNhiều người cho rằng đây là tiến bộ, nhưng Harari lập luận rằng lúa mì đã "thu phục" con người hơn là ngược lại. Nông dân phải làm việc cật lực hơn thợ săn-gatherer, ăn uống kém đa dạng hơn và dễ mắc bệnh hơn.\n\nTuy nhiên, nông nghiệp cho phép dân số tăng vọt và xã hội phân tầng phức tạp hình thành. Từ đó xuất hiện vua chúa, quan lại, binh lính và các hệ thống quyền lực mà chúng ta vẫn thấy đến ngày nay.',
        ),
        Chapter(
          id: 'ch_3_3',
          title: 'Chương 3: Thống nhất loài người',
          content:
              'Ba lực lượng đã thống nhất loài người trên phạm vi toàn cầu: tiền tệ, đế chế và tôn giáo.\n\nTiền là hệ thống tin tưởng phổ biến nhất mà loài người từng phát minh. Một tờ giấy không có giá trị tự thân, nhưng mọi người đều tin nó có giá trị — và điều đó biến nó thành sự thật.\n\nĐế chế và tôn giáo tạo ra các quy tắc và giá trị chung, cho phép hàng triệu người hợp tác dù không quen biết nhau.\n\nNgày nay, chúng ta đang sống trong thời đại thống nhất toàn cầu chưa từng có — nhưng cũng đối mặt với những thách thức mới về bản sắc, quyền lực và ý nghĩa cuộc sống.',
        ),
      ],
    ),
  ];
}
